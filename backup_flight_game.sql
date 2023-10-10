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
  `elevation_ft` int(11) DEFAULT NULL,
  `continent` varchar(40) DEFAULT NULL,
  `iso_country` varchar(40) DEFAULT NULL,
  `iso_region` varchar(40) DEFAULT NULL,
  `municipality` varchar(40) DEFAULT NULL,
  `scheduled_service` varchar(40) DEFAULT NULL,
  `gps_code` varchar(40) DEFAULT NULL,
  `iata_code` varchar(40) DEFAULT NULL,
  `local_code` varchar(40) DEFAULT NULL,
  `home_link` varchar(40) DEFAULT NULL,
  `wikipedia_link` varchar(40) DEFAULT NULL,
  `keywords` varchar(40) DEFAULT NULL,
  `weather_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ident`),
  KEY `iso_country` (`iso_country`),
  KEY `weather_id` (`weather_id`),
  CONSTRAINT `airport_ibfk_1` FOREIGN KEY (`iso_country`) REFERENCES `country` (`iso_country`),
  CONSTRAINT `weather_fk` FOREIGN KEY (`weather_id`) REFERENCES `weather` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table flight_game.airport: ~66 rows (suunnilleen)
DELETE FROM `airport`;
INSERT INTO `airport` (`id`, `ident`, `type`, `name`, `latitude_deg`, `longitude_deg`, `elevation_ft`, `continent`, `iso_country`, `iso_region`, `municipality`, `scheduled_service`, `gps_code`, `iata_code`, `local_code`, `home_link`, `wikipedia_link`, `keywords`, `weather_id`) VALUES
	(3364, 'KADW', 'large_airport', 'Joint Base Andrews', 38.810799, -76.866997, 280, 'NA', 'US', 'US-MD', 'Camp Springs', 'no', 'KADW', 'ADW', 'ADW', 'http://www.jba.af.mil/', 'https://en.wikipedia.org/wiki/Joint_Base', 'Andrews Air Force Base', 29),
	(3384, 'KATL', 'large_airport', 'Hartsfield Jackson Atlanta International', 33.6367, -84.428101, 1026, 'NA', 'US', 'US-GA', 'Atlanta', 'yes', 'KATL', 'ATL', 'ATL', 'http://www.atlanta-airport.com/', 'https://en.wikipedia.org/wiki/Hartsfield', '', 12),
	(3386, 'KAUS', 'large_airport', 'Austin Bergstrom International Airport', 30.197535, -97.662015, 542, 'NA', 'US', 'US-TX', 'Austin', 'yes', 'KAUS', 'AUS', 'AUS', 'http://www.ci.austin.tx.us/austinairport', 'https://en.wikipedia.org/wiki/Austin-Ber', '', 17),
	(3420, 'KBNA', 'large_airport', 'Nashville International Airport', 36.1245002746582, -86.6781997680664, 599, 'NA', 'US', 'US-TN', 'Nashville', 'yes', 'KBNA', 'BNA', 'BNA', '', 'https://en.wikipedia.org/wiki/Nashville_', '', 12),
	(3422, 'KBOS', 'large_airport', 'Logan International Airport', 42.3643, -71.005203, 20, 'NA', 'US', 'US-MA', 'Boston', 'yes', 'KBOS', 'BOS', 'BOS', 'http://www.massport.com/logan/', 'https://en.wikipedia.org/wiki/Logan_Inte', 'General Edward Lawrence Logan Internatio', 19),
	(3431, 'KBUF', 'large_airport', 'Buffalo Niagara International Airport', 42.94049835, -78.73220062, 728, 'NA', 'US', 'US-NY', 'Buffalo', 'yes', 'KBUF', 'BUF', 'BUF', '', 'https://en.wikipedia.org/wiki/Buffalo_Ni', '', 12),
	(3435, 'KBWI', 'large_airport', 'Baltimore/Washington International Thurg', 39.1754, -76.668297, 146, 'NA', 'US', 'US-MD', 'Baltimore', 'yes', 'KBWI', 'BWI', 'BWI', 'https://www.bwiairport.com/', 'https://en.wikipedia.org/wiki/Baltimore%', 'WAS', 6),
	(3454, 'KCLE', 'large_airport', 'Cleveland Hopkins International Airport', 41.4117012024, -81.8498001099, 791, 'NA', 'US', 'US-OH', 'Cleveland', 'yes', 'KCLE', 'CLE', 'CLE', 'http://www.clevelandairport.com/', 'https://en.wikipedia.org/wiki/Cleveland_', '', 2),
	(3457, 'KCLT', 'large_airport', 'Charlotte Douglas International Airport', 35.2140007019043, -80.94309997558594, 748, 'NA', 'US', 'US-NC', 'Charlotte', 'yes', 'KCLT', 'CLT', 'CLT', 'http://www.charlotteairport.com/', 'https://en.wikipedia.org/wiki/Charlotte/', '', 12),
	(19517, 'KCMA', 'large_airport', 'Camarillo International Airport', 34.213699, -119.094002, 77, 'NA', 'US', 'US-CA', 'Camarillo', 'no', 'KCMA', '', 'CMA', '', 'https://en.wikipedia.org/wiki/Camarillo_', '', 6),
	(3458, 'KCMH', 'large_airport', 'John Glenn Columbus International Airpor', 39.998001, -82.891899, 815, 'NA', 'US', 'US-OH', 'Columbus', 'yes', 'KCMH', 'CMH', 'CMH', 'https://flycolumbus.com/', 'https://en.wikipedia.org/wiki/Port_Colum', '', 19),
	(3471, 'KCVG', 'large_airport', 'Cincinnati Northern Kentucky Internation', 39.048801, -84.667801, 896, 'NA', 'US', 'US-KY', 'Cincinnati / Covington', 'yes', 'KCVG', 'CVG', 'CVG', '', 'https://en.wikipedia.org/wiki/Cincinnati', '', 33),
	(3483, 'KDCA', 'large_airport', 'Ronald Reagan Washington National Airpor', 38.8521, -77.037697, 15, 'NA', 'US', 'US-DC', 'Washington', 'yes', 'KDCA', 'DCA', 'DCA', 'http://www.flyreagan.com/dca/reagan-nati', 'https://en.wikipedia.org/wiki/Ronald_Rea', 'WAS', 25),
	(3486, 'KDEN', 'large_airport', 'Denver International Airport', 39.861698150635, -104.672996521, 5431, 'NA', 'US', 'US-CO', 'Denver', 'yes', 'KDEN', 'DEN', 'DEN', 'http://www.flydenver.com/', 'https://en.wikipedia.org/wiki/Denver_Int', 'DVX, KVDX', 27),
	(3488, 'KDFW', 'large_airport', 'Dallas Fort Worth International Airport', 32.896801, -97.038002, 607, 'NA', 'US', 'US-TX', 'Dallas-Fort Worth', 'yes', 'KDFW', 'DFW', 'DFW', 'https://www.dfwairport.com/', 'https://en.wikipedia.org/wiki/Dallas/For', 'QDF', 15),
	(3497, 'KDTW', 'large_airport', 'Detroit Metropolitan Wayne County Airpor', 42.212398529052734, -83.35340118408203, 645, 'NA', 'US', 'US-MI', 'Detroit', 'yes', 'KDTW', 'DTW', 'DTW', 'http://www.metroairport.com/', 'https://en.wikipedia.org/wiki/Detroit_Me', 'DTT, Detroit Metro Airport', 33),
	(3521, 'KEWR', 'large_airport', 'Newark Liberty International Airport', 40.692501, -74.168701, 18, 'NA', 'US', 'US-NJ', 'New York', 'yes', 'KEWR', 'EWR', 'EWR', 'http://www.panynj.gov/CommutingTravel/ai', 'https://en.wikipedia.org/wiki/Newark_Lib', 'Manhattan, New York City, NYC', 12),
	(3531, 'KFLL', 'large_airport', 'Fort Lauderdale Hollywood International ', 26.072599, -80.152702, 9, 'NA', 'US', 'US-FL', 'Fort Lauderdale', 'yes', 'KFLL', 'FLL', 'FLL', 'http://www.broward.org/airport', 'https://en.wikipedia.org/wiki/Fort_Laude', 'MFW, South Florida', 1),
	(3602, 'KIAD', 'large_airport', 'Washington Dulles International Airport', 38.9445, -77.455803, 312, 'NA', 'US', 'US-DC', 'Washington', 'yes', 'KIAD', 'IAD', 'IAD', 'http://www.mwaa.com/dulles/', 'https://en.wikipedia.org/wiki/Washington', 'WAS', 33),
	(3604, 'KIAH', 'large_airport', 'George Bush Intercontinental Houston Air', 29.984399795532227, -95.34140014648438, 97, 'NA', 'US', 'US-TX', 'Houston', 'yes', 'KIAH', 'IAH', 'IAH', 'http://www.fly2houston.com/iah', 'https://en.wikipedia.org/wiki/George_Bus', 'QHO', 16),
	(3610, 'KIND', 'large_airport', 'Indianapolis International Airport', 39.7173, -86.294403, 797, 'NA', 'US', 'US-IN', 'Indianapolis', 'yes', 'KIND', 'IND', 'IND', 'http://www.indianapolisairport.com/', 'https://en.wikipedia.org/wiki/Indianapol', '', 5),
	(3620, 'KJAX', 'large_airport', 'Jacksonville International Airport', 30.49410057067871, -81.68789672851562, 30, 'NA', 'US', 'US-FL', 'Jacksonville', 'yes', 'KJAX', 'JAX', 'JAX', '', 'https://en.wikipedia.org/wiki/Jacksonvil', '', 2),
	(3622, 'KJFK', 'large_airport', 'John F Kennedy International Airport', 40.639801, -73.7789, 13, 'NA', 'US', 'US-NY', 'New York', 'yes', 'KJFK', 'JFK', 'JFK', 'https://www.jfkairport.com/', 'https://en.wikipedia.org/wiki/John_F._Ke', 'Manhattan, New York City, NYC, Idlewild,', 4),
	(3631, 'KLAS', 'large_airport', 'McCarran International Airport', 36.08010101, -115.1520004, 2181, 'NA', 'US', 'US-NV', 'Las Vegas', 'yes', 'KLAS', 'LAS', 'LAS', 'http://www.mccarran.com/', 'https://en.wikipedia.org/wiki/McCarran_I', '', 25),
	(3632, 'KLAX', 'large_airport', 'Los Angeles International Airport', 33.942501, -118.407997, 125, 'NA', 'US', 'US-CA', 'Los Angeles', 'yes', 'KLAX', 'LAX', 'LAX', 'https://www.flylax.com/', 'https://en.wikipedia.org/wiki/Los_Angele', '', 14),
	(3643, 'KLGA', 'large_airport', 'La Guardia Airport', 40.777199, -73.872597, 21, 'NA', 'US', 'US-NY', 'New York', 'yes', 'KLGA', 'LGA', 'LGA', 'https://www.laguardiaairport.com/', 'https://en.wikipedia.org/wiki/LaGuardia_', 'Manhattan, New York City, NYC, Glenn H. ', 8),
	(3668, 'KMCI', 'large_airport', 'Kansas City International Airport', 39.2976, -94.713898, 1026, 'NA', 'US', 'US-MO', 'Kansas City', 'yes', 'KMCI', 'MCI', 'MCI', 'http://www.flykci.com/', 'https://en.wikipedia.org/wiki/Kansas_Cit', '', 15),
	(3670, 'KMCO', 'large_airport', 'Orlando International Airport', 28.429399490356445, -81.30899810791016, 96, 'NA', 'US', 'US-FL', 'Orlando', 'yes', 'KMCO', 'MCO', 'MCO', 'http://www.orlandoairports.net/', 'https://en.wikipedia.org/wiki/Orlando_In', 'Disney World,Epcot Center', 4),
	(3673, 'KMDW', 'large_airport', 'Chicago Midway International Airport', 41.785999, -87.752403, 620, 'NA', 'US', 'US-IL', 'Chicago', 'yes', 'KMDW', 'MDW', 'MDW', 'https://www.flychicago.com/midway/home/p', 'https://en.wikipedia.org/wiki/Midway_Int', 'CHI', 3),
	(3675, 'KMEM', 'large_airport', 'Memphis International Airport', 35.04240036010742, -89.97669982910156, 341, 'NA', 'US', 'US-TN', 'Memphis', 'yes', 'KMEM', 'MEM', 'MEM', '', 'https://en.wikipedia.org/wiki/Memphis_In', '', 1),
	(3685, 'KMIA', 'large_airport', 'Miami International Airport', 25.79319953918457, -80.29060363769531, 8, 'NA', 'US', 'US-FL', 'Miami', 'yes', 'KMIA', 'MIA', 'MIA', 'http://www.miami-airport.com/', 'https://en.wikipedia.org/wiki/Miami_Inte', 'MFW, South Florida', 9),
	(3690, 'KMKE', 'large_airport', 'General Mitchell International Airport', 42.947200775146484, -87.89659881591797, 723, 'NA', 'US', 'US-WI', 'Milwaukee', 'yes', 'KMKE', 'MKE', 'MKE', '', 'https://en.wikipedia.org/wiki/General_Mi', '', 1),
	(3709, 'KMSP', 'large_airport', 'Minneapolisâ€“Saint Paul International A', 44.882, -93.221802, 841, 'NA', 'US', 'US-MN', 'Minneapolis', 'yes', 'KMSP', 'MSP', 'MSP', 'http://www.mspairport.com/', 'https://en.wikipedia.org/wiki/Minneapoli', '', 25),
	(3711, 'KMSY', 'large_airport', 'Louis Armstrong New Orleans Internationa', 29.99340057373047, -90.25800323486328, 4, 'NA', 'US', 'US-LA', 'New Orleans', 'yes', 'KMSY', 'MSY', 'MSY', '', 'https://en.wikipedia.org/wiki/Louis_Arms', '', 28),
	(3744, 'KOAK', 'large_airport', 'Metropolitan Oakland International Airpo', 37.721298, -122.221001, 9, 'NA', 'US', 'US-CA', 'Oakland', 'yes', 'KOAK', 'OAK', 'OAK', 'http://www.oaklandairport.com/', 'https://en.wikipedia.org/wiki/Oakland_In', 'QSF, QBA', 4),
	(3752, 'KONT', 'large_airport', 'Ontario International Airport', 34.055999755859375, -117.60099792480469, 944, 'NA', 'US', 'US-CA', 'Ontario', 'yes', 'KONT', 'ONT', 'ONT', '', 'https://en.wikipedia.org/wiki/LA/Ontario', '', 7),
	(3754, 'KORD', 'large_airport', 'Chicago O\'Hare International Airport', 41.9786, -87.9048, 672, 'NA', 'US', 'US-IL', 'Chicago', 'yes', 'KORD', 'ORD', 'ORD', 'https://www.flychicago.com/ohare/home/pa', 'https://en.wikipedia.org/wiki/O\'Hare_Int', 'CHI, Orchard Place', 19),
	(3766, 'KPBI', 'large_airport', 'Palm Beach International Airport', 26.68320083618164, -80.09559631347656, 19, 'NA', 'US', 'US-FL', 'West Palm Beach', 'yes', 'KPBI', 'PBI', 'PBI', '', 'https://en.wikipedia.org/wiki/Palm_Beach', 'MFW, South Florida', 19),
	(3768, 'KPDX', 'large_airport', 'Portland International Airport', 45.58869934, -122.5979996, 31, 'NA', 'US', 'US-OR', 'Portland', 'yes', 'KPDX', 'PDX', 'PDX', '', 'https://en.wikipedia.org/wiki/Portland_I', '', 28),
	(3771, 'KPHL', 'large_airport', 'Philadelphia International Airport', 39.87189865112305, -75.24109649658203, 36, 'NA', 'US', 'US-PA', 'Philadelphia', 'yes', 'KPHL', 'PHL', 'PHL', 'http://www.phl.org/', 'https://en.wikipedia.org/wiki/Philadelph', '', 2),
	(3772, 'KPHX', 'large_airport', 'Phoenix Sky Harbor International Airport', 33.435302, -112.005905, 1135, 'NA', 'US', 'US-AZ', 'Phoenix', 'yes', 'KPHX', 'PHX', 'PHX', 'http://phoenix.gov/skyharborairport/', 'https://en.wikipedia.org/wiki/Phoenix_Sk', '', 3),
	(3778, 'KPIT', 'large_airport', 'Pittsburgh International Airport', 40.49150085, -80.23290253, 1203, 'NA', 'US', 'US-PA', 'Pittsburgh', 'yes', 'KPIT', 'PIT', 'PIT', '', 'https://en.wikipedia.org/wiki/Pittsburgh', '', 25),
	(3795, 'KPVD', 'large_airport', 'Theodore Francis Green State Airport', 41.725038, -71.425668, 55, 'NA', 'US', 'US-RI', 'Providence', 'yes', 'KPVD', 'PVD', 'PVD', '', 'https://en.wikipedia.org/wiki/T._F._Gree', '', 8),
	(3796, 'KPWM', 'large_airport', 'Portland International Jetport', 43.646198, -70.309303, 76, 'NA', 'US', 'US-ME', 'Portland', 'yes', 'KPWM', 'PWM', 'PWM', '', 'https://en.wikipedia.org/wiki/Portland_I', '', 8),
	(3844, 'KRDU', 'large_airport', 'Raleigh Durham International Airport', 35.877601623535156, -78.7874984741211, 435, 'NA', 'US', 'US-NC', 'Raleigh/Durham', 'yes', 'KRDU', 'RDU', 'RDU', '', 'https://en.wikipedia.org/wiki/Raleigh-Du', '', 14),
	(3847, 'KRIC', 'large_airport', 'Richmond International Airport', 37.50519943237305, -77.3197021484375, 167, 'NA', 'US', 'US-VA', 'Richmond', 'yes', 'KRIC', 'RIC', 'RIC', '', 'https://en.wikipedia.org/wiki/Richmond_I', '', 14),
	(3853, 'KRNO', 'large_airport', 'Reno Tahoe International Airport', 39.49909973144531, -119.76799774169922, 4415, 'NA', 'US', 'US-NV', 'Reno', 'yes', 'KRNO', 'RNO', 'RNO', '', 'https://en.wikipedia.org/wiki/Reno-Tahoe', '', 1),
	(3858, 'KRSW', 'large_airport', 'Southwest Florida International Airport', 26.53619956970215, -81.75520324707031, 30, 'NA', 'US', 'US-FL', 'Fort Myers', 'yes', 'KRSW', 'RSW', 'RSW', 'http://www.flylcpa.com/', 'https://en.wikipedia.org/wiki/Southwest_', '', 20),
	(3862, 'KSAN', 'large_airport', 'San Diego International Airport', 32.7336006165, -117.190002441, 17, 'NA', 'US', 'US-CA', 'San Diego', 'yes', 'KSAN', 'SAN', 'SAN', 'http://www.san.org/', 'https://en.wikipedia.org/wiki/San_Diego_', 'Lindbergh Field', 1),
	(3863, 'KSAT', 'large_airport', 'San Antonio International Airport', 29.533701, -98.469803, 809, 'NA', 'US', 'US-TX', 'San Antonio', 'yes', 'KSAT', 'SAT', 'SAT', 'https://www.sanantonio.gov/aviation', 'https://en.wikipedia.org/wiki/San_Antoni', '', 20),
	(3864, 'KSAV', 'large_airport', 'Savannah Hilton Head International Airpo', 32.12760162, -81.20210266, 50, 'NA', 'US', 'US-GA', 'Savannah', 'yes', 'KSAV', 'SAV', 'SAV', '', 'https://en.wikipedia.org/wiki/Savannah/H', '', 19),
	(3873, 'KSDF', 'large_airport', 'Louisville Muhammad Ali International Ai', 38.1744, -85.736, 501, 'NA', 'US', 'US-KY', 'Louisville', 'yes', 'KSDF', 'SDF', 'SDF', 'http://www.flylouisville.com', 'https://en.wikipedia.org/wiki/Louisville', 'Louisville International, Standiford Fie', 34),
	(3875, 'KSEA', 'large_airport', 'Seattle Tacoma International Airport', 47.449001, -122.308998, 433, 'NA', 'US', 'US-WA', 'Seattle', 'yes', 'KSEA', 'SEA', 'SEA', 'http://www.portseattle.org/seatac/', 'https://en.wikipedia.org/wiki/Seattleâ€“', '', 34),
	(3876, 'KSFB', 'large_airport', 'Orlando Sanford International Airport', 28.777599334716797, -81.23750305175781, 55, 'NA', 'US', 'US-FL', 'Orlando', 'yes', 'KSFB', 'SFB', 'SFB', '', 'https://en.wikipedia.org/wiki/Orlando_Sa', '', 3),
	(3878, 'KSFO', 'large_airport', 'San Francisco International Airport', 37.61899948120117, -122.375, 13, 'NA', 'US', 'US-CA', 'San Francisco', 'yes', 'KSFO', 'SFO', 'SFO', 'http://www.flysfo.com/', 'https://en.wikipedia.org/wiki/San_Franci', 'QSF, QBA', 27),
	(3883, 'KSJC', 'large_airport', 'Norman Y. Mineta San Jose International ', 37.362598, -121.929001, 62, 'NA', 'US', 'US-CA', 'San Jose', 'yes', 'KSJC', 'SJC', 'SJC', 'http://www.flysanjose.com/', 'https://en.wikipedia.org/wiki/San_Jose_I', 'QSF, QBA', 7),
	(3887, 'KSLC', 'large_airport', 'Salt Lake City International Airport', 40.785749, -111.979746, 4227, 'NA', 'US', 'US-UT', 'Salt Lake City', 'yes', 'KSLC', 'SLC', 'SLC', '', 'https://en.wikipedia.org/wiki/Salt_Lake_', '', 27),
	(3892, 'KSMF', 'large_airport', 'Sacramento International Airport', 38.69540023803711, -121.59100341796875, 27, 'NA', 'US', 'US-CA', 'Sacramento', 'yes', 'KSMF', 'SMF', 'SMF', '', 'https://en.wikipedia.org/wiki/Sacramento', '', 1),
	(3905, 'KSTL', 'large_airport', 'St Louis Lambert International Airport', 38.748697, -90.370003, 618, 'NA', 'US', 'US-MO', 'St Louis', 'yes', 'KSTL', 'STL', 'STL', 'https://www.flystl.com/', 'https://en.wikipedia.org/wiki/St._Louis_', 'Lambert St Louis', 20),
	(3913, 'KSYR', 'large_airport', 'Syracuse Hancock International Airport', 43.11119842529297, -76.1063003540039, 421, 'NA', 'US', 'US-NY', 'Syracuse', 'yes', 'KSYR', 'SYR', 'SYR', 'http://www.syrairport.org/', 'https://en.wikipedia.org/wiki/Syracuse_H', '', 16),
	(3926, 'KTPA', 'large_airport', 'Tampa International Airport', 27.975500106811523, -82.533203125, 26, 'NA', 'US', 'US-FL', 'Tampa', 'yes', 'KTPA', 'TPA', 'TPA', '', 'https://en.wikipedia.org/wiki/Tampa_Inte', '', 25),
	(3930, 'KTUL', 'large_airport', 'Tulsa International Airport', 36.19839859008789, -95.88809967041016, 677, 'NA', 'US', 'US-OK', 'Tulsa', 'yes', 'KTUL', 'TUL', 'TUL', '', 'https://en.wikipedia.org/wiki/Tulsa_Inte', '', 6),
	(342308, 'LHS', 'large_airport', 'Lake Havasu City International Airport', 34.43826, -114.222531, 400, 'NA', 'US', 'US-AZ', 'Lake Havasu City', 'yes', 'LHSI', 'LHS', 'AZ99', '', '', '', 4),
	(5360, 'PAFA', 'large_airport', 'Fairbanks International Airport', 64.81510162, -147.8560028, 439, 'NA', 'US', 'US-AK', 'Fairbanks', 'yes', 'PAFA', 'FAI', 'FAI', '', 'https://en.wikipedia.org/wiki/Fairbanks_', '', 8),
	(5388, 'PANC', 'large_airport', 'Ted Stevens Anchorage International Airp', 61.1744, -149.996002, 152, 'NA', 'US', 'US-AK', 'Anchorage', 'yes', 'PANC', 'ANC', 'ANC', '', 'https://en.wikipedia.org/wiki/Ted_Steven', '', 28),
	(5453, 'PHNL', 'large_airport', 'Daniel K Inouye International Airport', 21.32062, -157.924228, 13, 'NA', 'US', 'US-HI', 'Honolulu', 'yes', 'PHNL', 'HNL', 'HNL', 'http://airports.hawaii.gov/hnl/', 'https://en.wikipedia.org/wiki/Daniel_K._', 'Hickam Air Force Base, HIK, PHIK, KHNL, ', 20);

-- Dumping structure for taulu flight_game.game
DROP TABLE IF EXISTS `game`;
CREATE TABLE IF NOT EXISTS `game` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `frustration` int(8) unsigned zerofill NOT NULL,
  `location` varchar(10) DEFAULT NULL,
  `screen_name` varchar(40) DEFAULT NULL,
  `weather_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location` (`location`),
  CONSTRAINT `game_ibfk_1` FOREIGN KEY (`location`) REFERENCES `airport` (`ident`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table flight_game.game: ~4 rows (suunnilleen)
DELETE FROM `game`;
INSERT INTO `game` (`id`, `frustration`, `location`, `screen_name`, `weather_id`) VALUES
	(4, 00000000, 'KONT', 'testi', 1),
	(10, 00000020, 'KONT', 'testiname', 33),
	(11, 00000000, 'KABE', 'testi1', 2),
	(12, 00000000, 'KSMF', 'Uusiman', 4);

-- Dumping structure for taulu flight_game.weather
DROP TABLE IF EXISTS `weather`;
CREATE TABLE IF NOT EXISTS `weather` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` text NOT NULL,
  `temperature` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table flight_game.weather: ~22 rows (suunnilleen)
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
