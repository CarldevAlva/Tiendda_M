-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_tiendaRe
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_tiendaRe` ;

-- -----------------------------------------------------
-- Schema db_tiendaRe
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_tiendaRe` DEFAULT CHARACTER SET utf8 COLLATE utf8_czech_ci ;
USE `db_tiendaRe` ;

-- -----------------------------------------------------
-- Table `db_tiendaRe`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_tiendaRe`.`cliente` ;

CREATE TABLE IF NOT EXISTS `db_tiendaRe`.`cliente` (
  `idcliente` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `dni` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) VISIBLE,
  UNIQUE INDEX `idcliente_UNIQUE` (`idcliente` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_tiendaRe`.`encargado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_tiendaRe`.`encargado` ;

CREATE TABLE IF NOT EXISTS `db_tiendaRe`.`encargado` (
  `idencargado` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(12) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `dni` VARCHAR(12) NOT NULL,
  `fecha_nacimiendo` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `tipo_empleado` VARCHAR(12) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `imagen_url` LONGTEXT NULL,
  PRIMARY KEY (`idencargado`),
  UNIQUE INDEX `idencargado_UNIQUE` (`idencargado` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_tiendaRe`.`categorias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_tiendaRe`.`categorias` ;

CREATE TABLE IF NOT EXISTS `db_tiendaRe`.`categorias` (
  `idcategorias` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `imagen_url` LONGTEXT NULL,
  PRIMARY KEY (`idcategorias`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  UNIQUE INDEX `idcategorias_UNIQUE` (`idcategorias` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_tiendaRe`.`productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_tiendaRe`.`productos` ;

CREATE TABLE IF NOT EXISTS `db_tiendaRe`.`productos` (
  `idproductos` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `precio` DOUBLE NULL,
  `marca` VARCHAR(45) NULL,
  `cantidad_producto` DOUBLE NULL,
  `imagen_url` LONGTEXT NULL,
  `categorias_idcategorias` VARCHAR(45) NULL,
  PRIMARY KEY (`idproductos`),
  INDEX `fk_productos_categorias1_idx` (`categorias_idcategorias` ASC) VISIBLE,
  CONSTRAINT `fk_productos_categorias1`
    FOREIGN KEY (`categorias_idcategorias`)
    REFERENCES `db_tiendaRe`.`categorias` (`idcategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_tiendaRe`.`factura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_tiendaRe`.`factura` ;

CREATE TABLE IF NOT EXISTS `db_tiendaRe`.`factura` (
  `idfactura` VARCHAR(45) NOT NULL,
  `fecha_venta` DATE NULL,
  `hora` TIME NULL,
  `forma_pago` VARCHAR(45) NULL,
  `igv_total` DOUBLE NULL,
  `monto_total` DOUBLE NULL,
  `cliente_idcliente` VARCHAR(45) NULL,
  `encargado_idencargado` VARCHAR(45) NULL,
  PRIMARY KEY (`idfactura`),
  INDEX `fk_factura_cliente_idx` (`cliente_idcliente` ASC) VISIBLE,
  INDEX `fk_factura_encargado1_idx` (`encargado_idencargado` ASC) VISIBLE,
  CONSTRAINT `fk_factura_cliente`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `db_tiendaRe`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_encargado1`
    FOREIGN KEY (`encargado_idencargado`)
    REFERENCES `db_tiendaRe`.`encargado` (`idencargado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_tiendaRe`.`pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_tiendaRe`.`pedidos` ;

CREATE TABLE IF NOT EXISTS `db_tiendaRe`.`pedidos` (
  `idpedidos` INT NOT NULL,
  `idcliente` VARCHAR(45) NULL,
  `idvendedor` VARCHAR(45) NULL,
  `forma_pago` VARCHAR(45) NULL,
  `fecha_pedido` VARCHAR(45) NULL,
  `hora` VARCHAR(45) NULL,
  `igv_total` VARCHAR(45) NULL,
  `monto_total` VARCHAR(45) NULL,
  `id_detalle_productos` VARCHAR(45) NULL,
  PRIMARY KEY (`idpedidos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_tiendaRe`.`detalles_productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_tiendaRe`.`detalles_productos` ;

CREATE TABLE IF NOT EXISTS `db_tiendaRe`.`detalles_productos` (
  `iddetalles_productos` VARCHAR(45) NOT NULL,
  `precio_salida` DOUBLE NULL,
  `cantidad` DOUBLE NULL,
  `monto` DOUBLE NULL,
  `productos_idproductos` VARCHAR(45) NULL,
  `factura_idfactura` VARCHAR(45) NULL,
  PRIMARY KEY (`iddetalles_productos`),
  INDEX `fk_detalles_productos_productos1_idx` (`productos_idproductos` ASC) VISIBLE,
  INDEX `fk_detalles_productos_factura1_idx` (`factura_idfactura` ASC) VISIBLE,
  CONSTRAINT `fk_detalles_productos_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `db_tiendaRe`.`productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalles_productos_factura1`
    FOREIGN KEY (`factura_idfactura`)
    REFERENCES `db_tiendaRe`.`factura` (`idfactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
