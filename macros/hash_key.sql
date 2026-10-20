{% macro hash_key(spalte) %}
    md5(upper(trim(cast({{ spalte }} as varchar))))
{% endmacro %}