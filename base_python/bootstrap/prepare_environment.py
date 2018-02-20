#!/usr/bin/env python3
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


if __name__ == '__main__':
    main()
