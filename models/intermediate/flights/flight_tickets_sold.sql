{{
  config(
    materialized = 'table',
    )
}}

select flight_id, count(ticket_no) as ticket_no
from {{ ref('fct_ticket_flights') }}
group by flight_id