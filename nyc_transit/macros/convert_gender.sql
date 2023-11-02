{% macro convert_gender(gender_col) %}
    CASE
        WHEN {{ gender_col }} = 0 THEN 'Unknown'
        WHEN {{ gender_col }} = 1 THEN 'Male'
        WHEN {{ gender_col }} = 2 THEN 'Female'
        ELSE NULL
    END
{% endmacro %}

