import sys
import os

CONDA_PREFIX = os.environ['CONDA_PREFIX']
CONDA_PYTHON_EXE = os.environ['CONDA_PYTHON_EXE']
CONDA_PYTHON_LIB = os.path.join(CONDA_PREFIX, 'lib/python{}.{}'.format(sys.version_info.major, sys.version_info.minor))

def Settings(**kwargs):
    return {
        'interpreter_path': CONDA_PYTHON_EXE,
        'sys_path': [CONDA_PYTHON_LIB]
    }
