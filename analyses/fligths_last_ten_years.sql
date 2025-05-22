{% set current_date = run_started_at|string|truncate(10, True, "") %}
{% set current_year = run_started_at|string|truncate(4, True, "")|int %}
{% set prev_year = current_year - 10 %}
{% set prev_date = run_started_at|string|truncate(10, True, "")|replace(current_year|string, prev_year|string) %}

SELECT COUNT(*)
FROM {{ ref('fct_flights') }}
WHERE scheduled_departure::date between '{{prev_date}}' and '{{ current_date }}'