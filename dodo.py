# -*- coding: utf-8 -*-
# :Progetto:  password-manager -- doit make definitions
# :Creato:    sab 13 dic 2014 00:31:24 CET
# :Autore:    Alberto Berti <alberto@metapensiero.it>
# :Licenza:   GNU General Public License version 3 or later
#

import doit
from pathlib import Path

TOPDIR = Path(doit.get_initial_workdir())
FRONTEND = TOPDIR/'frontend'
DELTA = FRONTEND/'delta'


def task_scss():
    task = {
        'actions': [['scss', str(DELTA/'scss'/'clipperz.scss'),
                    str(DELTA/'css'/'clipperz.css')]],
        'file_dep': [str(p) for p in (DELTA/'scss').glob('**/*.scss')],
        'targets': [str(DELTA/'css'/'clipperz.css')]
    }
    return task
