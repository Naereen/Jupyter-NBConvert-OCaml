# Makefile for testing
test:   convert_both_and_compare execute_both convert_demo_ocaml

install:
	sudo -H python3 setup.py install --force

uninstall:
	sudo -H pip3 uninstall jupyter_nbconvert_ocaml

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

clean:
	-rm -rv jupyter_nbconvert_ocaml/__pycache__
	-sudo -H rm -rvI dist build jupyter_nbconvert_ocaml.egg-info
