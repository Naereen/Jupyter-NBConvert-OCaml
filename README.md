# Custom `Exporter` for OCaml and the Jupyter NBConvert

Installing this Python project allow to convert [Jupyter notebooks](https://www.jupyter.org/) written with the [OCaml Jupyter kernel](https://github.com/akabe/ocaml-jupyter/) directly to well-written `.ml` OCaml scripts. It solves [this issue](https://github.com/akabe/ocaml-jupyter/issues/58#issuecomment-334730337).

## a) Test, and install locally
Clone this repository, test everything locally if you want, and then install it globally with:

```bash
$ python setup.py install  # for default Python
$ python3 setup.py install  # for Python3 if needed
```

> Note: `sudo` right might be necessary:

```bash
$ sudo python3 setup.py install
```

## b) Install directly from GitHub

This package can also be installed directly from GitHub with [`pip`](http://pip.pypa.io/):

```bash
sudo pip install git+https://github.com/Naereen/Jupyter-NBConvert-OCaml
```

Check that you use pip2 or pip3 whether you installed Jupyter for Python 2 or Python 3. (You can of course install `Jupyter-NBConvert-OCaml` for both if you prefer!)

## Use it

```bash
$ jupyter nbconvert --to ocaml A_Jupyter_notebook_with_OCaml_kernel.ipynb
$ ls A_Jupyter_notebook_with_OCaml_kernel.ml
...
$ ocaml A_Jupyter_notebook_with_OCaml_kernel.ml  # it works and comments are kept
...
```

To test it locally (in this folder), use [this Makefile](Makefile):

```bash
$ make convert_demo_ocaml_local
$ head -n7 demo_notebook_ocaml.ml
(*
This OCaml script was exported from a Jupyter notebook
using an open-source software (under the MIT License) written by @Naereen
from https://github.com/Naereen/Jupyter-NBConvert-OCaml
This software is still in development, please notify me of a bug at
https://github.com/Naereen/Jupyter-NBConvert-OCaml/issues/new if you find one
*)
...
```

## Example

- See [this small notebook](demo_notebook_ocaml.ipynb), with lots of comments,
- [This first OCaml file](demo_notebook_script.ml) is the result of `jupyter-nbconvert --to script`, the default conversion, which removes all comments,
- [And this second OCaml file](demo_notebook_ocaml.ml) is the result of `jupyter-nbconvert --to ocaml`, our home-made conversion, which removes keep all comments and adds a small header.

## References
> See the [documentation](http://nbconvert.readthedocs.io/en/latest/external_exporters.html#writing-a-custom-exporter) [I (Lilian Besson, @Naereen](https://GitHub.com/Naereen) used to write this small exporter.

----

## :scroll: License ? [![GitHub license](https://img.shields.io/github/license/Naereen/badges.svg)](https://github.com/Naereen/Jupyter-NBConvert-OCaml/blob/master/LICENSE)
[MIT Licensed](https://lbesson.mit-license.org/) (file [LICENSE](LICENSE)).
© [Lilian Besson](https://GitHub.com/Naereen), 2017-2018.

[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/Jupyter-NBConvert-OCaml/graphs/commit-activity)
[![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)](https://GitHub.com/Naereen/ama)
[![Analytics](https://ga-beacon.appspot.com/UA-38514290-17/github.com/Naereen/Jupyter-NBConvert-OCaml/README.md?pixel)](https://GitHub.com/Naereen/Jupyter-NBConvert-OCaml/)

[![ForTheBadge built-with-swag](http://ForTheBadge.com/images/badges/built-with-swag.svg)](https://GitHub.com/Naereen/)

[![ForTheBadge uses-badges](http://ForTheBadge.com/images/badges/uses-badges.svg)](http://ForTheBadge.com)
[![ForTheBadge uses-git](http://ForTheBadge.com/images/badges/uses-git.svg)](https://GitHub.com/)
