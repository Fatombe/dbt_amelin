{%- set aircraft_code_query %}
    SELECT DISTINCT aircraft_code
    FROM {{ ref('fct_flights') }}
{%- endset %}


{%- set aircraft_code_query_result = run_query(aircraft_code_query) %}

{%- if execute -%}
    {% set important_aircraft = aircraft_code_query_result.columns[0] %}
{%- else%}
    {% set important_aircraft = [] %}
{%- endif %}

SELECT
    {%- for aircraft in important_aircraft %}
    SUM(CASE WHEN aircraft_code = '{{aircraft}}' THEN 1 ELSE 0 END) as flight_{{aircraft}} 
        {%- if not loop.last %},{%- endif %}
    {%- endfor %}
FROM {{ ref('fct_flights') }}