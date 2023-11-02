{% macro convert_to_boolean(column_name) %}
    CASE 
        WHEN {{ column_name }} IS NULL THEN NULL
        WHEN {{ column_name }} = 'N' THEN false
        ELSE true 
    END
{% endmacro %}
