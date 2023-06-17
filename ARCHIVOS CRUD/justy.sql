-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-06-2023 a las 19:55:52
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `justy`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docentes`
--

CREATE TABLE `docentes` (
  `idDoc` int(11) NOT NULL,
  `materia` varchar(45) NOT NULL,
  `per_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `docentes`
--

INSERT INTO `docentes` (`idDoc`, `materia`, `per_id`) VALUES
(1, 'Física', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo`
--

CREATE TABLE `grupo` (
  `nomenclatura` varchar(8) NOT NULL,
  `aula` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `grupo`
--

INSERT INTO `grupo` (`nomenclatura`, `aula`) VALUES
('2AMRH', 4),
('6AMPR', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupodoc`
--

CREATE TABLE `grupodoc` (
  `idgrupoDoc` int(11) NOT NULL,
  `grupo_Id` varchar(8) NOT NULL,
  `docente_Id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idPersona` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellidoM` varchar(45) NOT NULL,
  `apellidoP` varchar(45) NOT NULL,
  `telefono` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idPersona`, `nombre`, `apellidoM`, `apellidoP`, `telefono`) VALUES
(1, 'Mariana Jetzuvely', 'Hau', 'Garcia', '9831171500'),
(4, 'Erika itzel', 'May', 'May', '9834828292');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `password`) VALUES
(1, 'Mariana', '1234'),
(3, 'Noé', '4321'),
(4, 'Erika', '2468'),
(5, 'Edward ', 'lalo');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `docentes`
--
ALTER TABLE `docentes`
  ADD PRIMARY KEY (`idDoc`),
  ADD KEY `per_id` (`per_id`);

--
-- Indices de la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD PRIMARY KEY (`nomenclatura`);

--
-- Indices de la tabla `grupodoc`
--
ALTER TABLE `grupodoc`
  ADD PRIMARY KEY (`idgrupoDoc`),
  ADD KEY `docente_Id` (`docente_Id`),
  ADD KEY `grupo_Id` (`grupo_Id`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idPersona`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `docentes`
--
ALTER TABLE `docentes`
  MODIFY `idDoc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `grupodoc`
--
ALTER TABLE `grupodoc`
  MODIFY `idgrupoDoc` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idPersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `docentes`
--
ALTER TABLE `docentes`
  ADD CONSTRAINT `docentes_ibfk_1` FOREIGN KEY (`per_id`) REFERENCES `persona` (`idPersona`);

--
-- Filtros para la tabla `grupodoc`
--
ALTER TABLE `grupodoc`
  ADD CONSTRAINT `grupodoc_ibfk_1` FOREIGN KEY (`docente_Id`) REFERENCES `docentes` (`idDoc`),
  ADD CONSTRAINT `grupodoc_ibfk_2` FOREIGN KEY (`grupo_Id`) REFERENCES `grupo` (`nomenclatura`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
