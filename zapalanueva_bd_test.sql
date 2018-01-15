-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-01-2018 a las 04:15:49
-- Versión del servidor: 10.1.26-MariaDB
-- Versión de PHP: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `zapalanueva_bd_test`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calzado`
--

CREATE TABLE `calzado` (
  `id_calzado` int(11) NOT NULL,
  `marca` varchar(200) NOT NULL,
  `modelo` varchar(200) NOT NULL,
  `numeracion` varchar(15) NOT NULL COMMENT '[12 al 21, 22, al 25, 25 al 28, ...]',
  `categoria` varchar(100) NOT NULL COMMENT '[colegial, sandalia, zapatilla, tennis, ...]',
  `genero` char(1) NOT NULL COMMENT '[''h'' = hombre, ''m'' = mujer, ''x'' = mixto]',
  `precio_compra` float NOT NULL,
  `precio_venta` float NOT NULL,
  `stock` int(11) NOT NULL COMMENT 'cantidad de unidades en  almacen'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calzado_compra`
--

CREATE TABLE `calzado_compra` (
  `id_calzadocompra` int(11) NOT NULL COMMENT 'llave primaria',
  `id_calzado` int(11) NOT NULL COMMENT 'llave foranea de la tabla calzado',
  `id_compra` int(11) NOT NULL COMMENT 'llave foranea de la tabla compras',
  `cantidad` int(11) NOT NULL COMMENT 'cantidad de pares comprados',
  `precio_par` float NOT NULL COMMENT 'precio por par',
  `status` varchar(3) NOT NULL DEFAULT 'ok' COMMENT '[ok = aprobado, cnc = cancelado]'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calzado_venta`
--

CREATE TABLE `calzado_venta` (
  `id_calzadoventa` int(11) NOT NULL COMMENT 'llave primaria',
  `id_calzado` int(11) NOT NULL COMMENT 'llave foranea de la tabla calzado',
  `id_venta` int(11) NOT NULL COMMENT 'llave foranea de la tabla ventas',
  `cantidad` int(11) NOT NULL COMMENT 'cantidad del mismo calzado vendido',
  `precio_par` float NOT NULL COMMENT 'precio del par vendido',
  `descripcion_saldo` varchar(250) DEFAULT NULL COMMENT 'en caso de que se venda un calzado ''saldo'' debera permitir agregar una descripcion del calzado vendido',
  `status` varchar(3) NOT NULL DEFAULT 'ok'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compra` int(11) NOT NULL COMMENT 'llave primaria',
  `id_proveedor` int(11) NOT NULL COMMENT 'llave foranea de la tabla proveedor',
  `fecha_creacion` timestamp NULL DEFAULT NULL COMMENT 'fecha de la compra',
  `subtotal` float NOT NULL COMMENT 'monto sin descuento',
  `descuento` float NOT NULL COMMENT 'monto del descuento',
  `total` float NOT NULL COMMENT 'monto total pagado',
  `status` varchar(3) NOT NULL DEFAULT 'ok' COMMENT '[ok = aprobada, cnc = cancelada]'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `egresos`
--

CREATE TABLE `egresos` (
  `id_egreso` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL COMMENT 'llave foranea de la tabla compras',
  `fecha_creacion` timestamp NULL DEFAULT NULL COMMENT 'fecha en que se creo',
  `fecha_vencimiento` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'fecha en que vence el pago',
  `monto` float NOT NULL COMMENT 'monto a pagar',
  `metodo_pago` varchar(20) NOT NULL COMMENT '[cheque, tranferencia, contado]',
  `status` varchar(3) NOT NULL DEFAULT 'nop' COMMENT '[nop = no pagada, ok = pagada, cnc = cancelada]'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL COMMENT 'nombre del proveedor',
  `tienda` varchar(200) NOT NULL COMMENT 'nombre de la tienda del proveedor',
  `status` varchar(3) NOT NULL DEFAULT 'ok' COMMENT '[ok = activo, des = desactivo]'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `subtotal` float NOT NULL COMMENT 'monto sin descuento',
  `descuento` float NOT NULL COMMENT 'monto del descuento',
  `total` float NOT NULL COMMENT 'monto total pagado',
  `status` varchar(3) NOT NULL DEFAULT 'ok' COMMENT '[ok = aprobada, cnc = cancelada, cbd = cambiada]'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `calzado`
--
ALTER TABLE `calzado`
  ADD PRIMARY KEY (`id_calzado`);

--
-- Indices de la tabla `calzado_compra`
--
ALTER TABLE `calzado_compra`
  ADD PRIMARY KEY (`id_calzadocompra`),
  ADD KEY `id_calzado` (`id_calzado`),
  ADD KEY `id_compra` (`id_compra`);

--
-- Indices de la tabla `calzado_venta`
--
ALTER TABLE `calzado_venta`
  ADD PRIMARY KEY (`id_calzadoventa`),
  ADD KEY `id_calzado` (`id_calzado`),
  ADD KEY `id_venta` (`id_venta`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `egresos`
--
ALTER TABLE `egresos`
  ADD PRIMARY KEY (`id_egreso`),
  ADD KEY `id_compra` (`id_compra`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `calzado`
--
ALTER TABLE `calzado`
  MODIFY `id_calzado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `calzado_compra`
--
ALTER TABLE `calzado_compra`
  MODIFY `id_calzadocompra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave primaria';

--
-- AUTO_INCREMENT de la tabla `calzado_venta`
--
ALTER TABLE `calzado_venta`
  MODIFY `id_calzadoventa` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave primaria';

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'llave primaria';

--
-- AUTO_INCREMENT de la tabla `egresos`
--
ALTER TABLE `egresos`
  MODIFY `id_egreso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calzado_compra`
--
ALTER TABLE `calzado_compra`
  ADD CONSTRAINT `calzado_compra_ibfk_1` FOREIGN KEY (`id_calzado`) REFERENCES `calzado` (`id_calzado`) ON UPDATE CASCADE,
  ADD CONSTRAINT `calzado_compra_ibfk_2` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `calzado_venta`
--
ALTER TABLE `calzado_venta`
  ADD CONSTRAINT `calzado_venta_ibfk_1` FOREIGN KEY (`id_calzado`) REFERENCES `calzado` (`id_calzado`) ON UPDATE CASCADE,
  ADD CONSTRAINT `calzado_venta_ibfk_2` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `egresos`
--
ALTER TABLE `egresos`
  ADD CONSTRAINT `egresos_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
