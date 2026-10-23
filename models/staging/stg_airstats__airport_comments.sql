with
    source as (select * from `agile-fort-512513-d5`.`raw`.`airport_comments` ),

    renamed as (
        select
            cast(id as int64) as id,
            cast(threadref as float64) as threadref,
            cast(airportref as int64) as airportref,
            cast(airportident as string) as airportident,
            cast(date as timestamp) as date,
            cast(membernickname as string) as membernickname,
            cast(subject as string) as subject,
            cast(body as string) as body
        from
            source
    )
select * from renamed
