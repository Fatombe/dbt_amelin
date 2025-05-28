{{
    config(
        materialized="incremental",
        incremental_strategy = "append",
        tags = ['bookings']
) 
}}

select 
    book_ref, 
    book_date, 
    {{kop_to_ruble("total_amount", 2)}} as total_amount
from {{ source("demo_src", "bookings") }}

{%- if is_incremental() %}
WHERE
    {{ bookref_to_bigint('book_ref') }} > (SELECT MAX({{ bookref_to_bigint('book_ref') }}) FROM {{ this }})
{% endif %}