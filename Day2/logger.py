import logger
import logging

def get_logger(name):
    logger = logging.getLogger(name)
    logger.setLevel(logging.DEBUG)

    handler = logging.StreamHandler()
    handler.setLevel(logging.DEBUG)

    formatter = logging.Formatter('[%(levelname)s] [%(asctime)s]-[%(message)s]')
    handler.setFormatter(formatter)
    
    logger.addHandler(handler)

    return logger


