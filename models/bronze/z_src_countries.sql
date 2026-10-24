{{ config(
    enabled=false
) }}

with
    source as (select * from {{ source('raw', 'countries') }} ),

    renamed as (
        select
            cast(id as int64) as id,
            cast(code as string) as code,
            cast(name as string) as name,
            cast(continent as string) as continent,
            cast(wikipedia_link as string) as wikipedia_link,
            cast(keywords as string) as keywords
        from
            source
    )
select * from renamed
