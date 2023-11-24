WITH trip_times AS (
    SELECT
        l.zone,
        t.pickup_datetime,
        LEAD(t.pickup_datetime, 1) OVER (
            PARTITION BY l.zone
            ORDER BY t.pickup_datetime
        ) AS next_pickup_time
    FROM {{ ref('mart__fact_all_taxi_trips') }} AS t
    JOIN {{ ref('mart__dim_locations') }} AS l ON t.pulocationid = l.locationid
),

pickup_intervals AS (
    SELECT
        zone,
        EXTRACT(EPOCH FROM (next_pickup_time - pickup_datetime)) / 60 AS interval_minutes -- Time difference in minutes
    FROM trip_times
    WHERE next_pickup_time IS NOT NULL
)

SELECT
    zone,
    AVG(interval_minutes) AS avg_time_between_pickups
FROM pickup_intervals
GROUP BY zone;
