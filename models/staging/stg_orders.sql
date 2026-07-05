{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('raw', 'raw_orders') }}
)

SELECT
    CAST(id AS STRING)              AS order_id,
    CAST(customer_id AS STRING)     AS customer_id,
    LOWER(status)                   AS status,
    ROUND(amount / 100.0, 2)        AS amount_eur,
    CAST(created_at AS TIMESTAMP)   AS created_at

FROM source
WHERE
    status NOT IN ('draft', 'test')
    AND amount IS NOT NULL
    AND amount > 0
