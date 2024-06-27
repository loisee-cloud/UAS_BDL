-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 26 Jun 2024 pada 10.30
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uas`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `customer`
--

CREATE TABLE `customer` (
  `customerID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `customer`
--

INSERT INTO `customer` (`customerID`, `Name`, `Email`, `Phone`, `Address`) VALUES
(1, 'John_Doe', 'johndoe@example.com', '1234567890', '123_Elm_Street'),
(2, 'Jane', 'janesmith@example.com', '0987654321', '456_Maple_Avenue');

-- --------------------------------------------------------

--
-- Struktur dari tabel `product`
--

CREATE TABLE `product` (
  `ProductID` int(11) NOT NULL,
  `ProductName` varchar(100) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Stoc` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `product`
--

INSERT INTO `product` (`ProductID`, `ProductName`, `Price`, `Stoc`) VALUES
(1, 'Laptop', 1000.00, 10),
(2, 'Mouse', 20.00, 100),
(3, 'Keyboard', 50.00, 50);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sales`
--

CREATE TABLE `sales` (
  `SalesID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `SalesDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `sales`
--

INSERT INTO `sales` (`SalesID`, `CustomerID`, `SalesDate`) VALUES
(1, 1, '2024-06-25'),
(2, 2, '2024-06-26');

-- --------------------------------------------------------

--
-- Struktur dari tabel `salesdetail`
--

CREATE TABLE `salesdetail` (
  `SalesDetailID` int(11) NOT NULL,
  `SalesID` int(11) DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `TotalPrice` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `salesdetail`
--

INSERT INTO `salesdetail` (`SalesDetailID`, `SalesID`, `ProductID`, `Quantity`, `TotalPrice`) VALUES
(1, 1, 1, 1, 1000.00),
(2, 1, 2, 2, 40.00),
(3, 2, 3, 1, 50.00);

--
-- Trigger `salesdetail`
--
DELIMITER $$
CREATE TRIGGER `CheckStockBeforeSale` BEFORE INSERT ON `salesdetail` FOR EACH ROW BEGIN
    DECLARE StockAvailable INT;
    SELECT Stock INTO StockAvailable FROM Product WHERE ProductID = NEW.ProductID;
    
    IF StockAvailable < NEW.Quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough stock available';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ReduceStockAfterSale` AFTER INSERT ON `salesdetail` FOR EACH ROW BEGIN
    UPDATE Product
    SET Stock = Stock - NEW.Quantity
    WHERE ProductID = NEW.ProductID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `salesdetailview`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `salesdetailview` (
`SalesID` int(11)
,`CustomerName` varchar(100)
,`ProductName` varchar(100)
,`Quantity` int(11)
,`TotalPrice` decimal(10,2)
,`SalesDate` date
);

-- --------------------------------------------------------

--
-- Struktur untuk view `salesdetailview`
--
DROP TABLE IF EXISTS `salesdetailview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `salesdetailview`  AS SELECT `s`.`SalesID` AS `SalesID`, `c`.`Name` AS `CustomerName`, `p`.`ProductName` AS `ProductName`, `sd`.`Quantity` AS `Quantity`, `sd`.`TotalPrice` AS `TotalPrice`, `s`.`SalesDate` AS `SalesDate` FROM (((`salesdetail` `sd` join `sales` `s` on(`sd`.`SalesID` = `s`.`SalesID`)) join `product` `p` on(`sd`.`ProductID` = `p`.`ProductID`)) join `customer` `c` on(`s`.`CustomerID` = `c`.`customerID`)) ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customerID`);

--
-- Indeks untuk tabel `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`ProductID`),
  ADD KEY `idx_product_name` (`ProductName`);

--
-- Indeks untuk tabel `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`SalesID`),
  ADD KEY `idx_customer_id` (`CustomerID`),
  ADD KEY `idx_sales_date` (`SalesDate`);

--
-- Indeks untuk tabel `salesdetail`
--
ALTER TABLE `salesdetail`
  ADD PRIMARY KEY (`SalesDetailID`),
  ADD KEY `SalesID` (`SalesID`),
  ADD KEY `idx_product_sales` (`ProductID`,`SalesID`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `customer`
--
ALTER TABLE `customer`
  MODIFY `customerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `product`
--
ALTER TABLE `product`
  MODIFY `ProductID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `sales`
--
ALTER TABLE `sales`
  MODIFY `SalesID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `salesdetail`
--
ALTER TABLE `salesdetail`
  MODIFY `SalesDetailID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`customerID`);

--
-- Ketidakleluasaan untuk tabel `salesdetail`
--
ALTER TABLE `salesdetail`
  ADD CONSTRAINT `salesdetail_ibfk_1` FOREIGN KEY (`SalesID`) REFERENCES `sales` (`SalesID`),
  ADD CONSTRAINT `salesdetail_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProductID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
