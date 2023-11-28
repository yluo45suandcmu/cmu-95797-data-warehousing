SELECT 
    y.fare_amount,
    l.zone,
    l.borough,
    AVG(y.fare_amount) OVER (PARTITION BY l.borough) AS avg_fare_borough,
    AVG(y.fare_amount) OVER (PARTITION BY l.zone) AS avg_fare_zone,
    AVG(y.fare_amount) OVER () AS avg_fare_overall
FROM {{ ref('stg__yellow_tripdata') }} AS y
JOIN {{ ref('mart__dim_locations') }} AS l ON y.pulocationid = l.locationid
LIMIT 5000 -- limit row to reduce answer txt file under Github's file size limit