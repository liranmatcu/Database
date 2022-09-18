from sqlalchemy import create_engine 
from sqlalchemy.orm import sessionmaker

db_host = 'localhost'
db_port = '3306'
db_user = "root"
secret = 'password'
db_name = '/tcu'

connect_credentials = db_user+':'+secret+'@'+db_host+':'+db_port+db_name
engine = create_engine(
    # 'mysql+pymysql://root:password@localhost:3306/tcu',
    'mysql+pymysql://'+connect_credentials,
    echo=True
)

Session = sessionmaker(bind=engine)
session = Session()


# If you prefer the user to enter the secret
# from getpass import getpass
# from urllib.parse import quote 
# secret = getpass('Enter the secret value: ')




