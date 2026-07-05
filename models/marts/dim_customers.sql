{{ config(materialized='table') }}

SELECT
    c.customer_id,
    c.email,
    c.first_name,
    c.last_name,
    c.country,
    c.created_at,
    COUNT(o.order_id)                   AS total_orders,
    COALESCE(SUM(o.order_amount), 0)    AS total_spent_eur

FROM {{ ref('stg_customers') }} c
LEFT JOIN {{ ref('fct_orders') }} o USING (customer_id)
GROUP BY 1, 2, 3, 4, 5, 6
