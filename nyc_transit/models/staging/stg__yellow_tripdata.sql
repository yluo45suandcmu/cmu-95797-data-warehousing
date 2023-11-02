with source as (

    select * from {{ source('main', 'yellow_tripdata') }}

),

renamed as (
    
    select
        vendorid,
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        passenger_count,
        trip_distance,
        ratecodeid,
        {{ convert_to_boolean('store_and_fwd_flag') }} AS store_and_fwd_flag,
        pulocationid,
        dolocationid,
        payment_type,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        congestion_surcharge,
        airport_fee,
        filename

    from source

    where
        tpep_pickup_datetime <= '2022-12-31' AND 
        tpep_dropoff_datetime <= '2022-12-31' AND
        trip_distance >= 0 

)

select * from renamed

