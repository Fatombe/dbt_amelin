{% set aircrafts_codes_with_flights = dbt_utils.get_column_values(table=ref('stg_flights__flights'), column='aircraft_code') %}

SELECT *
FROM {{ ref('stg_flights__aircraft') }}
WHERE aircraft_code IN ('{{aircrafts_codes_with_flights | join("', '")}}')