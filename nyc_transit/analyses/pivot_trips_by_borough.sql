SELECT PIVOT {{ ref('mart__fact_trips_by_borough')}}
ON borough USING number_of_trips 