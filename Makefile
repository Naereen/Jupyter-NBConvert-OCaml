# Makefile for testing
test:   convert_both_and_compare execute_both convert_demo_ocaml

install:
	python3 setup.py install

convert_both_and_compare:	convert_demo_script convert_demo_ocaml_local compare

compare:
	diff --side-by-side demo_notebook_script.ml demo_notebook_ocaml.ml

execute_both:
	ocaml < demo_notebook_script.ml
	ocaml < demo_notebook_ocaml.ml

convert_demo_script:
	jupyter nbconvert --no-prompt --to script --output demo_notebook_script.ml  demo_notebook_ocaml.ipynb

convert_demo_ocaml_local:
	jupyter nbconvert --no-prompt --to jupyter_nbconvert_ocaml.OCamlExporter --output demo_notebook_ocaml.ml  demo_notebook_ocaml.ipynb

convert_demo_ocaml:
	jupyter nbconvert --no-prompt --to ocaml --output demo_notebook_ocaml.ml  demo_notebook_ocaml.ipynb
