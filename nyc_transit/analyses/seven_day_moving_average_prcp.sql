SELECT 
    date,
    AVG(prcp) OVER (
        ORDER BY date
        RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND INTERVAL 3 DAYS FOLLOWING
    ) AS seven_day_moving_avg_prcp
FROM {{ ref('stg__central_park_weather') }}
