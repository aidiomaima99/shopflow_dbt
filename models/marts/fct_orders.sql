{{ config(materialized='table') }}

WITH order_payments AS (
    SELECT * FROM {{ ref('int_order_payments') }}
),

customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
)

SELECT
    op.order_id,
    op.customer_id,
    c.country,
    op.status,
    op.order_amount,
    op.total_paid_eur,
    op.balance_eur,
    op.payment_count,

    CASE
        WHEN op.order_amount >= 500 THEN 'high_value'
        WHEN op.order_amount >= 100 THEN 'mid_value'
        ELSE 'low_value'
    END                                         AS order_segment,

    DATE(op.created_at)                         AS order_date,
    DATE_TRUNC('month', op.created_at)::date    AS order_month,
    op.created_at,
    op.last_payment_at

FROM order_payments op
LEFT JOIN customers c ON op.customer_id = c.customer_id
