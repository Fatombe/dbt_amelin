{{
    config(
        materialized="table",
        tags = ['bookings'],
        on_configuration_change="fail",
        indexes=[
        {
            "columns": ["book_date"],
            "unique": false
        }
    ]
) 
}}

select 
    book_ref, 
    book_date, 
    total_amount
from {{ source("demo_src", "bookings") }}
{% if is_incremental() %}
where book_ref > (select MAX(book_ref) from {{this}})
{% endif %}
