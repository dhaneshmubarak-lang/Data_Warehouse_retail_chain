# pip install pandas sqlalchemy pymysql
# note: install pip install SQLAlchemy==1.4.49

#purpose of sqlalchemy:It acts as a bridge between Python and SQL databases.

#purpose of pymysql:

#    PyMySQL is a Python library that allows your Python code to connect to and communicate with a MySQL database.
	
import pandas as pd
from sqlalchemy import create_engine



user = 'root'
password = 'root123'
host = 'localhost'          # or your MySQL server address
port = 3306                 # default MySQL port
database = 'retail_dw'


#Creating the DB connection using connection url using create_engine function & pymysql is used for providing driver to connect
engine = create_engine(f"mysql+pymysql://{user}:{password}@{host}:3306/{database}")





# Create a variable to represent the source location of the data..

folder = "C:\\Users\\dhanesh\\Downloads\\data warehouse project\\"


# Mapping of the source file with the target table using python dictionary

table_file_dict= {
    # "stg_customer": folder + "customer.csv",
    # "stg_product": folder + "product.csv",
    "stg_stores": folder + "stores.csv",
    # "stg_sales": folder + "sales.csv"
}


# Can you iterate or loop or run through all the dictionary items to load the respective tables with the respective files...
for table, file in table_file_dict.items():
    df = pd.read_csv(file)
    df.to_sql(name=table, con=engine, if_exists='replace', index=False)
    print(f"Loaded {len(df)} rows into {table}")



# df_customer = pd.read_csv(folder + "customer.csv")
# df_customer.to_sql(name='stg_customer', con= engine, if_exists='replace', index=False)
# print("Customer data loaded")
