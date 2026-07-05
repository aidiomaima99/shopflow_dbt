-- Test singulier : aucun montant de commande ne doit être <= 0
-- dbt attend 0 lignes retournées = PASS

SELECT
    order_id,
    order_amount
FROM {{ ref('fct_orders') }}
WHERE order_amount <= 0
