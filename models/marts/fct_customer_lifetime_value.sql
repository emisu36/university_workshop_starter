with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

items as (
    select * from {{ ref('stg_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

customer_orders as (
    select
        o.customer_id,
        count(distinct o.order_id)           as total_orders,
        sum(o.order_total)                   as lifetime_value,
        avg(o.order_total)                   as avg_order_value,
        min(o.order_date)                    as first_order_date,
        max(o.order_date)                    as last_order_date
    from orders o
    group by 1
),

customer_products as (
    select
        o.customer_id,
        p.product_type,
        count(*)                             as items_purchased
    from orders o
    join items i on i.order_id = o.order_id
    join products p on p.sku = i.sku
    group by 1, 2
),

favourite_product_type as (
    select
        customer_id,
        product_type                         as favourite_product_type
    from customer_products
    qualify row_number() over (
        partition by customer_id
        order by items_purchased desc
    ) = 1
),

final as (
    select
        c.customer_id,
        c.customer_name,
        co.total_orders,
        co.lifetime_value,
        co.avg_order_value,
        co.first_order_date,
        co.last_order_date,
        fp.favourite_product_type
    from customers c
    left join customer_orders co on co.customer_id = c.customer_id
    left join favourite_product_type fp on fp.customer_id = c.customer_id
)

select * from final