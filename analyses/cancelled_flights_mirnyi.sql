

select scheduled_departure::date as scheduled_departure,
count(*) as cancelled_flights
from {{ ref('fct_flights') }}
where departure_airport = 'MJZ' and status = 'Cancelled'
GROUP BY scheduled_departure::date