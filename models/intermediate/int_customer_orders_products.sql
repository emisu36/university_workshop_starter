with orders as (
    select * from {{ ref('stg_orders') }}
),

items as (
    select * from {{ ref('stg_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

final as (
    select
        o.customer_id,
        o.order_id,
        o.order_total,
        o.order_date,
        p.product_type,
        p.product_name,
        p.product_price
    from orders o
    join items i on i.order_id = o.order_id
    join products p on p.sku = i.sku
)

select * from final