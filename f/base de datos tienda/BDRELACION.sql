-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tienda_venta
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tienda_venta` ;

-- -----------------------------------------------------
-- Schema tienda_venta
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tienda_venta` DEFAULT CHARACTER SET utf8 COLLATE utf8_czech_ci ;
USE `tienda_venta` ;

-- -----------------------------------------------------
-- Table `tienda_venta`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_venta`.`cliente` ;

CREATE TABLE IF NOT EXISTS `tienda_venta`.`cliente` (
  `idcliente` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `dni` VARCHAR(12) NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) VISIBLE,
  UNIQUE INDEX `idcliente_UNIQUE` (`idcliente` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda_venta`.`encargado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_venta`.`encargado` ;

CREATE TABLE IF NOT EXISTS `tienda_venta`.`encargado` (
  `idencargado` INT NOT NULL,
  `nombre` INT NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `dni` VARCHAR(12) NOT NULL,
  `fecha_nacimiendo` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `tipo_empleado` VARCHAR(9) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idencargado`),
  UNIQUE INDEX `idencargado_UNIQUE` (`idencargado` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda_venta`.`categorias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_venta`.`categorias` ;

CREATE TABLE IF NOT EXISTS `tienda_venta`.`categorias` (
  `idcategorias` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `imagen_url` LONGTEXT NULL,
  PRIMARY KEY (`idcategorias`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  UNIQUE INDEX `idcategorias_UNIQUE` (`idcategorias` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda_venta`.`productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_venta`.`productos` ;

CREATE TABLE IF NOT EXISTS `tienda_venta`.`productos` (
  `idproductos` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` DOUBLE NOT NULL,
  `marca` VARCHAR(45) NULL,
  `cantidad_producto` DOUBLE NULL,
  `imagen_url` LONGTEXT NULL,
  `categorias_idcategorias` INT NULL,
  PRIMARY KEY (`idproductos`),
  INDEX `fk_productos_categorias1_idx` (`categorias_idcategorias` ASC) VISIBLE,
  CONSTRAINT `fk_productos_categorias1`
    FOREIGN KEY (`categorias_idcategorias`)
    REFERENCES `tienda_venta`.`categorias` (`idcategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda_venta`.`factura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_venta`.`factura` ;

CREATE TABLE IF NOT EXISTS `tienda_venta`.`factura` (
  `idfactura` INT NOT NULL AUTO_INCREMENT,
  `fecha_venta` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `forma_pago` VARCHAR(45) NOT NULL,
  `igv_total` DOUBLE NOT NULL,
  `monto_total` DOUBLE NOT NULL,
  `cliente_idcliente` INT NULL,
  `encargado_idencargado` INT NULL,
  PRIMARY KEY (`idfactura`),
  INDEX `fk_factura_cliente_idx` (`cliente_idcliente` ASC) VISIBLE,
  INDEX `fk_factura_encargado1_idx` (`encargado_idencargado` ASC) VISIBLE,
  CONSTRAINT `fk_factura_cliente`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `tienda_venta`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_encargado1`
    FOREIGN KEY (`encargado_idencargado`)
    REFERENCES `tienda_venta`.`encargado` (`idencargado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda_venta`.`pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_venta`.`pedidos` ;

CREATE TABLE IF NOT EXISTS `tienda_venta`.`pedidos` (
  `idpedidos` INT NOT NULL,
  `idcliente` VARCHAR(45) NULL,
  `forma_pago` VARCHAR(45) NULL,
  `fecha_pedido` VARCHAR(45) NULL,
  `hora` VARCHAR(45) NULL,
  `igv_total` VARCHAR(45) NULL,
  `monto_total` VARCHAR(45) NULL,
  `id_detalle_productos` VARCHAR(45) NULL,
  PRIMARY KEY (`idpedidos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda_venta`.`detalles_productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_venta`.`detalles_productos` ;

CREATE TABLE IF NOT EXISTS `tienda_venta`.`detalles_productos` (
  `iddetalles_productos` INT NOT NULL,
  `precio` DOUBLE NULL,
  `cantidad` DOUBLE NULL,
  `monto` DOUBLE NULL,
  `factura_idfactura` INT NULL,
  `productos_idproductos` INT NULL,
  PRIMARY KEY (`iddetalles_productos`),
  INDEX `fk_detalles_productos_factura1_idx` (`factura_idfactura` ASC) VISIBLE,
  INDEX `fk_detalles_productos_productos1_idx` (`productos_idproductos` ASC) VISIBLE,
  CONSTRAINT `fk_detalles_productos_factura1`
    FOREIGN KEY (`factura_idfactura`)
    REFERENCES `tienda_venta`.`factura` (`idfactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalles_productos_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `tienda_venta`.`productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
