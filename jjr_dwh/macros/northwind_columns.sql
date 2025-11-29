{% macro nw_col(name) %}
  {# 
    برای SQL Server: فقط همان نام ستون 
    برای Snowflake: "ColumnName" (case-sensitive)
  #}
  {% if target.type == 'snowflake' %}
    "{{ name }}"
  {% else %}
    {{ name }}
  {% endif %}
{% endmacro %}
