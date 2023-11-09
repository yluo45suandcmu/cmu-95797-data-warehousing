{% macro convert_to_boolean(column_name) %}
    CASE 
        WHEN {{ column_name }} IS NULL THEN NULL
        WHEN {{ column_name }} = ' ' THEN NULL
        WHEN {{ column_name }} = 'N' THEN false
        ELSE {{ column_name }} 
    END::boolean
{% endmacro %}
