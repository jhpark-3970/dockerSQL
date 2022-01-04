import pyodbc
print("About to insert Hagi:")
#Add your own SQL Server IP address, PORT, UID, PWD and Database
conn = pyodbc.connect(
    'DRIVER={ODBC Driver 19 for SQL Server};SERVER=172.17.0.2;PORT=1433;DATABASE=TestDB;UID=SA;PWD=Sp@:n123', autocommit=True)
cur = conn.cursor()
#This is just an example
cur.execute(
    f"INSERT INTO [Inventory] VALUES (3, 'apple', 159);" 
    #f"SELECT * FROM Inventory WHERE quantity > 152"
)    
conn.commit()
print('Should have inserted Hagi')
cur.close()
conn.close()