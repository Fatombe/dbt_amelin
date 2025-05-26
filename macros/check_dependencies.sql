{% macro check_dependencies() %}

{% if execute %}
    {%- for node in graph.nodes.values() -%}
        {%- if node.resource_type == 'model' -%}
            {% if (node.depends_on.macros | length | int + node.depends_on.nodes | length | int) > 1 -%}
                {%- do log("Model " ~ node.name ~ " depends on " ~ (node.depends_on.macros | length | int + node.depends_on.nodes | length | int) ~ " objects", True ) -%}
            {%- endif -%}
        {%- endif -%}
    {%- endfor -%}

{%- endif -%}


{% endmacro %}