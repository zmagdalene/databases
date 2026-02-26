-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-container
-- Generation Time: Feb 26, 2026 at 03:16 PM
-- Server version: 8.0.45
-- PHP Version: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `moviesdb`
--
CREATE DATABASE IF NOT EXISTS `moviesdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `moviesdb`;

-- --------------------------------------------------------

--
-- Table structure for table `Directors`
--

CREATE TABLE `Directors` (
  `director_id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Directors`
--

INSERT INTO `Directors` (`director_id`, `name`, `nationality`, `dob`) VALUES
(1, 'Christopher Nolan', 'English', '1970-07-30'),
(2, 'Jaume Collet-Serra', 'Spanish', '1974-03-23'),
(3, 'Paul Greengrass', 'English', '1955-08-13'),
(4, 'Sam Taylor-Johnson', 'English', '1967-03-04');

-- --------------------------------------------------------

--
-- Table structure for table `Movies`
--

CREATE TABLE `Movies` (
  `id` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `genre` varchar(255) DEFAULT NULL,
  `year` year DEFAULT NULL,
  `box_office` int DEFAULT NULL,
  `director_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Movies`
--

INSERT INTO `Movies` (`id`, `title`, `genre`, `year`, `box_office`, `director_id`) VALUES
(1, 'Oppenheimer', 'film noir', '2023', 954, 1),
(2, 'Dunkirk', 'action', '2017', 527, 1),
(3, 'Jungle Cruise', 'adventure', '2021', 221, 2),
(4, 'Jason Bourne', 'action-thriller', '2016', 415, 3),
(5, 'The Bourne Ultimatum', 'action-thriller', '2007', 444, 3),
(6, 'Back to Black', 'biopic', '2024', 51, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Directors`
--
ALTER TABLE `Directors`
  ADD PRIMARY KEY (`director_id`);

--
-- Indexes for table `Movies`
--
ALTER TABLE `Movies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `director_id` (`director_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Directors`
--
ALTER TABLE `Directors`
  MODIFY `director_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Movies`
--
ALTER TABLE `Movies`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Movies`
--
ALTER TABLE `Movies`
  ADD CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`director_id`) REFERENCES `Directors` (`director_id`);
--
-- Database: `movies_zoembikakeu`
--
CREATE DATABASE IF NOT EXISTS `movies_zoembikakeu` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `movies_zoembikakeu`;

-- --------------------------------------------------------

--
-- Table structure for table `actors_table`
--

CREATE TABLE `actors_table` (
  `actor_id` int NOT NULL,
  `actor_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `movie_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `actors_table`
--

INSERT INTO `actors_table` (`actor_id`, `actor_name`, `movie_id`) VALUES
(1, 'Leonardo DiCaprio', 1),
(2, 'Matthew McConaughey', 2),
(3, 'Killian Murphy', 3),
(5, 'Timothy Chalamet', 7);

-- --------------------------------------------------------

--
-- Table structure for table `directors_table`
--

CREATE TABLE `directors_table` (
  `director_id` int NOT NULL,
  `director_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `directors_table`
--

INSERT INTO `directors_table` (`director_id`, `director_name`) VALUES
(1, 'Christopher Nolan'),
(2, 'Jaume Collet-Serra');

-- --------------------------------------------------------

--
-- Table structure for table `movies_table`
--

CREATE TABLE `movies_table` (
  `movie_id` int NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `release_year` year DEFAULT NULL,
  `box_office` decimal(10,1) NOT NULL,
  `genre` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `director_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_table`
--

INSERT INTO `movies_table` (`movie_id`, `title`, `release_year`, `box_office`, `genre`, `director_id`) VALUES
(1, 'Inception', '2010', 829.9, 'Science Fiction', 1),
(3, 'Dunkerque', '2017', 527.0, 'War', 1),
(4, 'Jungle Cruise', '2021', 100.0, 'Adventure', 2),
(5, 'The Dark Knight', '2008', 1004.9, 'Action', 1),
(6, 'Oppenheimer', '2023', 952.0, 'Drama', 1),
(7, 'Dune: Part Two', '2024', 714.8, 'Science Fiction', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actors_table`
--
ALTER TABLE `actors_table`
  ADD PRIMARY KEY (`actor_id`);

--
-- Indexes for table `directors_table`
--
ALTER TABLE `directors_table`
  ADD PRIMARY KEY (`director_id`);

--
-- Indexes for table `movies_table`
--
ALTER TABLE `movies_table`
  ADD PRIMARY KEY (`movie_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `actors_table`
--
ALTER TABLE `actors_table`
  MODIFY `actor_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `directors_table`
--
ALTER TABLE `directors_table`
  MODIFY `director_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `movies_table`
--
ALTER TABLE `movies_table`
  MODIFY `movie_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- Database: `retail_store`
--
CREATE DATABASE IF NOT EXISTS `retail_store` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `retail_store`;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `email`, `phone`) VALUES
(1, 'Emma', 'Williams', 'emma@example.com', '555-234-7878'),
(2, 'Liam', 'Johnson', 'liam@example.com', '555-434-9876');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `product_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);
--
-- Database: `schooldb`
--
CREATE DATABASE IF NOT EXISTS `schooldb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `schooldb`;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int NOT NULL,
  `course_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `credits` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_id`, `course_name`, `credits`) VALUES
(1, 'Database Systems', 3),
(2, 'Computer Networks', 4),
(3, 'Software Engineering', 3);

-- --------------------------------------------------------

--
-- Table structure for table `enrolments`
--

CREATE TABLE `enrolments` (
  `enrolment_id` int NOT NULL,
  `student_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrolments`
--

INSERT INTO `enrolments` (`enrolment_id`, `student_id`, `course_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(5, 3, 2),
(6, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int NOT NULL,
  `student_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `age` int DEFAULT NULL,
  `enrolment_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `student_name`, `age`, `enrolment_date`) VALUES
(1, 'Alice Johnson', 21, '2021-09-01'),
(2, 'Bob Smith', 22, '2020-09-01'),
(3, 'Charlie Davis', 24, '2019-09-01'),
(4, 'Sarah Mason', 20, '2021-08-02'),
(5, 'John Murphy', 22, '2020-10-03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`);

--
-- Indexes for table `enrolments`
--
ALTER TABLE `enrolments`
  ADD PRIMARY KEY (`enrolment_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `enrolments`
--
ALTER TABLE `enrolments`
  MODIFY `enrolment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `enrolments`
--
ALTER TABLE `enrolments`
  ADD CONSTRAINT `enrolments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `enrolments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);
--
-- Database: `tasksdb`
--
CREATE DATABASE IF NOT EXISTS `tasksdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `tasksdb`;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int NOT NULL,
  `body` char(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `body`) VALUES
(1, 'Finish the project documentation'),
(2, 'Review the codebase for bugs'),
(3, 'Prepare for the client meeting'),
(4, 'Deploy the latest build to production');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Database: `testdb`
--
CREATE DATABASE IF NOT EXISTS `testdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `testdb`;

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `id` int NOT NULL,
  `body` char(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `body`) VALUES
(1, 'Hello how are you today?'),
(2, 'Today is a great day'),
(3, 'The weather is nice'),
(4, 'I am learning Docker');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
