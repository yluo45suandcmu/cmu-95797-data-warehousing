with source as (

    select * from {{ source('main', 'green_tripdata') }}

),

-- exclude ehail_fee since there is no value in this column
renamed as (
    
    select
        vendorid,
        lpep_pickup_datetime,
        lpep_dropoff_datetime,
        {{ convert_to_boolean('store_and_fwd_flag') }} AS store_and_fwd_flag,
        ratecodeid,
        pulocationid,
        dolocationid,
        passenger_count::int as passenger_count,
        trip_distance,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        payment_type,
        trip_type,
        congestion_surcharge,
        filename

    
    from source

    where
        lpep_pickup_datetime <= '2022-12-31' AND 
        lpep_dropoff_datetime <= '2022-12-31' AND
        trip_distance >= 0 

)

select * from renamed

