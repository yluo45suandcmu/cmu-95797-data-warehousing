with source as (

    select * from {{ source('main', 'fhv_bases') }}

),

renamed as (
    
    select
        base_number,
        TRIM(base_name) as base_name,
        TRIM(dba) as doing_business_as,
        dba_category,
        filename
    
    from source

)

select * from renamed
