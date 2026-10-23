with source as (
    select
        *
    from {{ source("raw", "airports") }}
)

select
    type,
    count(*) as airport_count
from source
group by type
order by airport_count desc