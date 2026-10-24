{{ config(
    materialized='ephemeral'
)}}

with
    source as (select * from {{ source('raw', 'runways') }} ),

    renamed as (
        select
            cast(id as int64)                               as runway_id,           --! primary key
            cast(airport_ref as int64)                      as airport_ref,         --* foreign key to airports 
            cast(airport_ident as string)                   as airport_ident,       --* foreign key to airports 
            cast(length_ft as int64)                        as runway_length_ft,
            cast(width_ft as int64)                         as runway_width_ft,
            cast(surface as string)                         as runway_surface,
            coalesce(cast(lighted as int64) = 1, false)     as runway_lighted,      --  change to bool
            coalesce(cast(closed as int64) = 1, false)      as runway_closed        --  change to bool
        from
            source
    )
select * from renamed
