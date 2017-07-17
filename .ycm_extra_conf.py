#!/usr/bin/env python

import json
import os
import platform

def get_filename(entry):
    return os.path.abspath(entry['file'])

def get_flags(entry):
    return entry['command'].split()[1:]

def load_compile_commands(filename):
    path = os.path.abspath(filename)
    while not (path == '' or os.path.ismount(path)):
        path = os.path.dirname(path)
        try:
            with open(os.path.join(path, 'compile_commands.json')) as f:
                return [(get_filename(e), get_flags(e)) for e in json.load(f)]
        except IOError:
            pass
    return None

def find_flags(entries, filename):
    path = os.path.abspath(filename)
    while not (path == '' or os.path.ismount(path)):
        for e in entries:
            if e[0].startswith(path):
                return e[1]
        path = os.path.dirname(path)
    return None

def FlagsForFile(filename, **kwargs):
    if platform.system() == 'Darwin':
        cpp_std_include = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1'
    else:
        cpp_std_include = ''

    entries = load_compile_commands(filename) or []
    entry_flags = find_flags(entries, filename) or []
    extra_flags = ['-isystem', cpp_std_include]
    return {'flags': entry_flags + extra_flags}
