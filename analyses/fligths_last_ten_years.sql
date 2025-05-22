{%- set current_date = run_started_at|string|truncate(10, True, "") %}
{%- set current_year = run_started_at|string|truncate(4, True, "")|int %}
{%- set prev_year = current_year - 10 %}
{%- set prev_date = run_started_at|string|truncate(10, True, "")|replace(current_year|string, prev_year|string) -%}

SELECT COUNT(*) as {{ adapter.quote('cnt')}}
FROM {{ ref('fct_flights') }}
WHERE scheduled_departure::date between '{{prev_date}}' and '{{ current_date }}'

{# {%- set source_relation1 = adapter.get_relation(
      database="dwh-flight",
      schema="intermediate",
      identifier="fct_flights") %}

{{ source_relation1.database }}
{{ source_relation1.schema }}
{{ source_relation1.identifier }}
{{ source_relation1.is_table }}
{{ source_relation1.is_view }}
{{ source_relation1.is_cte }}


{%- set source_relation2 = load_relation(ref('fct_bookings')) %}
{%- set columns = adapter.get_columns_in_relation(source_relation2) %}

{% for column in columns -%}
  {{ "Column: " ~ column.column }}
{% endfor %}  #}


{# {% do adapter.create_schema(api.Relation.create(database=target.database, schema="my_schema")) %} #}
{# {% do adapter.drop_schema(api.Relation.create(database=target.database, schema="my_schema")) %} #}

{# {% set fct_flights = api.Relation.create(
    database="dwh-flight",
    schema="intermediate",
    identifier="fct_flights"
    )
%}

{% set stg_flights__flights = api.Relation.create(
    database="dwh-flight",
    schema="intermediate",
    identifier="stg_flights__flights"
    )
%}

{% for col in adapter.get_missing_columns(stg_flights__flights, fct_flights) %}
    {{"Column:" ~ col}}
{% endfor %} #}


{# {% set get_columns_fct_flights=adapter.get_relation(
        database=target.database,
        schema=target.schema,
        identifier='fct_flights'
    )
%}

{% set columns_fct_flights=adapter.get_columns_in_relation(get_columns_fct_flights)%}

{% for column in columns_fct_flights %}
    {{'Column: ' ~ column.column}}
{% endfor %} #}

{% set stg_flights__aircraft_backup_date = api.Relation.create(
    database=this.database,
    schema=this.database,
    identifier=this.identifier
)
%}
{% do adapter.drop_relation(stg_flights__aircraft_backup) %}
{% do adapter.rename_relation(this, stg_flights__aircraft_backup_date)%}