SELECT 
    product_name,
    product_type,
    count(*) as times_ordered,
    avg(product_price) as price
FROM `jaffle-shop-496302.dbt_emsu3617.stg_items` i
JOIN `jaffle-shop-496302.dbt_emsu3617.stg_products` p ON p.sku = i.sku
GROUP BY 1, 2
ORDER BY times_ordered DESC