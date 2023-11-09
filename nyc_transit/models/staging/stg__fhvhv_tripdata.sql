with source as (

    select * from {{ source('main', 'fhvhv_tripdata') }}

),

renamed as (
    
    select
        hvfhs_license_num,
        trim(upper(dispatching_base_num)) as dispatching_base_num,
        trim(upper(originating_base_num)) as originating_base_num,
        request_datetime,
        on_scene_datetime,
        pickup_datetime,
        dropoff_datetime,
        pulocationid,
        dolocationid,
        trip_miles,
        trip_time,
        base_passenger_fare,
        tolls,
        bcf,
        sales_tax,
        congestion_surcharge,
        airport_fee,
        tips,
        driver_pay,
        {{ convert_to_boolean('shared_request_flag') }} AS shared_request_flag,
        {{ convert_to_boolean('shared_match_flag') }} AS shared_match_flag,
        {{ convert_to_boolean('access_a_ride_flag') }} AS access_a_ride_flag,
        {{ convert_to_boolean('wav_request_flag') }} AS wav_request_flag,
        {{ convert_to_boolean('wav_match_flag') }} AS wav_match_flag,
        filename
    
    from source

    where
        request_datetime <= '2022-12-31' AND 
        on_scene_datetime <= '2022-12-31' AND 
        pickup_datetime <= '2022-12-31' AND 
        dropoff_datetime <= '2022-12-31'  

)

select * from renamed

