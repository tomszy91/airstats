with source as (
    select
        *
    from {{ source("raw", "runways") }}
)

select
    *
from source
