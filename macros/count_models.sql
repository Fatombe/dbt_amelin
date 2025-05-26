{% macro count_models() %}

{% if execute %}
    {% set models = [] %}
    {% set seeds = [] %}
    {% set snapshots = [] %}

    {%- for node in graph.nodes.values() -%}
        {%- if node.resource_type == 'model' -%}
            {% do models.append(node.name) -%}
        {%- elif node.resource_type == 'seed' -%}
            {% do seeds.append(node.name) -%}
        {%- elif node.resource_type == 'snapshot' -%}
            {% do snapshots.append(node.name) -%}
        {%- endif -%}
    {%- endfor -%}

    {%- do log("Models: " ~ models | length, True ) -%}
    {%- do log("Seeds: " ~ seeds | length, True ) -%}
    {%- do log("Snapshots: " ~ snapshots | length, True ) -%}

{%- endif -%}


{% endmacro %}
