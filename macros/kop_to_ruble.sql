{%- macro kop_to_ruble(column_name, scale=5000)-%}
    {% if scale < 0 %}
        {# {{exceptions.raise_compiler_error("Invalid 'scale. Got " ~ scale )}} #}
        {% do exceptions.warn("Invalid 'scale. Got " ~ scale ) %}
    {% endif %}
    ({{column_name}} / 100)::numeric(16, {{scale}})
{%- endmacro -%}