{{
  config(
    materialized = 'table',
    meta = { "owner": "sql_file@yahoo.com"}
    )
}}

select book_ref, 
      book_date, 
      total_amount
from {{ ref('stg_flights__bookings') }}
{{ limit_data_dev('book_date') }} 