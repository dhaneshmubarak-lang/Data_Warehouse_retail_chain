import pandas as pd

# dfstg_customer = pd.read_csv( r"C:\Users\dhanesh\Downloads\data warehouse project\customer.csv")
# print(dfstg_customer)
# print(dfstg_customer.head(5))

# dfstg_product = pd.read_csv(r"C:\Users\dhanesh\Downloads\data warehouse project\product.csv")
# print(dfstg_product)
# print(dfstg_product.head(5))

dfstg_stores = pd.read_csv(r"C:\Users\dhanesh\Downloads\data warehouse project\stores.csv")
print(dfstg_stores)

df_sales = pd.read_csv( r"C:\Users\dhanesh\Downloads\data warehouse project\sales.csv")
print(df_sales)

df_sales["quantity"].fillna(130,inplace=True)

# df1=df_sales.drop_duplicates().reset_index(drop=True)



