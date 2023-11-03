with source as (

    select * from {{ source('main', 'bike_data') }}

),

renamed as (
    
    select
        tripduration::int as tripduration,
        COALESCE(started_at::timestamp, starttime::timestamp) AS started_at,
        COALESCE(ended_at::timestamp, stoptime::timestamp) AS ended_at,
        COALESCE(start_station_id::double, "start station id"::double) AS start_station_id,
        COALESCE(end_station_id::double, "end station id"::double) AS end_station_id,
        COALESCE(start_station_name, "start station name") AS start_station_name,
        COALESCE(end_station_name, "end station name") AS end_station_name,
        COALESCE(start_lat::double, "start station latitude"::double) AS start_lat,
        COALESCE(start_lng::double, "start station longitude"::double) AS start_lng,
        COALESCE(end_lat::double, "end station latitude"::double) AS end_lat,
        COALESCE(end_lng::double, "end station longitude"::double) AS end_lng,
        bikeid::int as bikeid,
        "birth year"::int as birth_year,
        {{ convert_gender('gender') }} as gender,
        ride_id,
        rideable_type,
        COALESCE(member_casual, 
            CASE 
                WHEN usertype = 'Subscriber' THEN 'member' 
                WHEN usertype = 'Customer' THEN 'casual' 
                ELSE usertype 
            END) as member_type,
        filename

    from source

    where 
        tripduration > 0 AND 
        started_at <= '2022-12-31' AND 
        ended_at <= '2022-12-31'
)

select * from renamed
