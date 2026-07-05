{{ config(materialized='view') }}

SELECT
    id                          AS payment_id,
    order_id,
    ROUND(amount / 100.0, 2)    AS amount_eur,
    status,
    created_at::timestamp       AS paid_at

FROM {{ source('raw', 'raw_payments') }}
WHERE status = 'succeeded'
