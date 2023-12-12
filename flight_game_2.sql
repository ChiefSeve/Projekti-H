-- --------------------------------------------------------
-- Verkkotietokone:              127.0.0.1
-- Palvelinversio:               11.1.2-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Versio:              12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for flight_game
DROP DATABASE IF EXISTS `flight_game`;
CREATE DATABASE IF NOT EXISTS `flight_game` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `flight_game`;

-- Dumping structure for taulu flight_game.airport
DROP TABLE IF EXISTS `airport`;
CREATE TABLE IF NOT EXISTS `airport` (
  `id` int(11) NOT NULL,
  `ident` varchar(40) NOT NULL,
  `type` varchar(40) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `latitude_deg` double DEFAULT NULL,
  `longitude_deg` double DEFAULT NULL,
  `iso_region` varchar(40) DEFAULT NULL,
  `weather_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ident`),
  KEY `weather_id` (`weather_id`),
  CONSTRAINT `weather_fk` FOREIGN KEY (`weather_id`) REFERENCES `weather` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table flight_game.airport: ~66 rows (suunnilleen)
DELETE FROM `airport`;
INSERT INTO `airport` (`id`, `ident`, `type`, `name`, `latitude_deg`, `longitude_deg`, `iso_region`, `weather_id`) VALUES
	(3364, 'KADW', 'large_airport', 'Joint Base Andrews', 38.810799, -76.866997, 'Camp Springs', 29),
	(3384, 'KATL', 'large_airport', 'Hartsfield Jackson Atlanta International', 33.6367, -84.428101, 'Atlanta', 12),
	(3386, 'KAUS', 'large_airport', 'Austin Bergstrom International Airport', 30.197535, -97.662015, 'Austin', 17),
	(3420, 'KBNA', 'large_airport', 'Nashville International Airport', 36.1245002746582, -86.6781997680664, 'Nashville', 12),
	(3422, 'KBOS', 'large_airport', 'Logan International Airport', 42.3643, -71.005203, 'Boston', 19),
	(3431, 'KBUF', 'large_airport', 'Buffalo Niagara International Airport', 42.94049835, -78.73220062, 'Buffalo', 12),
	(3435, 'KBWI', 'large_airport', 'Baltimore/Washington International Thurg', 39.1754, -76.668297, 'Baltimore', 6),
	(3454, 'KCLE', 'large_airport', 'Cleveland Hopkins International Airport', 41.4117012024, -81.8498001099, 'Cleveland', 2),
	(3457, 'KCLT', 'large_airport', 'Charlotte Douglas International Airport', 35.2140007019043, -80.94309997558594, 'Charlotte', 12),
	(19517, 'KCMA', 'large_airport', 'Camarillo International Airport', 34.213699, -119.094002, 'Camarillo', 6),
	(3458, 'KCMH', 'large_airport', 'John Glenn Columbus International Airpor', 39.998001, -82.891899, 'Columbus', 19),
	(3471, 'KCVG', 'large_airport', 'Cincinnati Northern Kentucky Internation', 39.048801, -84.667801, 'Cincinnati / Covington', 33),
	(3483, 'KDCA', 'large_airport', 'Ronald Reagan Washington National Airpor', 38.8521, -77.037697, 'Washington', 25),
	(3486, 'KDEN', 'large_airport', 'Denver International Airport', 39.861698150635, -104.672996521, 'Denver', 27),
	(3488, 'KDFW', 'large_airport', 'Dallas Fort Worth International Airport', 32.896801, -97.038002, 'Dallas-Fort Worth', 15),
	(3497, 'KDTW', 'large_airport', 'Detroit Metropolitan Wayne County Airpor', 42.212398529052734, -83.35340118408203, 'Detroit', 33),
	(3521, 'KEWR', 'large_airport', 'Newark Liberty International Airport', 40.692501, -74.168701, 'New York', 12),
	(3531, 'KFLL', 'large_airport', 'Fort Lauderdale Hollywood International ', 26.072599, -80.152702, 'Fort Lauderdale', 1),
	(3602, 'KIAD', 'large_airport', 'Washington Dulles International Airport', 38.9445, -77.455803, 'Washington', 33),
	(3604, 'KIAH', 'large_airport', 'George Bush Intercontinental Houston Air', 29.984399795532227, -95.34140014648438, 'Houston', 16),
	(3610, 'KIND', 'large_airport', 'Indianapolis International Airport', 39.7173, -86.294403, 'Indianapolis', 5),
	(3620, 'KJAX', 'large_airport', 'Jacksonville International Airport', 30.49410057067871, -81.68789672851562, 'Jacksonville', 2),
	(3622, 'KJFK', 'large_airport', 'John F Kennedy International Airport', 40.639801, -73.7789, 'New York', 4),
	(3631, 'KLAS', 'large_airport', 'McCarran International Airport', 36.08010101, -115.1520004, 'Las Vegas', 25),
	(3632, 'KLAX', 'large_airport', 'Los Angeles International Airport', 33.942501, -118.407997, 'Los Angeles', 14),
	(3643, 'KLGA', 'large_airport', 'La Guardia Airport', 40.777199, -73.872597, 'New York', 8),
	(3668, 'KMCI', 'large_airport', 'Kansas City International Airport', 39.2976, -94.713898, 'Kansas City', 15),
	(3670, 'KMCO', 'large_airport', 'Orlando International Airport', 28.429399490356445, -81.30899810791016, 'Orlando', 4),
	(3673, 'KMDW', 'large_airport', 'Chicago Midway International Airport', 41.785999, -87.752403, 'Chicago', 3),
	(3675, 'KMEM', 'large_airport', 'Memphis International Airport', 35.04240036010742, -89.97669982910156, 'Memphis', 1),
	(3685, 'KMIA', 'large_airport', 'Miami International Airport', 25.79319953918457, -80.29060363769531, 'Miami', 9),
	(3690, 'KMKE', 'large_airport', 'General Mitchell International Airport', 42.947200775146484, -87.89659881591797, 'Milwaukee', 1),
	(3709, 'KMSP', 'large_airport', 'Minneapolisâ€“Saint Paul International A', 44.882, -93.221802, 'Minneapolis', 25),
	(3711, 'KMSY', 'large_airport', 'Louis Armstrong New Orleans Internationa', 29.99340057373047, -90.25800323486328, 'New Orleans', 28),
	(3744, 'KOAK', 'large_airport', 'Metropolitan Oakland International Airpo', 37.721298, -122.221001, 'Oakland', 4),
	(3752, 'KONT', 'large_airport', 'Ontario International Airport', 34.055999755859375, -117.60099792480469, 'Ontario', 7),
	(3754, 'KORD', 'large_airport', 'Chicago O\'Hare International Airport', 41.9786, -87.9048, 'Chicago', 19),
	(3766, 'KPBI', 'large_airport', 'Palm Beach International Airport', 26.68320083618164, -80.09559631347656, 'West Palm Beach', 19),
	(3768, 'KPDX', 'large_airport', 'Portland International Airport', 45.58869934, -122.5979996, 'Portland', 28),
	(3771, 'KPHL', 'large_airport', 'Philadelphia International Airport', 39.87189865112305, -75.24109649658203, 'Philadelphia', 2),
	(3772, 'KPHX', 'large_airport', 'Phoenix Sky Harbor International Airport', 33.435302, -112.005905, 'Phoenix', 3),
	(3778, 'KPIT', 'large_airport', 'Pittsburgh International Airport', 40.49150085, -80.23290253, 'Pittsburgh', 25),
	(3795, 'KPVD', 'large_airport', 'Theodore Francis Green State Airport', 41.725038, -71.425668, 'Providence', 8),
	(3796, 'KPWM', 'large_airport', 'Portland International Jetport', 43.646198, -70.309303, 'Portland', 8),
	(3844, 'KRDU', 'large_airport', 'Raleigh Durham International Airport', 35.877601623535156, -78.7874984741211, 'Raleigh/Durham', 14),
	(3847, 'KRIC', 'large_airport', 'Richmond International Airport', 37.50519943237305, -77.3197021484375, 'Richmond', 14),
	(3853, 'KRNO', 'large_airport', 'Reno Tahoe International Airport', 39.49909973144531, -119.76799774169922, 'Reno', 1),
	(3858, 'KRSW', 'large_airport', 'Southwest Florida International Airport', 26.53619956970215, -81.75520324707031, 'Fort Myers', 20),
	(3862, 'KSAN', 'large_airport', 'San Diego International Airport', 32.7336006165, -117.190002441, 'San Diego', 1),
	(3863, 'KSAT', 'large_airport', 'San Antonio International Airport', 29.533701, -98.469803, 'San Antonio', 20),
	(3864, 'KSAV', 'large_airport', 'Savannah Hilton Head International Airpo', 32.12760162, -81.20210266, 'Savannah', 19),
	(3873, 'KSDF', 'large_airport', 'Louisville Muhammad Ali International Ai', 38.1744, -85.736, 'Louisville', 34),
	(3875, 'KSEA', 'large_airport', 'Seattle Tacoma International Airport', 47.449001, -122.308998, 'Seattle', 34),
	(3876, 'KSFB', 'large_airport', 'Orlando Sanford International Airport', 28.777599334716797, -81.23750305175781, 'Orlando', 3),
	(3878, 'KSFO', 'large_airport', 'San Francisco International Airport', 37.61899948120117, -122.375, 'San Francisco', 27),
	(3883, 'KSJC', 'large_airport', 'Norman Y. Mineta San Jose International ', 37.362598, -121.929001, 'San Jose', 7),
	(3887, 'KSLC', 'large_airport', 'Salt Lake City International Airport', 40.785749, -111.979746, 'Salt Lake City', 27),
	(3892, 'KSMF', 'large_airport', 'Sacramento International Airport', 38.69540023803711, -121.59100341796875, 'Sacramento', 1),
	(3905, 'KSTL', 'large_airport', 'St Louis Lambert International Airport', 38.748697, -90.370003, 'St Louis', 20),
	(3913, 'KSYR', 'large_airport', 'Syracuse Hancock International Airport', 43.11119842529297, -76.1063003540039, 'Syracuse', 16),
	(3926, 'KTPA', 'large_airport', 'Tampa International Airport', 27.975500106811523, -82.533203125, 'Tampa', 25),
	(3930, 'KTUL', 'large_airport', 'Tulsa International Airport', 36.19839859008789, -95.88809967041016, 'Tulsa', 6),
	(342308, 'LHS', 'large_airport', 'Lake Havasu City International Airport', 34.43826, -114.222531, 'Lake Havasu City', 4);
-- Dumping structure for taulu flight_game.game
DROP TABLE IF EXISTS `game`;
CREATE TABLE IF NOT EXISTS `game` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `frustration` int(8) unsigned zerofill NOT NULL,
  `location` varchar(10) DEFAULT NULL,
  `screen_name` varchar(40) DEFAULT NULL,
  `weather_id` int(10) DEFAULT NULL,
  `region_goal` varchar(50) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `flight_range` int(11) DEFAULT NULL,
  `jumps` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location` (`location`),
  CONSTRAINT `game_ibfk_1` FOREIGN KEY (`location`) REFERENCES `airport` (`ident`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table flight_game.game: ~4 rows (suunnilleen)
DELETE FROM `game`;
INSERT INTO `game` (`id`, `frustration`, `location`, `screen_name`, `weather_id`, `region_goal`, `score`, `flight_range`, `jumps`) VALUES
	(4, 00000000, 'KONT', 'testi', 1, NULL, 0, 2778, 0),
	(10, 00000025, 'KSMF', 'testiname', 7, NULL, 0, 2778, 0),
	(11, 00000000, 'KABE', 'testi1', 2, NULL, 0, 2778, 0),
	(12, 00000000, 'KSMF', 'Uusiman', 4, NULL, 0, 2778, 0),
	(13, 00000000, 'KMKE', 'Foobar123', 28, NULL, 0, 2778, 0);

-- Dumping structure for taulu flight_game.weather
DROP TABLE IF EXISTS `weather`;
CREATE TABLE IF NOT EXISTS `weather` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` text NOT NULL,
  `temperature` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table flight_game.weather: ~23 rows (suunnilleen)
DELETE FROM `weather`;
INSERT INTO `weather` (`id`, `status`, `temperature`) VALUES
	(1, 'pilvinen', 20),
	(2, 'aurinkoinen', 25),
	(3, 'sumuinen', 0),
	(4, 'sumuinen', 15),
	(5, 'luminen', 0),
	(6, 'sateinen', 25),
	(7, 'pilvinen', -5),
	(8, 'aurinkoinen', 5),
	(9, 'sateinen', 20),
	(12, 'pilvinen', -10),
	(14, 'pilvinen', 30),
	(15, 'sumuinen', 10),
	(16, 'aurinkoinen', 15),
	(17, 'luminen', -10),
	(19, 'pilvinen', 5),
	(20, 'sateinen', 5),
	(25, 'aurinkoinen', -10),
	(27, 'pilvinen', 25),
	(28, 'sateinen', 30),
	(29, 'aurinkoinen', 30),
	(33, 'pilvinen', -15),
	(34, 'aurinkoinen', 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
