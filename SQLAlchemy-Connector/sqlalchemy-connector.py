from sqlalchemy import create_engine
import pandas as pd

# Database credentials
db_host = 'localhost'
db_port = '3306'
db_user = "root"
secret = 'password'
db_name = 'trading'
db_credentials = db_user+':'+secret+'@'+db_host+':'+db_port+'/'+db_name

# create a SQL engine using the command which creates a new class ‘.engine’.
engine = create_engine(
    # 'mysql+pymysql://root:password@localhost:3306/trading',
    'mysql+pymysql://'+db_credentials,
    echo=True
)
# engine = create_engine('mysql://root:password@localhost/trading')


sql = "select * from trading.members limit 5"
df = pd.read_sql_query(sql, engine)
print(df.head())

tuple_in_dict = df.to_dict('records')
keys = ['member_id', 'first_name', 'region']
print('Member ID\t', 'First Name\t', 'Region')
for item in tuple_in_dict:
  for key in keys:
      print(item.get(key), end="\t\t")
  print()



