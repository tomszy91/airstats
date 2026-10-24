with
    source as (select * from {{ source('raw', 'airport_comments') }} ),

    renamed as (
        select
            cast(id as int64)                   as comment_id,              --! primary key
            cast(airportref as int64)           as airport_ref,             --* foreign key to airports 
            cast(airportident as string)        as airport_ident,           --* foreign key to airports
            cast(date as timestamp)             as comment_timestamp,       --  timestamp
            cast(membernickname as string)      as member_nickname, 
            cast(subject as string)             as comment_subject,
            cast(body as string)                as comment_body
        from
            source
    )
select * from renamed
