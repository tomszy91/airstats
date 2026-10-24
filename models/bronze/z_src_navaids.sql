{{ config(
    enabled=false
) }}

with
    source as (select * from {{ source('raw', 'navaids') }} ),

    renamed as (
        select
            cast(id as int64) as id,
            cast(filename as string) as filename,
            cast(ident as string) as ident,
            cast(name as string) as name,
            cast(type as string) as type,
            cast(frequency_khz as int64) as frequency_khz,
            cast(latitude_deg as float64) as latitude_deg,
            cast(longitude_deg as float64) as longitude_deg,
            cast(elevation_ft as int64) as elevation_ft,
            cast(iso_country as string) as iso_country,
            cast(dme_frequency_khz as int64) as dme_frequency_khz,
            cast(dme_channel as string) as dme_channel,
            cast(dme_latitude_deg as float64) as dme_latitude_deg,
            cast(dme_longitude_deg as float64) as dme_longitude_deg,
            cast(dme_elevation_ft as int64) as dme_elevation_ft,
            cast(slaved_variation_deg as float64) as slaved_variation_deg,
            cast(magnetic_variation_deg as float64) as magnetic_variation_deg,
            cast(usagetype as string) as usagetype,
            cast(power as string) as power,
            cast(associated_airport as string) as associated_airport
        from
            source
    )
select * from renamed
