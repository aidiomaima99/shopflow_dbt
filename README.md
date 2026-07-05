# ShopFlow dbt Project

Pipeline de transformation de données e-commerce avec dbt.

## Structure

```
shopflow_dbt/
├── models/
│   ├── staging/          → Nettoyage des sources (VIEW)
│   ├── intermediate/     → Logique métier (TABLE)
│   └── marts/            → Prêts pour BI (TABLE)
├── tests/                → Tests singuliers custom
├── seeds/                → Données de test CSV
└── dbt_project.yml       → Configuration principale
```

## DAG

```
raw_orders ──────┐
                 ├── stg_orders ────┐
raw_customers ───┘                  ├── int_order_payments ──► fct_orders
                 stg_payments ──────┘
raw_customers ──► stg_customers ──────────────────────────► dim_customers
```

## Commandes

```bash
dbt seed              # Charger les données CSV
dbt run               # Exécuter les modèles
dbt test              # Lancer les tests
dbt build             # seed + run + test en une fois
dbt docs generate     # Générer la documentation
dbt docs serve        # Lancer le site sur localhost:8080
```

## Tests configurés

| Modèle | Colonne | Test |
|--------|---------|------|
| fct_orders | order_id | unique, not_null |
| fct_orders | status | accepted_values |
| fct_orders | customer_id | not_null, relationships |
| fct_orders | order_amount | not_null |
| dim_customers | customer_id | unique, not_null |
| dim_customers | email | unique, not_null |
| Custom | fct_orders | assert_revenue_positive |
| Custom | fct_orders | assert_no_future_orders |

## Master Big Data & IA — Module Business Intelligence
### AIDI Omaima · ELMOUSAOUI Fatima · 2025/2026
