-- Test singulier : aucune commande ne doit avoir une date dans le futur
-- dbt attend 0 lignes retournées = PASS

SELECT
    order_id,
    created_at
FROM {{ ref('fct_orders') }}
WHERE DATE(created_at) > CURRENT_DATE
