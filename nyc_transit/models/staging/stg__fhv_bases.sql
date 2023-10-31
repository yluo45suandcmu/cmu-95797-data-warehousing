with source as (

    select * from {{ source('main', 'fhv_bases') }}

),

select * from source
