with
source as (
    select * from {{ ref("src_airports")}}
)

select
    airport_id,
    airport_ident, 
    airport_type,
    airport_name,
    airport_lat,
    airport_long,
    airport_location,
    continent,
    iso_country,
    iso_region    
from
    source