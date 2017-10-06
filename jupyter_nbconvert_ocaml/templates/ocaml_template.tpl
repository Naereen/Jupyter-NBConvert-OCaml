{%- extends 'null.tpl' -%}

{% block header %}(*
This OCaml script was exported from a Jupyter notebook
using an open-source software (under the MIT License) written by @Naereen
from https://github.com/Naereen/Jupyter-Notebook-OCaml
This software is still in development, please notify me of a bug at
https://github.com/Naereen/Jupyter-Notebook-OCaml/issues/new if you find one
*)
{% endblock header %}

{% block in_prompt %}
{% if resources.global_content_filter.include_input_prompt -%}
(* In[{{ cell.execution_count if cell.execution_count else ' ' }}]: *)
{% endif %}
{% endblock in_prompt %}

{% block input %}
{{ cell.source | add_endsemicolon_ocaml }}
{% endblock input %}

{% block markdowncell scoped %}
{{ cell.source | comment_lines_ocaml }}
{% endblock markdowncell %}