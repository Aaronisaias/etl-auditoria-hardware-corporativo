import config
from extract import extraccion
def transform(df):
    duplicados = 0
    nulls = 0
    if config.DROP_DUPLICATES:
        duplicados = df.duplicated().sum()
        df = df.drop_duplicates()
    if config.DROP_NULLS:
        nulls = df.isnull().sum().sum()
        df = df.dropna()
    if config.CAPITALIZE_ROWS and config.TRIM_FILE:
        for colum in df.columns:
            if df[colum].dtype == "object":
                df[colum] = df[colum].str.strip().str.capitalize()
    return df, duplicados, nulls