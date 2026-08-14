import config
from pathlib import Path
import pandas

def extraccion():
    ruta = Path(config.FOLDER)/(config.DATA_FILE)
    pd = pandas.read_csv(ruta)
    return pd