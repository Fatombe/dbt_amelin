{%- macro safe_select(table_name) %}

{%- set source_table = adapter.get_relation(
      database=target.database,
      schema=target.schema,
      identifier="{{table_name}}") %}

    {%- if source_table == "None" -%}
        SELECT NULL
    {%- else -%}     
        SELECT * FROM {{table_name}}
    {%- endif -%}
{%- endmacro %}