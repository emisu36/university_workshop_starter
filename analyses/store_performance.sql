SELECT 
    s.store_name,
    count(distinct o.customer_id) as customers,
    avg(o.order_total) as avg_order_value
FROM `jaffle-shop-496302.dbt_emsu3617.stg_orders` o
JOIN `jaffle-shop-496302.dbt_emsu3617.stg_stores` s ON s.store_id = o.store_id
GROUP BY s.store_name
ORDER BY avg_order_value DESC