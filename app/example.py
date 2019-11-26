import logging
import time

from fan_tools.fan_logging import setup_logger

setup_logger("some_name")
log = logging.getLogger("example")

while 1:
    log.debug("This is example log debug")
    print("This is example print")
    time.sleep(1)
