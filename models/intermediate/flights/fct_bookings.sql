{{
  config(
    materialized = 'table',
    meta = { "owner": "sql_file@yahoo.com"}
    )
}}

select
      {{show_columns_relation("stg_flights__bookings")}}
from {{ ref('stg_flights__bookings') }}
{{ limit_data_dev('book_date', 3000) }}