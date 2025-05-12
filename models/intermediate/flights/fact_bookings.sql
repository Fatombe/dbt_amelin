{{
  config(
    materialized = 'table'
    )
}}

select *
from {{ ref('stg_flights__bookings') }}