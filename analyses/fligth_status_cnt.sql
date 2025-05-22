{%- set status_query %}
    SELECT DISTINCT status
    FROM {{ ref('stg_flights__flights') }}
{% endset -%}

{%- set status_query_result = run_query(status_query)%}

{%- if execute %}
    {% set unique_status = status_query_result.columns[0] %}
{%- else %}
    {% set unique_status = [] %}
{%- endif -%}

SELECT 
    {%- for i in unique_status %}
    SUM(CASE WHEN status = '{{i}}' THEN 1 ELSE 0 END) as status_{{i|replace(' ', '')}}{% if not loop.last%},{% endif %}
    {%- endfor %}
FROM {{ ref('stg_flights__flights') }}