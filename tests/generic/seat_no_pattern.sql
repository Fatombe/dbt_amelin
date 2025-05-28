{% test seat_no_pattern(model, column_name)%}
    SELECT {{column_name}}
    FROM {{model}}
    WHERE NOT {{column_name}} ~ '^[0-9]{1}[A-Z]+$'
{% endtest %}