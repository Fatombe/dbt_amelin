{{
    config(
        materialized="table",
        pre_hook = '
        {% set stg_flights__aircraft_backup_date = api.Relation.create(
            database=this.database,
            schema=this.schema,
            identifier=this.identifier ~ "_" ~ run_started_at|string|truncate(19, True, "")|replace("-","_")|replace(":","")|replace(" ","_")
        )
        %}
        {% do adapter.rename_relation(this, stg_flights__aircraft_backup_date)%}
        '
    )
}}

select 
    aircraft_code,
    model,
    "range"
from {{ source("demo_src", "aircrafts") }}
