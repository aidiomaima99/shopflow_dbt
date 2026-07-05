{{ config(materialized='view') }}

SELECT
    id              AS customer_id,
    LOWER(email)    AS email,
    first_name,
    last_name,
    country,
    created_at::timestamp AS created_at

FROM {{ source('raw', 'raw_customers') }}
WHERE is_deleted = FALSE
