WITH trip_boroughs AS (
    SELECT
        t.type,
        weekday(t.pickup_datetime) AS weekday, -- Extracting the weekday from the pickup datetime
        pl.borough AS start_borough, -- Start borough
        dl.borough AS end_borough -- End borough
    FROM {{ ref('mart__fact_all_taxi_trips') }} t
    LEFT JOIN {{ ref('mart__dim_locations') }} pl ON t.pulocationid = pl.locationid -- Join with pickup location
    LEFT JOIN {{ ref('mart__dim_locations') }} dl ON t.dolocationid = dl.locationid -- Join with dropoff location
)

, borough_trips AS (
    SELECT
        weekday,
        COUNT(*) AS total_trips,
        COUNT(*) FILTER (WHERE start_borough != end_borough) AS inter_borough_trips -- Count trips where start and end boroughs are different
    FROM trip_boroughs
    GROUP BY weekday
)

SELECT
    weekday,
    total_trips,
    inter_borough_trips,
    (inter_borough_trips::FLOAT / total_trips) * 100 AS percent_inter_borough -- Calculate the percentage
FROM borough_trips
ORDER BY weekday;
