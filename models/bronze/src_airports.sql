with
    source as (select * from {{ source('raw', 'airports') }} ),

    renamed as (
        select
            cast(id as int64)                   as airport_id,                --* actual primary key
            cast(ident as string)               as airport_ident,             --! primary key for interoperability
            cast(type as string)                as airport_type,
            cast(name as string)                as airport_name,
            cast(latitude_deg as float64)       as airport_lat,
            cast(longitude_deg as float64)      as airport_long,
            st_geogpoint(
                cast(longitude_deg as float64),
                cast(latitude_deg as float64))  as airport_location,
            cast(continent as string)           as continent,
            upper(cast(iso_country as string))  as iso_country,
            upper(cast(iso_region as string))   as iso_region
        from
            source
    )
select * from renamed