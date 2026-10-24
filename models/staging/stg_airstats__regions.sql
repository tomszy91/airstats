with
    source as (select * from `agile-fort-512513-d5`.`raw`.`regions` ),

    renamed as (
        select
            cast(id as int64) as id,
            cast(code as string) as code,
            cast(local_code as string) as local_code,
            cast(name as string) as name,
            cast(continent as string) as continent,
            cast(iso_country as string) as iso_country,
            cast(wikipedia_link as string) as wikipedia_link,
            cast(keywords as string) as keywords
        from
            source
    )
select * from renamed
