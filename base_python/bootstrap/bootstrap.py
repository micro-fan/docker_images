#!/bootstrap_env/bin/python
import os
import shutil
import subprocess

from fan_tools.python import rel_path


def run(cmd):
    return subprocess.run(cmd, shell=True, check=True)


def supervisor_link(local_path):
    base_name = os.path.basename(local_path)
    dst = f'/etc/supervisor/conf.d/{base_name}'
    shutil.copy(local_path, dst)


def main():
    log_dir = os.environ['LOG_DIR']
    if not os.path.exists(log_dir):
        os.mkdir(log_dir)
    SUPERVISOR_CONFIG = os.environ.get('SUPERVISOR_CONFIG')
    supervisor_link(SUPERVISOR_CONFIG)
    supervisor_link(rel_path('supervisor-bootstrap.conf'))
    run('supervisord -n')


if __name__ == '__main__':
    main()
