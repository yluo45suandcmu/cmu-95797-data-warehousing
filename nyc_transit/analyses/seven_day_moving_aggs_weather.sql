SELECT 
    date,
    MIN(prcp) OVER seven_day_window AS min_precipitation,
    MAX(prcp) OVER seven_day_window AS max_precipitation,
    AVG(prcp) OVER seven_day_window AS avg_precipitation,
    SUM(prcp) OVER seven_day_window AS sum_precipitation,
    MIN(snow) OVER seven_day_window AS min_snow,
    MAX(snow) OVER seven_day_window AS max_snow,
    AVG(snow) OVER seven_day_window AS avg_snow,
    SUM(snow) OVER seven_day_window AS sum_snow
FROM {{ ref('stg__central_park_weather') }}
WINDOW seven_day_window AS (
    ORDER BY date
    RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND INTERVAL 3 DAYS FOLLOWING
)
