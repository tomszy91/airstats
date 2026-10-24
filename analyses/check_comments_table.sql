with source as (
    select
        *
    from {{ source("raw", "airport_comments") }}
)

select
    *
from source
