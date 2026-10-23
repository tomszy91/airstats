{# Macro to generate source yml file #}

{{ codegen.generate_source(
    schema_name= 'raw',
    table_names = [
        'airport_comments',
        'airport_frequencies',
        'airports',
        'countries',	
        'navaids',	
        'regions',	
        'runways'
        ],
    generate_columns = True,
    include_descriptions = True,
    include_data_types = True
    )
}}