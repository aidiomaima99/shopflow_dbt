{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('raw', 'raw_orders') }}
)

SELECT
    id                              AS order_id,
    customer_id,
    LOWER(status)                   AS status,
    ROUND(amount / 100.0, 2)        AS amount_eur,
    created_at::timestamp           AS created_at

FROM source
WHERE
    status NOT IN ('draft', 'test')
    AND amount IS NOT NULL
    AND amount > 0
