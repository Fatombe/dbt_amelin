{%- macro bookref_to_bigint(book_ref) -%}
    ('0x' || {{book_ref}})::bigint  
{%- endmacro -%}