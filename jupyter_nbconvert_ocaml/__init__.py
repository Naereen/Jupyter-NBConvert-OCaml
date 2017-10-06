#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Custom Jupyter NBConvert Exporter for the OCaml language.

See http://nbconvert.readthedocs.io/en/latest/external_exporters.html#writing-a-custom-exporter if needed.

- MIT Licensed, (C) 2017 Lilian Besson (Naereen)
  https://GitHub.com/Naereen/jupyter-nbconvert-ocaml
"""

import os
import os.path

from traitlets.config import Config
from nbconvert.exporters.script import ScriptExporter


class OCamlExporter(ScriptExporter):
    """
    Custom Jupyter NBConvert Exporter for the OCaml language.
    """

    def _file_extension_default(self):
        """
        The new file extension is `.ml`
        """
        return '.ml'

    @property
    def template_path(self):
        """
        We want to inherit from script template, and have template under
        `./templates/` so append it to the search path. (see next section)
        """
        return super().template_path + [os.path.join(os.path.dirname(__file__), "templates")]

    def _template_file_default(self):
        """
        We want to use the new template we ship with our library.
        """
        return 'test_template' # full