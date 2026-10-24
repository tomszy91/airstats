{# Macro to generate model yml file #}
{{ config(
    enabled=false
)}}

{{ codegen.generate_model_yaml(
    model_names=[
        'src_airport_comments',
        'src_airports',
        'src_runways'
        ]
) }}