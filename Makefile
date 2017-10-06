convert_both_and_compare:   convert_demo_script convert_demo_ocaml compare

compare:
    diff --side-by-side demo_notebook_ocaml_script.ml demo_notebook_ocaml.ml

convert_demo_script:
    jupyter nbconvert --to script --output demo_notebook_ocaml_script.ml  demo_notebook_ocaml.ipynb

convert_demo_ocaml:
    jupyter nbconvert --to ocaml --output demo_notebook_ocaml.ml  demo_notebook_ocaml.ipynb
