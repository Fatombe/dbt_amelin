SELECT COUNT(*)
FROM {{ ref('fct_flights') }}
WHERE scheduled_departure::date >= '{{ run_started_at|string|truncate(10, True, "")}}'