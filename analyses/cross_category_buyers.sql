WITH customer_product_types AS (
    SELECT 
        o.customer_id,
        MAX(CASE WHEN p.product_type = 'jaffle' THEN 1 ELSE 0 END) as bought_jaffle,
        MAX(CASE WHEN p.product_type = 'beverage' THEN 1 ELSE 0 END) as bought_beverage
    FROM `jaffle-shop-496302.dbt_emsu3617.stg_orders` o
    JOIN `jaffle-shop-496302.dbt_emsu3617.stg_items` i ON i.order_id = o.order_id
    JOIN `jaffle-shop-496302.dbt_emsu3617.stg_products` p ON p.sku = i.sku
    GROUP BY 1
)

SELECT
    CASE 
        WHEN bought_jaffle = 1 AND bought_beverage = 1 THEN 'both'
        WHEN bought_jaffle = 1 THEN 'jaffle only'
        WHEN bought_beverage = 1 THEN 'beverage only'
    END as customer_segment,
    COUNT(*) as customer_count,
    AVG(ltv.lifetime_value) as avg_lifetime_value
FROM customer_product_types cpt
JOIN `jaffle-shop-496302.dbt_emsu3617.fct_customer_lifetime_value` ltv 
    ON ltv.customer_id = cpt.customer_id
GROUP BY 1
ORDER BY avg_lifetime_value DESC