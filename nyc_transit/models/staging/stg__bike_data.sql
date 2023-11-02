with source as (

    select * from {{ source('main', 'bike_data') }}

),

renamed as (
    
    select
        tripduration::int as tripduration,
        starttime::timestamp as starttime,
        stoptime::timestamp as stoptime,
        "start station id"::int as "start station id",
        "start station name",
        "start station latitude"::double as "start station latitude",
        "start station longitude"::double as "start station longitude",
        "end station id"::int as "end station id",
        "end station name",
        "end station latitude"::double as "end station latitude",
        "end station longitude"::double as "end station longitude",
        bikeid::int as bikeid,
        usertype,
        "birth year"::int as "birth year",
        {{ convert_gender('gender') }} as gender,
        ride_id,
        rideable_type,
        started_at::timestamp as started_at,
        ended_at::timestamp as ended_at,
        start_station_name,
        start_station_id::double as start_station_id,
        end_station_name,
        end_station_id::double as end_station_id,
        start_lat::double as start_lat,
        start_lng::double as start_lng,
        end_lat::double as end_lat,
        end_lng::double as end_lng,
        member_casual,
        filename

    from source

    where 
        tripduration > 0 AND 
        starttime <= '2022-12-31' AND 
        stoptime <= '2022-12-31' AND 
        started_at <= '2022-12-31' AND 
        ended_at <= '2022-12-31'
)

select * from renamed
