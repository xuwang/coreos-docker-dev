-- MySQL dump 10.13  Distrib 5.7.11, for Linux (x86_64)
--
-- Host: localhost    Database: saml
-- ------------------------------------------------------
-- Server version	5.7.11

--
-- Table structure for table `SimpleSAMLphp_kvstore`
--

USE `saml`;

--
-- Table structure for table `adfs_idp_hosted`
--

DROP TABLE IF EXISTS `adfs_idp_hosted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adfs_idp_hosted` (
  `entity_id` varchar(255) NOT NULL,
  `entity_data` text NOT NULL,
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adfs_sp_remote`
--

DROP TABLE IF EXISTS `adfs_sp_remote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adfs_sp_remote` (
  `entity_id` varchar(255) NOT NULL,
  `entity_data` text NOT NULL,
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `saml20_idp_hosted`
--

DROP TABLE IF EXISTS `saml20_idp_hosted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saml20_idp_hosted` (
  `entity_id` varchar(255) NOT NULL,
  `entity_data` text NOT NULL,
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `saml20_idp_remote`
--

DROP TABLE IF EXISTS `saml20_idp_remote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saml20_idp_remote` (
  `entity_id` varchar(255) NOT NULL,
  `entity_data` text NOT NULL,
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `saml20_sp_remote`
--

DROP TABLE IF EXISTS `saml20_sp_remote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saml20_sp_remote` (
  `entity_id` varchar(255) NOT NULL,
  `entity_data` text NOT NULL,
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shib13_idp_hosted`
--

DROP TABLE IF EXISTS `shib13_idp_hosted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shib13_idp_hosted` (
  `entity_id` varchar(255) NOT NULL,
  `entity_data` text NOT NULL,
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shib13_idp_remote`
--

DROP TABLE IF EXISTS `shib13_idp_remote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shib13_idp_remote` (
  `entity_id` varchar(255) NOT NULL,
  `entity_data` text NOT NULL,
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shib13_sp_hosted`
--

DROP TABLE IF EXISTS `shib13_sp_hosted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shib13_sp_hosted` (
  `entity_id` varchar(255) NOT NULL,
  `entity_data` text NOT NULL,
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shib13_sp_remote`
--

DROP TABLE IF EXISTS `shib13_sp_remote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shib13_sp_remote` (
  `entity_id` varchar(255) NOT NULL,
  `entity_data` text NOT NULL,
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wsfed_idp_remote`
--

DROP TABLE IF EXISTS `wsfed_idp_remote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wsfed_idp_remote` (
  `entity_id` varchar(255) NOT NULL,
  `entity_data` text NOT NULL,
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wsfed_sp_hosted`
--

DROP TABLE IF EXISTS `wsfed_sp_hosted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wsfed_sp_hosted` (
  `entity_id` varchar(255) NOT NULL,
  `entity_data` text NOT NULL,
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
