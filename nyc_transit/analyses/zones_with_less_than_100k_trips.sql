SELECT l.zone, COUNT(*) AS trip_count
FROM {{ ref('mart__fact_all_taxi_trips') }} AS t
JOIN {{ ref('mart__dim_locations') }} AS l ON t.pulocationid = l.locationid
GROUP BY l.zone
HAVING COUNT(*) < 100000;