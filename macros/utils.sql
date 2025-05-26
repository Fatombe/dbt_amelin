{%- macro concat_columns(columns, delimeter=', ') %}
    {%- for column in columns -%}
        {{column}} {% if not loop.last %} || '{{delimeter}}' || {% endif%}
    {%- endfor %}
{%- endmacro -%}


{% macro drop_old_relation(dryrun=False) %}

{% if execute %}

    {# находим все модели#}

    {% set current_models = [] %}

    {% for node in graph.nodes.values() | selectattr("resource_type", "in", ["model", "seed", "snapshot"]) %}
        {% do current_models.append(node.name)%}
    {% endfor %}


    {# формирование скрипта для удаления объектов не соответствующим списку current_models#}

    {% set cleanup_query%}

    WITH models_to_drop as (
            SELECT
                    CASE WHEN table_type = 'BASE TABLE' THEN 'TABLE'
                    WHEN table_type = 'VIEW' THEN 'VIEW'
                    END AS relation_type,
                    concat_ws('.', table_catalog, table_schema, table_name) as relation_name 
            FROM "{{ target.database }}".information_schema.tables
            WHERE table_schema = '{{ target.schema }}'
                    and table_name not in
                        ({%- for model in current_models -%}
                            '{{ model }}'
                            {%- if not loop.last -%}
                                ,
                            {% endif %}
                        {%- endfor -%}
                        )
    )
    SELECT
        'DROP ' || relation_type || ' ' || relation_name || ';' as drop_command
    FROM models_to_drop;

    {% endset %}

    {% set drop_commands=run_query(cleanup_query).columns[0].values() %}
    {% do log(drop_commands, True)%}

    {% if drop_commands %}
        {% if dryrun | as_bool == False %}
            {% do log("Execute DROP command...", True) %}
        {% else %}
            {% do log("Printing DROP command...", True) %}     
        {% endif %}

        {% for command in drop_commands %}
            {% do log(command, True)%}  
            {% if dryrun | as_bool == False %}
                {% do run_query(command)%}
            {% endif %}
        {% endfor %}
    {% else %}
        {% do log("No relation to clear", True)%}   

    {% endif %}

{% endif %}
  
{% endmacro %}



{% macro show_columns_relation(table) %}

  {%- set prev_table = adapter.get_relation(
        database="dwh-flight",
        schema="intermediate",
        identifier="{{table}}") %}

  {%- set columns = adapter.get_columns_in_relation(prev_table) %}

  {% for column in columns -%}
    {{ column.column }}{% if not loop.last %}, {% endif %}
  {% endfor %}

{% endmacro %}


