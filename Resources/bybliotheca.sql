-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-05-2023 a las 22:02:50
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bybliotheca`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `genre` varchar(255) DEFAULT NULL,
  `npages` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `year` int(11) NOT NULL,
  `summary` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `books`
--

INSERT INTO `books` (`id`, `author`, `genre`, `npages`, `qty`, `title`, `year`, `summary`) VALUES
(0, 'J. R. R. Tolkien', 'Fantasy', 527, 14, 'The Fellowship of the Ring', 1954, 'In a sleepy village in the Shire, a young hobbit is entrusted with an immense task. He must make a perilous journey across Middle-earth to the Cracks of Doom, there to destroy the Ruling Ring of Power — the only thing that prevents the Dark Lord\'s evil do');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `borrowings`
--

CREATE TABLE `borrowings` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `borrow_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favs`
--

CREATE TABLE `favs` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hibernate_sequence`
--

CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `hibernate_sequence`
--

INSERT INTO `hibernate_sequence` (`next_val`) VALUES
(6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `active` int(11) NOT NULL,
  `deleted` int(11) NOT NULL,
  `dni` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `active`, `deleted`, `dni`, `email`, `name`, `password`, `role`, `surname`, `username`, `token`) VALUES
(0, 1, 0, '99999999A', 'ana.21guns@gmail.com', 'Admin', 'admin', 'ADMIN', 'wiwito', 'admin', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `borrowings`
--
ALTER TABLE `borrowings`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `favs`
--
ALTER TABLE `favs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
