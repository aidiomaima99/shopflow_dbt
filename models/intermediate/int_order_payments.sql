{{ config(materialized='table') }}

WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

payments AS (
    SELECT
        order_id,
        SUM(amount_eur)     AS total_paid_eur,
        COUNT(*)            AS payment_count,
        MAX(paid_at)        AS last_payment_at
    FROM {{ ref('stg_payments') }}
    GROUP BY 1
)

SELECT
    o.order_id,
    o.customer_id,
    o.status,
    o.amount_eur                                        AS order_amount,
    COALESCE(p.total_paid_eur, 0)                       AS total_paid_eur,
    COALESCE(p.payment_count, 0)                        AS payment_count,
    o.amount_eur - COALESCE(p.total_paid_eur, 0)        AS balance_eur,
    o.created_at,
    p.last_payment_at

FROM orders o
LEFT JOIN payments p ON o.order_id = p.order_id
