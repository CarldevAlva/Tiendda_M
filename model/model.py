from mysql import connector
import uuid
import numpy as np
import requests
import datetime
import os
uuidvalue = str(uuid.uuid1())

defaultimg = "../producto_default.png"





fecha_actual = datetime.datetime.now().date()
hora_actual = datetime.datetime.now()


class Model(): 
    idencargadolol = ''
    nombreempleadolol = ''
    def __init__(self, config_db_file='config.txt'):
        self.config_db_file = config_db_file
        self.config_db = self.read_config_db()
        self.connect_to_db()


    
    def read_config_db(self):
        d = {}
        with open(self.config_db_file) as f_r:
            for line in f_r:
                (key,val)=line.strip().split(':')
                d[key] = val
        return d
    
    def connect_to_db(self):
        self.cnx = connector.connect(**self.config_db)
        self.cursor = self.cnx.cursor()

    def close_db(self):
        self.cnx.close()

    def login_empleado(self,correo,contrasena):
        try:
            print(correo,contrasena)
            sql  = 'SELECT idencargado,nombre FROM encargado where correo = %s AND contraseña = %s'
            vals = (correo,contrasena)
            self.cursor.execute(sql,vals)
            record = self.cursor.fetchone()
            print(record[0],"<<<login_empleado>>>")
            self.funcionguardardatosdeempleado(record[0],record[1])
            return record
        except connector.Error as err:
            return err

    def funcionguardardatosdeempleado(self,idempleado,nombreempleado):
        print(idempleado,nombreempleado,"aver")

    def consultadniapi(self,dni):
        response = requests.get(f"https://dniruc.apisperu.com/api/v1/dni/{dni}?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImNhcmxtYXJ0Ljk5OThAZ21haWwuY29tIn0.khCzj-6_c4QMnTCLRbXTDXQpDasayBRR8HzEsPZ1TXE")
        if response:
            return (response.json())

    def buscar_dni(self,dni):
        try:
            sql  = 'SELECT * FROM cliente where dni = %s'
            vals = (dni,)
            self.cursor.execute(sql,vals)
            record = self.cursor.fetchone()
            print(record,"<<<obtener_datos_productos>>>")
            return record
        except connector.Error as err:
            return err

    def oruteas():
        print("umprime algo plox")

    def crear_cliente(self,nombre,apellido,dni,id=uuidvalue):
        id =str(uuid.uuid1())
        try:
            sql = ('INSERT INTO cliente(`idcliente`,`nombre`,`apellido`,`dni`) VALUES (%s,%s,%s,%s)')
            vals = (id,nombre,apellido,dni)
            self.cursor.execute(sql,vals)
            self.cnx.commit()
            return True
        except connector.Error as err:
            self.cnx.rollback()
            return err  


    def create_categorias(self,nombre,imagen=defaultimg,id=uuidvalue):
        id =str(uuid.uuid1())
        try:
            sql = ('INSERT INTO categorias(`idcategorias`,`nombre`,`imagen_url`) VALUES (%s,%s,%s)')
            vals = (id,nombre,imagen)
            self.cursor.execute(sql,vals)
            self.cnx.commit()
            return True
        except connector.Error as err:
            self.cnx.rollback()
            return err  
        #self.x = self.pushButton_2.clicked.connect(lambda: m.create_categorias(lineEdit))




    def create_productos(self,idcategoria,nombre,precio,marca,cantidad,imagen=defaultimg,id=uuidvalue):
        id =str(uuid.uuid1())
        try:
            sql = ('INSERT INTO productos(`idproductos`,`nombre`,`precio`,`marca`,`cantidad_producto`,`imagen_url`,`categorias_idcategorias`) VALUES (%s,%s,%s,%s,%s,%s,%s)')
            vals = (id,str(nombre),float(precio),str(marca),int(cantidad),imagen,str(idcategoria))
            self.cursor.execute(sql, vals)   
            self.cnx.commit()
        except connector.Error as err:
            self.cnx.rollback()
            return err  

    def crear_encargado(self,nombre,apellido,dni,fecha_nacimiento,sexo,direccion,telefono,tipo_empleado,correo,contrasena,imagen=defaultimg,id=uuidvalue):
        id =str(uuid.uuid1())
        try:
            sql = ('INSERT INTO encargado(`idencargado`,`nombre`,`apellido`,`dni`,`fecha_nacimiendo`,`sexo`,`direccion`,`telefono`,`tipo_empleado`,`correo`,`contraseña`,`imagen_url`) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)')
            vals = (id,str(nombre),str(apellido),dni,fecha_nacimiento,sexo,direccion,telefono,tipo_empleado,correo,contrasena,imagen)
            self.cursor.execute(sql, vals)   
            self.cnx.commit()
            return True
        except connector.Error as err:
            self.cnx.rollback()
            return err  
    

    def crear_factura(self,igv_total,monto_total,cliente_id,encargado_id,fecha=fecha_actual,hora=hora_actual,id=uuidvalue):
        
        id =str(uuid.uuid1())
        forma_pago ="contado"
        try:
            sql = ('INSERT INTO factura(`idfactura`,`fecha_venta`,`hora`,`forma_pago`,`igv_total`,`monto_total`,`cliente_idcliente`,`encargado_idencargado`) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)')
            vals = (id,fecha,hora,forma_pago,igv_total,monto_total,cliente_id,encargado_id)
            self.cursor.execute(sql, vals)   
            self.cnx.commit()
            return id
        except connector.Error as err:
            self.cnx.rollback()
            return err      

    def crear_detalle_factura(self,precio,cantidad,monto,producto_id,factura_id):
        try:
            sql = ('INSERT INTO detalles_productos(`precio_salida`,`cantidad`,`monto`,`productos_idproductos`,`factura_idfactura`) VALUES (%s,%s,%s,%s,%s)')
            vals = (precio,cantidad,monto,producto_id,factura_id)
            self.cursor.execute(sql, vals)   
            self.cnx.commit()
            return True
        except connector.Error as err:
            self.cnx.rollback()
            return err              


    def buscar_producto_partedel_nombre(self,nombre_producto):
        try:
            sql  = 'SELECT nombre FROM productos WHERE nombre LIKE "%"%s"%" '
            vals = (nombre_producto,)
            self.cursor.execute(sql,vals)
            records = self.cursor.fetchall()
            arrayrecords = []
            delim = ','
            for x in records:         
             s = delim.join(x)
             arrayrecords.append(s)
            print(arrayrecords)
            return arrayrecords
        except connector.Error as err:
            return err

    def obtener_datos_productos(self,nombre):
        try:
            sql  = 'select productos.idproductos, productos.nombre, categorias.nombre,precio from productos join categorias on productos.categorias_idcategorias = categorias.idcategorias where productos.nombre = %s'
            vals = (nombre,)
            self.cursor.execute(sql,vals)
            record = self.cursor.fetchone()
            print(record,"<<<obtener_datos_productos>>>")
            return record
        except connector.Error as err:
            return err

    def obtener_todo_producto(self,):
        try:
            sql  = 'select idproductos,nombre,precio,marca,cantidad_producto from productos'
            self.cursor.execute(sql)
            record = self.cursor.fetchall()
            return record
        except connector.Error as err:
            return err

    def obtener_todo_factura(self,):
        try:
            sql  = 'select idfactura,forma_pago,igv_total,monto_total from factura'
            self.cursor.execute(sql)
            record = self.cursor.fetchall()
            return record
        except connector.Error as err:
            return err      

    def obtener_todo_empleado(self,):
        try:
            sql  = 'select idencargado,nombre,apellido,sexo,tipo_empleado from encargado'
            self.cursor.execute(sql)
            record = self.cursor.fetchall()
            return record
        except connector.Error as err:
            return err  
            
    def buscar_id_categorias(self,nombre_categoria):
        try:
            sql  = 'select idcategorias from categorias where nombre = %s'
            vals = (nombre_categoria,)
            self.cursor.execute(sql,vals)
            record = self.cursor.fetchone()
            return record[0]
        except connector.Error as err:
            return err


    def mostrarcaetgorias(self,):
        try:
            sql  = 'select nombre from categorias'
            self.cursor.execute(sql)
            records = self.cursor.fetchall()
            arrayrecords = []
            delim = ','
            for x in records:
             s = delim.join(x)
             arrayrecords.append(s)
            return arrayrecords 
        except connector.Error as err:
            return err
 

  
