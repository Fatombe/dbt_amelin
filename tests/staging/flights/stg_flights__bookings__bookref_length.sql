{{
  config(
    severity = 'error',
    warn_if = '>1500000',
    error_if = '>2000000'
    )
}}

SELECT book_ref
FROM {{ ref('stg_flights__bookings') }}
WHERE length(book_ref) > 5