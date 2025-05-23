{{
    config(
        materialized="incremental",
        incremental_strategy = "append",
        tags = ['bookings']
) 
}}

select 
    {{ bookref_to_bigint("book_ref") }} as book_ref, 
    book_date, 
    {{kop_to_ruble(column_name="total_amount")}} as total_amount
from {{ source("demo_src", "bookings") }}
{%- if is_incremental() %}
where book_ref > (select MAX(book_ref) from {{this}})
{% endif %} 
