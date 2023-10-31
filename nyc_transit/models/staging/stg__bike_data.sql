with source as (

    select * from {{ source('main', 'bike_data') }}

),

renamed as (
    
    select
        tripduration::int as tripduration,
        starttime::timestamp as starttime,
        stoptime::timestamp as stoptime,
        'start station id':: 

    
    from source

)

select * from renamed
