with
    source as (select * from `agile-fort-512513-d5`.`raw`.`airports` ),

    renamed as (
        select
            cast(id as int64) as id,
            cast(ident as string) as ident,
            cast(type as string) as type,
            cast(name as string) as name,
            cast(latitude_deg as float64) as latitude_deg,
            cast(longitude_deg as float64) as longitude_deg,
            cast(elevation_ft as int64) as elevation_ft,
            cast(continent as string) as continent,
            cast(iso_country as string) as iso_country,
            cast(iso_region as string) as iso_region,
            cast(municipality as string) as municipality,
            cast(scheduled_service as boolean) as scheduled_service,
            cast(icao_code as string) as icao_code,
            cast(iata_code as string) as iata_code,
            cast(gps_code as string) as gps_code,
            cast(local_code as string) as local_code,
            cast(home_link as string) as home_link,
            cast(wikipedia_link as string) as wikipedia_link,
            cast(keywords as string) as keywords
        from
            source
    )
select * from renamed
