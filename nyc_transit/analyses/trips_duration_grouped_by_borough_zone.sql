SELECT
    l.borough,
    l.zone,
    COUNT(*) AS number_of_trips,
    AVG(t.duration_min) AS average_duration_minutes
FROM {{ ref('mart__fact_all_taxi_trips') }} as t
JOIN {{ ref('mart__dim_locations') }} as l ON t.pulocationid = l.locationid
GROUP BY l.borough, l.zone;
