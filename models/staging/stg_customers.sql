{{ config(materialized='view') }}

SELECT
    id                            AS customer_id,
    LOWER(email)                  AS email,
    first_name,
    last_name,
    country,
    CAST(created_at AS TIMESTAMP) AS created_at
FROM {{ source('raw', 'raw_customers') }}
WHERE is_deleted = FALSE