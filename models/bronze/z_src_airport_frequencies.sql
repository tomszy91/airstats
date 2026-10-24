{{ config(
    enabled=false
) }}

with
    source as (select * from {{ source('raw', 'airport_frequencies') }} ),

    renamed as (
        select
            cast(id as int64) as id,
            cast(airport_ref as int64) as airport_ref,
            cast(airport_ident as string) as airport_ident,
            cast(type as string) as type,
            cast(description as string) as description,
            cast(frequency_mhz as float64) as frequency_mhz
        from
            source
    )
select * from renamed
