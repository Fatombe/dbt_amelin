SELECT total_amount
FROM {{ ref('stg_flights__bookings') }}
WHERE total_amount > 1000000 and total_amount <= 0