SELECT
    l.borough,
    COUNT(*) AS number_of_trips
FROM {{ ref('mart__fact_all_taxi_trips') }} as t
JOIN {{ ref('mart__dim_locations') }} as l ON t.pulocationid = l.locationid
GROUP BY l.borough
