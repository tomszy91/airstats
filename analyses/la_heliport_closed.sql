with
source as (
    select * from {{ ref("scd_silver_airports") }}
)

select *
from source
where airport_ident = 'US-9364'

