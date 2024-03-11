# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file '.\categoria_window__.ui'
#
# Created by: PyQt5 UI code generator 5.15.4
#
# WARNING: Any manual changes made to this file will be lost when pyuic5 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import QFileDialog
from PyQt5.QtGui import QImage,QPixmap

import cv2
import imutils

from model.model import Model

import os
import sys
myDir = os.getcwd()
sys.path.append(myDir)



m= Model()
print("succes")
"""m.close_db()"""


class Ui_VistaCategoria(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(519, 148)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.label = QtWidgets.QLabel(self.centralwidget)
        self.label.setGeometry(QtCore.QRect(80, 50, 91, 16))
        self.label.setObjectName("label")
        self.label_2 = QtWidgets.QLabel(self.centralwidget)
        self.label_2.setGeometry(QtCore.QRect(80, 80, 121, 16))
        self.label_2.setObjectName("label_2")
        self.inputext_nombrecategoria = QtWidgets.QLineEdit(self.centralwidget)
        self.inputext_nombrecategoria.setGeometry(QtCore.QRect(200, 80, 211, 20))
        self.inputext_nombrecategoria.setObjectName("inputext_nombrecategoria")
        self.pushButton_2 = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton_2.setGeometry(QtCore.QRect(330, 50, 71, 23))
        self.pushButton_2.setObjectName("pushButton_2")
        MainWindow.setCentralWidget(self.centralwidget)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)
        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)
        self.x = self.pushButton_2.clicked.connect(self.funcionsedatacategory)
        # lambda: m.create_categorias(self.inputext_nombrecategoria.text())
#funciones


    def cargarimagen(self,):
        self.filename = QFileDialog.getOpenFileName(filter = "Image (*.*)")[0]
       # self.avalue = self.label_3.setPixmap()
        print(self.filename)
#eventos
    def funcionsedatacategory(self,):
        print(self.inputext_nombrecategoria.text())
        m.create_categorias(self.inputext_nombrecategoria.text())   
        
    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        self.label.setText(_translate("MainWindow", "Crear Categoria"))
        self.label_2.setText(_translate("MainWindow", "Nombre de Categoria"))
        self.label_3.setText(_translate("MainWindow", "TextLabel"))
        self.pushButton.setText(_translate("MainWindow", "Cargar Imagen"))
        self.pushButton_2.setText(_translate("MainWindow", "Guardar"))
        
        self.pushButton.clicked.connect( self.cargarimagen)
    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        self.label.setText(_translate("MainWindow", "Crear Categoria"))
        self.label_2.setText(_translate("MainWindow", "Nombre de Categoria"))
        self.pushButton_2.setText(_translate("MainWindow", "Guardar"))


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QMainWindow()
    ui = Ui_VistaCategoria()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())