{{ config(materialized='view') }}

SELECT
    CAST(id AS STRING)              AS payment_id,
    CAST(order_id AS STRING)        AS order_id,
    ROUND(amount / 100.0, 2)        AS amount_eur,
    status,
    CAST(created_at AS TIMESTAMP)   AS paid_at

FROM {{ source('raw', 'raw_payments') }}
WHERE status = 'succeeded'