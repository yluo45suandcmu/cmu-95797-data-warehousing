with source as (

    select * from {{ source('main', 'fhv_tripdata') }}

),

-- exclude SR_Flag since there is no value in this column
renamed as (
    
    select
        trim(upper(dispatching_base_num)) as  dispatching_base_num, --some ids are lowercase
        pickup_datetime,
        dropOff_datetime,
        PUlocationID,
        DOlocationID,
        trim(upper(affiliated_base_number)) as affiliated_base_number,
        filename
    
    from source

    where
        pickup_datetime <= '2022-12-31' AND 
        dropOff_datetime <= '2022-12-31'  

)

select * from renamed

