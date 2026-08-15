import numpy as np

def read_raw(file):
    with open(file, 'rb') as f:
        print('Opened raw file')

read_raw('tb_async_sar.raw')
