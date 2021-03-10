#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import sys
import stat
import shutil

fs = os.open("/opt",os.O_RDONLY)
os.fchdir(fs)
print os.getcwd()
