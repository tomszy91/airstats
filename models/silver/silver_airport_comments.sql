{{
    config(
        materialized='incremental',
        unique_key='comment_id',
        incremental_strategy='merge'
    )
}}


with
    source as (select * from {{ ref('src_airport_comments') }} ),

    filtered as (
        select
            comment_id,              
            airport_ref,             
            airport_ident,           
            comment_timestamp,       
            case
                when
                    (member_nickname is null)
                    or (member_nickname = '') then '__UNKNOWN__'
                else member_nickname
                end as member_nickname,
            comment_subject,
            comment_body,
            current_timestamp() as loaded_at
        from
            source
        where
            (comment_body is not null) or (comment_body = '')
    )
select
    *
from
    filtered
{% if is_incremental() %}
where
    comment_id > (select coalesce(max(comment_id), 0) from {{ this }} )
{% endif %}

