{{
  config(
    materialized = 'table',
    meta = { "owner": "sql_file@yahoo.com"}
    )
}}

select book_ref, 
      book_date, 
      total_amount,
      {{ dbt_utils.generate_surrogate_key(['book_ref']) }} as book_ref_surkye
from {{ ref('stg_flights__bookings') }}
{{ limit_data_dev('book_date') }} 