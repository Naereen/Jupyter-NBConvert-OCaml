#!/usr/bin/env python3
# -*- coding: utf-8 -*-
""" Utility for uploading the package to PyPi.

- MIT Licensed, (C) 2017 Lilian Besson (Naereen)
  https://GitHub.com/Naereen/jupyter-nbconvert-ocaml
"""

__author__ = "Lilian Besson (Naereen)"
__version__ = "0.1"
name = 'jupyter_nbconvert_ocaml'

try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

# To use a consistent encoding
from codecs import open
from os import path

here = path.abspath(path.dirname(__file__))

# Get the long description from the README file
with open(path.join(here, name, 'README.rst'), encoding='utf-8') as f:
    long_description = f.read()


setup(
    name=name,
    version=__version__,
    author=__author__,
    author_email="naereen" + "@" + "crans.org",
    description='Naive implementation of a Jupyter NBConvert Exporter for the OCaml language',
    long_description=long_description,
    license='OSI Approved :: MIT License',
    url="https://github.com/Naereen/jupyter-nbconvert-ocaml",
    classifiers=[
        'Intended Audience :: Science/Research',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: Implementation :: CPython',
        'Development Status :: 1 - Beta',
        'Natural Language :: English',
        'Framework :: Jupyter'
    ],
    entry_points={
        'nbconvert.exporters': [
            'ocaml = %s:OCamlExporter' % name,
        ],
    },
    package_data={
        name: [
            path.join(name, 'templates', 'ocaml_template.tpl'),
            path.join('templates', 'ocaml_template.tpl'),
        ]
    },
    packages=[name],
    install_requires=['traitlets', 'nbconvert'],
    python_requires='>=2.7, !=3.0.*, !=3.1.*, !=3.2.*, <4',
)
