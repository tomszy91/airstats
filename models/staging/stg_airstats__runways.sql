with
    source as (select * from `agile-fort-512513-d5`.`raw`.`runways` ),

    renamed as (
        select
            cast(id as int64) as id,
            cast(airport_ref as int64) as airport_ref,
            cast(airport_ident as string) as airport_ident,
            cast(length_ft as int64) as length_ft,
            cast(width_ft as int64) as width_ft,
            cast(surface as string) as surface,
            cast(lighted as int64) as lighted,
            cast(closed as int64) as closed,
            cast(le_ident as string) as le_ident,
            cast(le_latitude_deg as float64) as le_latitude_deg,
            cast(le_longitude_deg as float64) as le_longitude_deg,
            cast(le_elevation_ft as int64) as le_elevation_ft,
            cast(le_heading_degt as float64) as le_heading_degt,
            cast(le_displaced_threshold_ft as int64) as le_displaced_threshold_ft,
            cast(he_ident as string) as he_ident,
            cast(he_latitude_deg as float64) as he_latitude_deg,
            cast(he_longitude_deg as float64) as he_longitude_deg,
            cast(he_elevation_ft as int64) as he_elevation_ft,
            cast(he_heading_degt as float64) as he_heading_degt,
            cast(he_displaced_threshold_ft as int64) as he_displaced_threshold_ft
        from
            source
    )
select * from renamed
