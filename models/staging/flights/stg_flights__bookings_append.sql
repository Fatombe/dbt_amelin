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
    {{kop_to_ruble("total_amount", 2)}} as total_amount
from {{ source("demo_src", "bookings") }}

{%- if is_incremental() %}
where {{ bookref_to_bigint("book_ref") }} > (select MAX({{ bookref_to_bigint("book_ref") }}) from {{this}})
{% endif %}