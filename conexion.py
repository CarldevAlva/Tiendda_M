"""import mysql.connector

conexion = mysql.connector.connect(user='root',password='PTPT8080',host='localhost',database='tienda_venta',port='3306')

print(conexion)

m= Model()
print("succes")
m.close_db()

"""

from model.model import Model

import mysql.connector


def conexion():
    conexion = mysql.connector.connect(
        user='root',password='PTPT8080',host='localhost',
        database='tienda_venta',port='3306')
    return conexion    
