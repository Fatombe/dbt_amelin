{% test airport_code_name(model, column_name)%}
    SELECT {{ column_name }}
    FROM {{ model }}
    WHERE {{ column_name }} NOT SIMILAR TO '[A-Z]{3}' 
{% endtest %}