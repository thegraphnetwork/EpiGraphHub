import logging
from logging.handlers import RotatingFileHandler

class Logger():

    def generate_log(name:str, file:str):

        logger = logging.getLogger(name)
        fh = RotatingFileHandler(file, maxBytes=2000, backupCount=5)
        logger.setLevel(logging.DEBUG)
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        fh.setFormatter(formatter)
        logger.addHandler(fh)
        
        return logger
