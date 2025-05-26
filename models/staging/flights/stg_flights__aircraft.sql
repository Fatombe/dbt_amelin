{{
    config(
        materialized="table",
    )
}}

select 
    aircraft_code,
    model,
    "range"
from {{ source("demo_src", "aircrafts") }}


{% if execute %}
    {% for node in graph.nodes.values() %}
        {% if node.resource_type == 'model'%}
           -- {{node.name}}
           -- -------------
           -- {{ node.depends_on}}
        {% endif %}
    {% endfor %}
{% endif %}

