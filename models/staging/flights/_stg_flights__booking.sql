{{
    config(
        materialized="table",
        on_configuration_change="fail",
        indexes=[
        {
            "columns": ["book_date"],
            "unique": false
        }
    ]
) 
}}

select *
from {{ source("demo_src", "bookings") }}
