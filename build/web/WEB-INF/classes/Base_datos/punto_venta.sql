-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema punto_venta
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema punto_venta
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `punto_venta` DEFAULT CHARACTER SET utf8mb3 ;
USE `punto_venta` ;

-- -----------------------------------------------------
-- Table `punto_venta`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `punto_venta`.`categorias` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `punto_venta`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `punto_venta`.`proveedores` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono1` INT NOT NULL,
  `telefono2` INT NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `punto_venta`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `punto_venta`.`productos` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `categorias_codigo` INT NOT NULL,
  `proveedores_codigo` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `unidad_medida` INT NOT NULL,
  `precio_unitario` INT NOT NULL,
  `cantidad_ingreso` INT NOT NULL,
  `cantidad_disponible` INT NOT NULL,
  `fecha_ingreso` DATE NOT NULL,
  `fecha_caducidad` DATE NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_productos_proveedores_idx` (`proveedores_codigo` ASC) VISIBLE,
  INDEX `fk_productos_categorias1_idx` (`categorias_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_productos_categorias1`
    FOREIGN KEY (`categorias_codigo`)
    REFERENCES `punto_venta`.`categorias` (`codigo`),
  CONSTRAINT `fk_productos_proveedores`
    FOREIGN KEY (`proveedores_codigo`)
    REFERENCES `punto_venta`.`proveedores` (`codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `punto_venta`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `punto_venta`.`usuario` (
  `idusuario` INT NOT NULL,
  `contrasena` VARCHAR(45) NOT NULL,
  `nombre_completo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
