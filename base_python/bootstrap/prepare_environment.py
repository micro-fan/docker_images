#!/usr/bin/env python3
import os
import shutil
import subprocess

env = '/bootstrap_env'
pip = f'{env}/bin/pip'
python = f'{env}/bin/python'


def run(cmd):
    return subprocess.run(cmd, shell=True, check=True)


def py_run(cmd):
    run(f'{python} {cmd}')


def main():
    run(f'python3 -m venv {env}')
    run(f'{pip} install wheel')
    run(f'{pip} install -r requirements.txt')
    os.makedirs('/etc/supervisor/conf.d/', exist_ok=True)
    os.makedirs('/var/log/supervisor/', exist_ok=True)
    shutil.copy('/bootstrap/supervisord.conf', '/etc/supervisor/supervisord.conf')


if __name__ == '__main__':
    main()
