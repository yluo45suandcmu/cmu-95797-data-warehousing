SELECT COUNT(*) AS total_trips_ending_at_airport
FROM {{ ref('mart__fact_all_taxi_trips') }} trips
JOIN {{ ref('mart__dim_locations') }} loc
  ON trips.dolocationid = loc.locationid
WHERE loc.service_zone IN ('Airports', 'EWR')
