{{
  config(
    materialized = 'table',
    )
}}



select
    ff.flight_id,
    ff.status as ffight_status,
    ff.aircraft_code, 
    da.airport_code as departure_airport_code,
    da.airport_name as departure_airport_name,
    da.city as departure_airport_city,
    da.coordinates as departure_airport_coordinates,
    aa.airport_code as arrival_airport_code,
    aa.airport_name as arrival_airport_name,
    aa.city as arrival_airport_city,
    aa.coordinates as arrival_airport_coordinates,
    airc.model as aircraft_model,
    ftf.ticket_no as ticket_flights_purchased

from
    {{ ref('fct_flights') }} ff
    inner join {{ ref('dim_airports') }} aa
        on ff.arrival_airport = aa.airport_code
        and ff.actual_arrival IS NOT NULL
    inner join {{ ref('dim_airports') }} da 
        on ff.departure_airport = da.airport_code
        and ff.actual_departure IS NOT NULL
    inner join {{ ref('dim_aircrafts') }} airc
        on ff.aircraft_code = airc.aircraft_code
        and ff.actual_arrival IS NOT NULL
    inner join {{ ref('dim_aircraft_seats') }} ars
        on ars.aircraft_code = ff.aircraft_code
        and ff.actual_arrival IS NOT NULL
    left join {{ ref('flight_tickets_sold') }} ftf
        on ftf.flight_id = ff.flight_id