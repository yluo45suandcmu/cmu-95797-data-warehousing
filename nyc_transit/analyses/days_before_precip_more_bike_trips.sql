WITH weather_data AS (
    SELECT
        date,
        CASE WHEN prcp > 0 OR snow > 0 THEN TRUE ELSE FALSE END AS is_precip_or_snow
    FROM {{ ref('stg__central_park_weather') }}
),

bike_trip_counts AS (
    SELECT
        date,
        COUNT(*) AS number_of_trips
    FROM {{ ref('mart__fact_all_bike_trips') }}
    GROUP BY date
),

precip_days AS (
    SELECT
        date,
        LAG(number_of_trips) OVER (ORDER BY date) AS trips_day_before,
        number_of_trips AS trips_on_day
    FROM bike_trip_counts
    JOIN weather_data USING (date)
    WHERE is_precip_or_snow
),

averages AS (
    SELECT
        AVG(trips_day_before) AS avg_trips_day_before,
        AVG(trips_on_day) AS avg_trips_on_day
    FROM precip_days
)

SELECT
    avg_trips_day_before,
    avg_trips_on_day,
    CASE WHEN avg_trips_day_before > avg_trips_on_day THEN 'More trips day before'
         ELSE 'More trips or equal on day of/less trips day before' END AS comparison
FROM averages

