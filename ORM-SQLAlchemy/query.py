import pandas as pd
from database import engine

sql = "select * from tcu.user limit 5"
df = pd.read_sql_query(sql, engine)
print(df.head())