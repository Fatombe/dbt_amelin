{{
  config(
    severity = 'error',
    error_if = '>100',
    warn_if = '>50'
    )
}}

SELECT book_ref, count(*) as ticket_number
FROM {{ ref('stg_flights__tickets') }}
GROUP BY book_ref