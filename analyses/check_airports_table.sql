with source as (
    select
        *
    from {{ source("raw", "airports") }}
)

select
    *
from source
