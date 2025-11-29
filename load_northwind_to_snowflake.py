import pyodbc
import snowflake.connector
from snowflake.connector.pandas_tools import write_pandas
import pandas as pd

# ----- اتصال به SQL Server (کانتینر mssql2022) -----
mssql_conn_str = (
    "Driver={ODBC Driver 17 for SQL Server};"
    "Server=localhost,1544;"
    "Database=Northwind;"
    "UID=sa;"
    "PWD=Str0ng!Passw0rd;"
)
mssql_conn = pyodbc.connect(mssql_conn_str)

# ----- اتصال به Snowflake -----
sf_conn = snowflake.connector.connect(
    account="jaeefgj-rz25572",
    user="Zerangmajid",
    password="Mz@801390209163",  # اگر دوست نداری اینجا باشه بعداً می‌ذاریم تو env
    warehouse="COMPUTE_WH",
    database="RAW",
    schema="MSSQL",
    role="ACCOUNTADMIN",
)

tables = [
    ("Customers", "CUSTOMERS"),
    ("Orders", "ORDERS"),
    ("Products", "PRODUCTS"),
    ("Order Details", "ORDER_DETAILS"),
]

for src_table, dest_table in tables:
    print(f"Reading from SQL Server table: {src_table}")
    df = pd.read_sql(f"SELECT * FROM [{src_table}];", mssql_conn)

    print(f"Writing to Snowflake table: {dest_table} in RAW.MSSQL")
    success, nchunks, nrows, _ = write_pandas(
        sf_conn,
        df,
        dest_table,
        auto_create_table=True,   # جدول را خودش می‌سازد
        overwrite=True            # هر بار از اول می‌نویسد
    )

    print(f"  -> done: success={success}, rows={nrows}")

sf_conn.close()
mssql_conn.close()
print("All tables transferred.")
