SELECT aircraft_code, count(*)
FROM {{ ref('stg_flights__seats') }}
GROUP BY aircraft_code