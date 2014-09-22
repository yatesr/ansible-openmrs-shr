-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.59-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema `openmrs-shr`
--

-- CREATE DATABASE IF NOT EXISTS `openmrs-shr`;
-- USE `openmrs-shr`;

--
-- Definition of table `active_list`
--

DROP TABLE IF EXISTS `active_list`;
CREATE TABLE `active_list` (
  `active_list_id` int(11) NOT NULL AUTO_INCREMENT,
  `active_list_type_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `concept_id` int(11) NOT NULL,
  `start_obs_id` int(11) DEFAULT NULL,
  `stop_obs_id` int(11) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`active_list_id`),
  KEY `user_who_voided_active_list` (`voided_by`),
  KEY `user_who_created_active_list` (`creator`),
  KEY `active_list_type_of_active_list` (`active_list_type_id`),
  KEY `person_of_active_list` (`person_id`),
  KEY `concept_active_list` (`concept_id`),
  KEY `start_obs_active_list` (`start_obs_id`),
  KEY `stop_obs_active_list` (`stop_obs_id`),
  CONSTRAINT `active_list_type_of_active_list` FOREIGN KEY (`active_list_type_id`) REFERENCES `active_list_type` (`active_list_type_id`),
  CONSTRAINT `concept_active_list` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `person_of_active_list` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `start_obs_active_list` FOREIGN KEY (`start_obs_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `stop_obs_active_list` FOREIGN KEY (`stop_obs_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `user_who_created_active_list` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_active_list` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `active_list`
--

/*!40000 ALTER TABLE `active_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `active_list` ENABLE KEYS */;


--
-- Definition of table `active_list_allergy`
--

DROP TABLE IF EXISTS `active_list_allergy`;
CREATE TABLE `active_list_allergy` (
  `active_list_id` int(11) NOT NULL AUTO_INCREMENT,
  `allergy_type` varchar(50) DEFAULT NULL,
  `reaction_concept_id` int(11) DEFAULT NULL,
  `severity` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`active_list_id`),
  KEY `reaction_allergy` (`reaction_concept_id`),
  CONSTRAINT `reaction_allergy` FOREIGN KEY (`reaction_concept_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `active_list_allergy`
--

/*!40000 ALTER TABLE `active_list_allergy` DISABLE KEYS */;
/*!40000 ALTER TABLE `active_list_allergy` ENABLE KEYS */;


--
-- Definition of table `active_list_problem`
--

DROP TABLE IF EXISTS `active_list_problem`;
CREATE TABLE `active_list_problem` (
  `active_list_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) DEFAULT NULL,
  `sort_weight` double DEFAULT NULL,
  PRIMARY KEY (`active_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `active_list_problem`
--

/*!40000 ALTER TABLE `active_list_problem` DISABLE KEYS */;
/*!40000 ALTER TABLE `active_list_problem` ENABLE KEYS */;


--
-- Definition of table `active_list_type`
--

DROP TABLE IF EXISTS `active_list_type`;
CREATE TABLE `active_list_type` (
  `active_list_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`active_list_type_id`),
  KEY `user_who_retired_active_list_type` (`retired_by`),
  KEY `user_who_created_active_list_type` (`creator`),
  CONSTRAINT `user_who_created_active_list_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_active_list_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `active_list_type`
--

/*!40000 ALTER TABLE `active_list_type` DISABLE KEYS */;
INSERT INTO `active_list_type` (`active_list_type_id`,`name`,`description`,`creator`,`date_created`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (1,'Allergy','An Allergy the Patient may have',1,'2010-05-28 00:00:00',0,NULL,NULL,NULL,'96f4f603-6a99-11df-a648-37a07f9c90fb'),
 (2,'Problem','A Problem the Patient may have',1,'2010-05-28 00:00:00',0,NULL,NULL,NULL,'a0c7422b-6a99-11df-a648-37a07f9c90fb');
/*!40000 ALTER TABLE `active_list_type` ENABLE KEYS */;


--
-- Definition of table `address_hierarchy`
--

DROP TABLE IF EXISTS `address_hierarchy`;
CREATE TABLE `address_hierarchy` (
  `address_hierarchy_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(160) NOT NULL,
  `type_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `user_generated_id` varchar(11) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `elevation` double DEFAULT NULL,
  PRIMARY KEY (`address_hierarchy_id`),
  KEY `parent_location_id` (`parent_id`),
  KEY `location_type_id` (`type_id`),
  KEY `name_ah` (`name`),
  CONSTRAINT `location_type_id` FOREIGN KEY (`type_id`) REFERENCES `address_hierarchy_type` (`location_attribute_type_id`),
  CONSTRAINT `parent_location_id` FOREIGN KEY (`parent_id`) REFERENCES `address_hierarchy` (`address_hierarchy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address_hierarchy`
--

/*!40000 ALTER TABLE `address_hierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `address_hierarchy` ENABLE KEYS */;


--
-- Definition of table `address_hierarchy_type`
--

DROP TABLE IF EXISTS `address_hierarchy_type`;
CREATE TABLE `address_hierarchy_type` (
  `location_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(160) NOT NULL,
  `parent_type_id` int(11) DEFAULT NULL,
  `child_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`location_attribute_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address_hierarchy_type`
--

/*!40000 ALTER TABLE `address_hierarchy_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `address_hierarchy_type` ENABLE KEYS */;


--
-- Definition of table `archivequeue`
--

DROP TABLE IF EXISTS `archivequeue`;
CREATE TABLE `archivequeue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time_response_received` datetime DEFAULT NULL,
  `related_encounter` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `archivequeue`
--

/*!40000 ALTER TABLE `archivequeue` DISABLE KEYS */;
/*!40000 ALTER TABLE `archivequeue` ENABLE KEYS */;


--
-- Definition of table `clob_datatype_storage`
--

DROP TABLE IF EXISTS `clob_datatype_storage`;
CREATE TABLE `clob_datatype_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `clob_datatype_storage_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `clob_datatype_storage`
--

/*!40000 ALTER TABLE `clob_datatype_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `clob_datatype_storage` ENABLE KEYS */;


--
-- Definition of table `cohort`
--

DROP TABLE IF EXISTS `cohort`;
CREATE TABLE `cohort` (
  `cohort_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`cohort_id`),
  UNIQUE KEY `cohort_uuid_index` (`uuid`),
  KEY `user_who_changed_cohort` (`changed_by`),
  KEY `cohort_creator` (`creator`),
  KEY `user_who_voided_cohort` (`voided_by`),
  CONSTRAINT `cohort_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_cohort` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_cohort` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cohort`
--

/*!40000 ALTER TABLE `cohort` DISABLE KEYS */;
/*!40000 ALTER TABLE `cohort` ENABLE KEYS */;


--
-- Definition of table `cohort_member`
--

DROP TABLE IF EXISTS `cohort_member`;
CREATE TABLE `cohort_member` (
  `cohort_id` int(11) NOT NULL DEFAULT '0',
  `patient_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cohort_id`,`patient_id`),
  KEY `member_patient` (`patient_id`),
  CONSTRAINT `member_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `parent_cohort` FOREIGN KEY (`cohort_id`) REFERENCES `cohort` (`cohort_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cohort_member`
--

/*!40000 ALTER TABLE `cohort_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `cohort_member` ENABLE KEYS */;


--
-- Definition of table `concept`
--

DROP TABLE IF EXISTS `concept`;
CREATE TABLE `concept` (
  `concept_id` int(11) NOT NULL AUTO_INCREMENT,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `short_name` varchar(255) DEFAULT NULL,
  `description` text,
  `form_text` text,
  `datatype_id` int(11) NOT NULL DEFAULT '0',
  `class_id` int(11) NOT NULL DEFAULT '0',
  `is_set` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `version` varchar(50) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  UNIQUE KEY `concept_uuid_index` (`uuid`),
  KEY `user_who_changed_concept` (`changed_by`),
  KEY `concept_classes` (`class_id`),
  KEY `concept_creator` (`creator`),
  KEY `concept_datatypes` (`datatype_id`),
  KEY `user_who_retired_concept` (`retired_by`),
  CONSTRAINT `concept_classes` FOREIGN KEY (`class_id`) REFERENCES `concept_class` (`concept_class_id`),
  CONSTRAINT `concept_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_datatypes` FOREIGN KEY (`datatype_id`) REFERENCES `concept_datatype` (`concept_datatype_id`),
  CONSTRAINT `user_who_changed_concept` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept`
--

/*!40000 ALTER TABLE `concept` DISABLE KEYS */;
INSERT INTO `concept` (`concept_id`,`retired`,`short_name`,`description`,`form_text`,`datatype_id`,`class_id`,`is_set`,`creator`,`date_created`,`version`,`changed_by`,`date_changed`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (1,0,'','',NULL,4,11,0,1,'2013-11-04 16:31:32',NULL,NULL,NULL,NULL,NULL,NULL,'123379e7-4a0f-438a-b7c0-74583de4b301'),
 (2,0,'','',NULL,4,11,0,1,'2013-11-04 16:31:32',NULL,NULL,NULL,NULL,NULL,NULL,'64b4791c-de3e-40ed-afb3-396b527d5a27'),
 (5,0,NULL,NULL,NULL,6,11,0,1,'2013-11-12 13:36:27',NULL,1,'2013-11-12 13:40:15',NULL,NULL,NULL,'07e08bf8-bc23-4226-804c-335a271c0faf'),
 (6,0,NULL,NULL,NULL,3,7,0,1,'2013-11-12 13:42:00',NULL,1,'2013-11-12 13:42:00',NULL,NULL,NULL,'09c980ee-5f43-4e31-8be4-95424c24b41c'),
 (7,0,NULL,NULL,NULL,3,7,0,1,'2013-11-12 13:43:54',NULL,1,'2013-11-12 13:45:35',NULL,NULL,NULL,'427680ce-ced6-48af-8534-86a05ffdaead'),
 (8,0,NULL,NULL,NULL,2,7,0,1,'2013-11-12 13:47:24',NULL,1,'2013-11-12 13:52:41',NULL,NULL,NULL,'feeb2a00-fa32-4924-a324-db0c32d5f44b'),
 (9,0,NULL,NULL,NULL,4,11,0,1,'2013-11-12 13:50:11',NULL,1,'2013-11-12 13:50:11',NULL,NULL,NULL,'21257bbc-b361-461b-84c7-ea36b3ea4935'),
 (10,0,NULL,NULL,NULL,4,11,0,1,'2013-11-12 13:50:54',NULL,1,'2013-11-12 13:50:54',NULL,NULL,NULL,'5230c0f7-0c49-4a32-832d-ee9d47f737c1'),
 (11,0,NULL,NULL,NULL,4,11,0,1,'2013-11-12 13:51:39',NULL,1,'2013-11-12 13:51:39',NULL,NULL,NULL,'a14cb37a-1d38-4d05-8068-19c2d39225da');
/*!40000 ALTER TABLE `concept` ENABLE KEYS */;


--
-- Definition of table `concept_answer`
--

DROP TABLE IF EXISTS `concept_answer`;
CREATE TABLE `concept_answer` (
  `concept_answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `answer_concept` int(11) DEFAULT NULL,
  `answer_drug` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `sort_weight` double DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_answer_id`),
  UNIQUE KEY `concept_answer_uuid_index` (`uuid`),
  KEY `answer` (`answer_concept`),
  KEY `answers_for_concept` (`concept_id`),
  KEY `answer_creator` (`creator`),
  KEY `answer_answer_drug_fk` (`answer_drug`),
  CONSTRAINT `answer` FOREIGN KEY (`answer_concept`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `answers_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `answer_answer_drug_fk` FOREIGN KEY (`answer_drug`) REFERENCES `drug` (`drug_id`),
  CONSTRAINT `answer_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_answer`
--

/*!40000 ALTER TABLE `concept_answer` DISABLE KEYS */;
INSERT INTO `concept_answer` (`concept_answer_id`,`concept_id`,`answer_concept`,`answer_drug`,`creator`,`date_created`,`sort_weight`,`uuid`) VALUES 
 (1,8,9,NULL,1,'2013-11-12 13:52:41',1,'4a3c7d0c-240e-432d-af0a-01c0b74fa640'),
 (2,8,10,NULL,1,'2013-11-12 13:52:41',2,'038ea53e-d934-4cf6-a18c-0239ab283100'),
 (3,8,11,NULL,1,'2013-11-12 13:52:41',3,'e1c3fa61-d0cc-411c-8a38-6258af9fc43f');
/*!40000 ALTER TABLE `concept_answer` ENABLE KEYS */;


--
-- Definition of table `concept_class`
--

DROP TABLE IF EXISTS `concept_class`;
CREATE TABLE `concept_class` (
  `concept_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_class_id`),
  UNIQUE KEY `concept_class_uuid_index` (`uuid`),
  KEY `concept_class_retired_status` (`retired`),
  KEY `concept_class_creator` (`creator`),
  KEY `user_who_retired_concept_class` (`retired_by`),
  CONSTRAINT `concept_class_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept_class` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_class`
--

/*!40000 ALTER TABLE `concept_class` DISABLE KEYS */;
INSERT INTO `concept_class` (`concept_class_id`,`name`,`description`,`creator`,`date_created`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (1,'Test','Acq. during patient encounter (vitals, labs, etc.)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4907b2-c2cc-11de-8d13-0010c6dffd0f'),
 (2,'Procedure','Describes a clinical procedure',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d490bf4-c2cc-11de-8d13-0010c6dffd0f'),
 (3,'Drug','Drug',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d490dfc-c2cc-11de-8d13-0010c6dffd0f'),
 (4,'Diagnosis','Conclusion drawn through findings',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4918b0-c2cc-11de-8d13-0010c6dffd0f'),
 (5,'Finding','Practitioner observation/finding',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d491a9a-c2cc-11de-8d13-0010c6dffd0f'),
 (6,'Anatomy','Anatomic sites / descriptors',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d491c7a-c2cc-11de-8d13-0010c6dffd0f'),
 (7,'Question','Question (eg, patient history, SF36 items)',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d491e50-c2cc-11de-8d13-0010c6dffd0f'),
 (8,'LabSet','Term to describe laboratory sets',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d492026-c2cc-11de-8d13-0010c6dffd0f'),
 (9,'MedSet','Term to describe medication sets',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4923b4-c2cc-11de-8d13-0010c6dffd0f'),
 (10,'ConvSet','Term to describe convenience sets',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d492594-c2cc-11de-8d13-0010c6dffd0f'),
 (11,'Misc','Terms which don\'t fit other categories',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d492774-c2cc-11de-8d13-0010c6dffd0f'),
 (12,'Symptom','Patient-reported observation',1,'2004-10-04 00:00:00',0,NULL,NULL,NULL,'8d492954-c2cc-11de-8d13-0010c6dffd0f'),
 (13,'Symptom/Finding','Observation that can be reported from patient or found on exam',1,'2004-10-04 00:00:00',0,NULL,NULL,NULL,'8d492b2a-c2cc-11de-8d13-0010c6dffd0f'),
 (14,'Specimen','Body or fluid specimen',1,'2004-12-02 00:00:00',0,NULL,NULL,NULL,'8d492d0a-c2cc-11de-8d13-0010c6dffd0f'),
 (15,'Misc Order','Orderable items which aren\'t tests or drugs',1,'2005-02-17 00:00:00',0,NULL,NULL,NULL,'8d492ee0-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `concept_class` ENABLE KEYS */;


--
-- Definition of table `concept_complex`
--

DROP TABLE IF EXISTS `concept_complex`;
CREATE TABLE `concept_complex` (
  `concept_id` int(11) NOT NULL,
  `handler` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `concept_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_complex`
--

/*!40000 ALTER TABLE `concept_complex` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_complex` ENABLE KEYS */;


--
-- Definition of table `concept_datatype`
--

DROP TABLE IF EXISTS `concept_datatype`;
CREATE TABLE `concept_datatype` (
  `concept_datatype_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `hl7_abbreviation` varchar(3) DEFAULT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_datatype_id`),
  UNIQUE KEY `concept_datatype_uuid_index` (`uuid`),
  KEY `concept_datatype_retired_status` (`retired`),
  KEY `concept_datatype_creator` (`creator`),
  KEY `user_who_retired_concept_datatype` (`retired_by`),
  CONSTRAINT `concept_datatype_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept_datatype` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_datatype`
--

/*!40000 ALTER TABLE `concept_datatype` DISABLE KEYS */;
INSERT INTO `concept_datatype` (`concept_datatype_id`,`name`,`hl7_abbreviation`,`description`,`creator`,`date_created`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (1,'Numeric','NM','Numeric value, including integer or float (e.g., creatinine, weight)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4488-c2cc-11de-8d13-0010c6dffd0f'),
 (2,'Coded','CWE','Value determined by term dictionary lookup (i.e., term identifier)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a48b6-c2cc-11de-8d13-0010c6dffd0f'),
 (3,'Text','ST','Free text',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4ab4-c2cc-11de-8d13-0010c6dffd0f'),
 (4,'N/A','ZZ','Not associated with a datatype (e.g., term answers, sets)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4c94-c2cc-11de-8d13-0010c6dffd0f'),
 (5,'Document','RP','Pointer to a binary or text-based document (e.g., clinical document, RTF, XML, EKG, image, etc.) stored in complex_obs table',1,'2004-04-15 00:00:00',0,NULL,NULL,NULL,'8d4a4e74-c2cc-11de-8d13-0010c6dffd0f'),
 (6,'Date','DT','Absolute date',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a505e-c2cc-11de-8d13-0010c6dffd0f'),
 (7,'Time','TM','Absolute time of day',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a591e-c2cc-11de-8d13-0010c6dffd0f'),
 (8,'Datetime','TS','Absolute date and time',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a5af4-c2cc-11de-8d13-0010c6dffd0f'),
 (10,'Boolean','BIT','Boolean value (yes/no, true/false)',1,'2004-08-26 00:00:00',0,NULL,NULL,NULL,'8d4a5cca-c2cc-11de-8d13-0010c6dffd0f'),
 (11,'Rule','ZZ','Value derived from other data',1,'2006-09-11 00:00:00',0,NULL,NULL,NULL,'8d4a5e96-c2cc-11de-8d13-0010c6dffd0f'),
 (12,'Structured Numeric','SN','Complex numeric values possible (ie, <5, 1-10, etc.)',1,'2005-08-06 00:00:00',0,NULL,NULL,NULL,'8d4a606c-c2cc-11de-8d13-0010c6dffd0f'),
 (13,'Complex','ED','Complex value.  Analogous to HL7 Embedded Datatype',1,'2008-05-28 12:25:34',0,NULL,NULL,NULL,'8d4a6242-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `concept_datatype` ENABLE KEYS */;


--
-- Definition of table `concept_description`
--

DROP TABLE IF EXISTS `concept_description`;
CREATE TABLE `concept_description` (
  `concept_description_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `locale` varchar(50) NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_description_id`),
  UNIQUE KEY `concept_description_uuid_index` (`uuid`),
  KEY `user_who_changed_description` (`changed_by`),
  KEY `description_for_concept` (`concept_id`),
  KEY `user_who_created_description` (`creator`),
  CONSTRAINT `description_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_changed_description` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_description` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_description`
--

/*!40000 ALTER TABLE `concept_description` DISABLE KEYS */;
INSERT INTO `concept_description` (`concept_description_id`,`concept_id`,`description`,`locale`,`creator`,`date_created`,`changed_by`,`date_changed`,`uuid`) VALUES 
 (1,5,'DATE OF REFERRAL REQUEST','en',1,'2013-11-12 13:36:27',NULL,NULL,'1e75ce98-227a-4fcd-a751-417862442dfd'),
 (2,6,'Refer patient to','en',1,'2013-11-12 13:42:00',NULL,NULL,'60414b5c-69b0-4778-ab0b-e7cbec7685d5'),
 (3,7,'Free-text reason that a patient was referred to another health establishment','en',1,'2013-11-12 13:43:54',NULL,NULL,'26fd5c10-6fae-417c-9b9f-2706cb84602b'),
 (4,8,'Referral Urgency','en',1,'2013-11-12 13:47:24',NULL,NULL,'cbaeb79a-0865-4c76-b5ec-d71a72c9abec'),
 (5,9,'Urgent','en',1,'2013-11-12 13:50:11',NULL,NULL,'4706854f-6610-4bc9-8d07-f86072876f04'),
 (6,10,'Routine','en',1,'2013-11-12 13:50:54',NULL,NULL,'0155b8a9-7c21-4501-a453-67a57e88009a'),
 (7,11,'Immediate Referral','en',1,'2013-11-12 13:51:39',NULL,NULL,'b43a9dab-d7ac-40df-b5c1-01b7eb5eae2b');
/*!40000 ALTER TABLE `concept_description` ENABLE KEYS */;


--
-- Definition of table `concept_map_type`
--

DROP TABLE IF EXISTS `concept_map_type`;
CREATE TABLE `concept_map_type` (
  `concept_map_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_map_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `mapped_user_creator_concept_map_type` (`creator`),
  KEY `mapped_user_changed_concept_map_type` (`changed_by`),
  KEY `mapped_user_retired_concept_map_type` (`retired_by`),
  CONSTRAINT `mapped_user_changed_concept_map_type` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_creator_concept_map_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_retired_concept_map_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_map_type`
--

/*!40000 ALTER TABLE `concept_map_type` DISABLE KEYS */;
INSERT INTO `concept_map_type` (`concept_map_type_id`,`name`,`description`,`creator`,`date_created`,`changed_by`,`date_changed`,`is_hidden`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (1,'SAME-AS',NULL,1,'2013-11-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'35543629-7d8c-11e1-909d-c80aa9edcf4e'),
 (2,'NARROWER-THAN',NULL,1,'2013-11-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'43ac5109-7d8c-11e1-909d-c80aa9edcf4e'),
 (3,'BROADER-THAN',NULL,1,'2013-11-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'4b9d9421-7d8c-11e1-909d-c80aa9edcf4e'),
 (4,'Associated finding',NULL,1,'2013-11-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'55e02065-7d8c-11e1-909d-c80aa9edcf4e'),
 (5,'Associated morphology',NULL,1,'2013-11-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'605f4a61-7d8c-11e1-909d-c80aa9edcf4e'),
 (6,'Associated procedure',NULL,1,'2013-11-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'6eb1bfce-7d8c-11e1-909d-c80aa9edcf4e'),
 (7,'Associated with',NULL,1,'2013-11-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'781bdc8f-7d8c-11e1-909d-c80aa9edcf4e'),
 (8,'Causative agent',NULL,1,'2013-11-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'808f9e19-7d8c-11e1-909d-c80aa9edcf4e'),
 (9,'Finding site',NULL,1,'2013-11-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'889c3013-7d8c-11e1-909d-c80aa9edcf4e'),
 (10,'Has specimen',NULL,1,'2013-11-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'929600b9-7d8c-11e1-909d-c80aa9edcf4e'),
 (11,'Laterality',NULL,1,'2013-11-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'999c6fc0-7d8c-11e1-909d-c80aa9edcf4e'),
 (12,'Severity',NULL,1,'2013-11-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'a0e52281-7d8c-11e1-909d-c80aa9edcf4e'),
 (13,'Access',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'f9e90b29-7d8c-11e1-909d-c80aa9edcf4e'),
 (14,'After',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'01b60e29-7d8d-11e1-909d-c80aa9edcf4e'),
 (15,'Clinical course',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'5f7c3702-7d8d-11e1-909d-c80aa9edcf4e'),
 (16,'Component',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'67debecc-7d8d-11e1-909d-c80aa9edcf4e'),
 (17,'Direct device',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'718c00da-7d8d-11e1-909d-c80aa9edcf4e'),
 (18,'Direct morphology',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'7b9509cb-7d8d-11e1-909d-c80aa9edcf4e'),
 (19,'Direct substance',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'82bb495d-7d8d-11e1-909d-c80aa9edcf4e'),
 (20,'Due to',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'8b77f7d3-7d8d-11e1-909d-c80aa9edcf4e'),
 (21,'Episodicity',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'94a81179-7d8d-11e1-909d-c80aa9edcf4e'),
 (22,'Finding context',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'9d23c22e-7d8d-11e1-909d-c80aa9edcf4e'),
 (23,'Finding informer',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'a4524368-7d8d-11e1-909d-c80aa9edcf4e'),
 (24,'Finding method',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'af089254-7d8d-11e1-909d-c80aa9edcf4e'),
 (25,'Has active ingredient',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'b65aa605-7d8d-11e1-909d-c80aa9edcf4e'),
 (26,'Has definitional manifestation',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'c2b7b2fa-7d8d-11e1-909d-c80aa9edcf4'),
 (27,'Has dose form',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'cc3878e6-7d8d-11e1-909d-c80aa9edcf4e'),
 (28,'Has focus',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'d67c5840-7d8d-11e1-909d-c80aa9edcf4e'),
 (29,'Has intent',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'de2fb2c5-7d8d-11e1-909d-c80aa9edcf4e'),
 (30,'Has interpretation',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'e758838b-7d8d-11e1-909d-c80aa9edcf4e'),
 (31,'Indirect device',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'ee63c142-7d8d-11e1-909d-c80aa9edcf4e'),
 (32,'Indirect morphology',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'f4f36681-7d8d-11e1-909d-c80aa9edcf4e'),
 (33,'Interprets',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'fc7f5fed-7d8d-11e1-909d-c80aa9edcf4e'),
 (34,'Measurement method',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'06b11d79-7d8e-11e1-909d-c80aa9edcf4e'),
 (35,'Method',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'0efb4753-7d8e-11e1-909d-c80aa9edcf4e'),
 (36,'Occurrence',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'16e7b617-7d8e-11e1-909d-c80aa9edcf4e'),
 (37,'Part of',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'1e82007b-7d8e-11e1-909d-c80aa9edcf4e'),
 (38,'Pathological process',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'2969915e-7d8e-11e1-909d-c80aa9edcf4e'),
 (39,'Priority',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'32d57796-7d8e-11e1-909d-c80aa9edcf4e'),
 (40,'Procedure context',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'3f11904c-7d8e-11e1-909d-c80aa9edcf4e'),
 (41,'Procedure device',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'468c4aa3-7d8e-11e1-909d-c80aa9edcf4e'),
 (42,'Procedure morphology',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'5383e889-7d8e-11e1-909d-c80aa9edcf4e'),
 (43,'Procedure site',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'5ad2655d-7d8e-11e1-909d-c80aa9edcf4e'),
 (44,'Procedure site - Direct',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'66085196-7d8e-11e1-909d-c80aa9edcf4e'),
 (45,'Procedure site - Indirect',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'7080e843-7d8e-11e1-909d-c80aa9edcf4e'),
 (46,'Property',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'76bfb796-7d8e-11e1-909d-c80aa9edcf4e'),
 (47,'Recipient category',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'7e7d00e4-7d8e-11e1-909d-c80aa9edcf4e'),
 (48,'Revision status',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'851e14c1-7d8e-11e1-909d-c80aa9edcf4e'),
 (49,'Route of administration',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'8ee5b13d-7d8e-11e1-909d-c80aa9edcf4e'),
 (50,'Scale type',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'986acf48-7d8e-11e1-909d-c80aa9edcf4e'),
 (51,'Specimen procedure',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'a6937642-7d8e-11e1-909d-c80aa9edcf4e'),
 (52,'Specimen source identity',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'b1d6941e-7d8e-11e1-909d-c80aa9edcf4e'),
 (53,'Specimen source morphology',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'b7c793c1-7d8e-11e1-909d-c80aa9edcf4e'),
 (54,'Specimen source topography',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'be9f9eb8-7d8e-11e1-909d-c80aa9edcf4e'),
 (55,'Specimen substance',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'c8f2bacb-7d8e-11e1-909d-c80aa9edcf4e'),
 (56,'Subject of information',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'d0664c4f-7d8e-11e1-909d-c80aa9edcf4e'),
 (57,'Subject relationship context',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'dace9d13-7d8e-11e1-909d-c80aa9edcf4e'),
 (58,'Surgical approach',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'e3cd666d-7d8e-11e1-909d-c80aa9edcf4e'),
 (59,'Temporal context',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'ed96447d-7d8e-11e1-909d-c80aa9edcf4e'),
 (60,'Time aspect',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'f415bcce-7d8e-11e1-909d-c80aa9edcf4e'),
 (61,'Using access device',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'fa9538a9-7d8e-11e1-909d-c80aa9edcf4e'),
 (62,'Using device',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'06588655-7d8f-11e1-909d-c80aa9edcf4e'),
 (63,'Using energy',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'0c2ae0bc-7d8f-11e1-909d-c80aa9edcf4e'),
 (64,'Using substance',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'13d2c607-7d8f-11e1-909d-c80aa9edcf4e'),
 (65,'IS A',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'1ce7a784-7d8f-11e1-909d-c80aa9edcf4e'),
 (66,'MAY BE A',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'267812a3-7d8f-11e1-909d-c80aa9edcf4e'),
 (67,'MOVED FROM',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'2de3168e-7d8f-11e1-909d-c80aa9edcf4e'),
 (68,'MOVED TO',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'32f0fd99-7d8f-11e1-909d-c80aa9edcf4e'),
 (69,'REPLACED BY',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'3b3b9a7d-7d8f-11e1-909d-c80aa9edcf4e'),
 (70,'WAS A',NULL,1,'2013-11-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'41a034da-7d8f-11e1-909d-c80aa9edcf4e');
/*!40000 ALTER TABLE `concept_map_type` ENABLE KEYS */;


--
-- Definition of table `concept_name`
--

DROP TABLE IF EXISTS `concept_name`;
CREATE TABLE `concept_name` (
  `concept_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `locale` varchar(50) NOT NULL DEFAULT '',
  `locale_preferred` tinyint(1) DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `concept_name_type` varchar(50) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_name_id`),
  UNIQUE KEY `concept_name_uuid_index` (`uuid`),
  KEY `name_of_concept` (`name`),
  KEY `name_for_concept` (`concept_id`),
  KEY `user_who_created_name` (`creator`),
  KEY `user_who_voided_this_name` (`voided_by`),
  CONSTRAINT `name_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_created_name` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_this_name` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_name`
--

/*!40000 ALTER TABLE `concept_name` DISABLE KEYS */;
INSERT INTO `concept_name` (`concept_name_id`,`concept_id`,`name`,`locale`,`locale_preferred`,`creator`,`date_created`,`concept_name_type`,`voided`,`voided_by`,`date_voided`,`void_reason`,`uuid`) VALUES 
 (1,1,'Vero','it',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'83e74e83-d320-43c1-8b23-e5963f243dbb'),
 (2,1,'Sì','it',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'3ccc4969-d565-4ac7-b4a2-6a6d7a557241'),
 (3,1,'Verdadeiro','pt',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'9ac98784-be24-469d-94e5-689990363958'),
 (4,1,'Sim','pt',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'2565f2c4-8550-4de6-ba11-6fb3429899ef'),
 (5,1,'Vrai','fr',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'1ee9292c-9525-4cd0-934f-c085caff42cc'),
 (6,1,'Oui','fr',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'cc3fb9df-6538-4a2c-8428-66c23a90b50c'),
 (7,1,'True','en',0,1,'2013-11-04 16:31:32','FULLY_SPECIFIED',0,NULL,NULL,NULL,'4c4c0cce-2f6f-4d95-9d17-8cd70edb1ec4'),
 (8,1,'Yes','en',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'12ea8f6c-a894-4601-a4d0-dd9a0d757e6d'),
 (9,1,'Verdadero','es',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'bef7471c-0cd3-4125-baa5-ba7122ca1e29'),
 (10,1,'Sí','es',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'0cf188f6-2275-4eb0-93a9-5097e97fd4ea'),
 (11,2,'Falso','it',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'92798a3e-0324-4c12-b322-0db6c8c1b08e'),
 (12,2,'No','it',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'2fdc339e-f00b-41c8-8a6f-0ba88dc9fb8c'),
 (13,2,'Falso','pt',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'2e6fb680-4bda-4a92-b42a-e57beac4a915'),
 (14,2,'Não','pt',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'be104e00-d046-40a4-ad34-74dc08849d69'),
 (15,2,'Faux','fr',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'81a40da9-9562-409f-8625-a4e86539470c'),
 (16,2,'Non','fr',0,1,'2013-11-04 16:31:32',NULL,0,NULL,NULL,NULL,'320e24d3-39a0-4f71-8af5-904841198f0c'),
 (17,2,'False','en',0,1,'2013-11-04 16:31:32','FULLY_SPECIFIED',0,NULL,NULL,NULL,'23ad1806-daea-4041-85db-b80bb851a6ad'),
 (18,2,'No','en',0,1,'2013-11-04 16:31:33',NULL,0,NULL,NULL,NULL,'60f26d66-a373-44c6-bcbd-01b299cc1b3c'),
 (19,2,'Falso','es',0,1,'2013-11-04 16:31:33',NULL,0,NULL,NULL,NULL,'138dc67f-c159-49c5-93ed-7cde6e83b19e'),
 (20,2,'No','es',0,1,'2013-11-04 16:31:33',NULL,0,NULL,NULL,NULL,'437b42d3-c20d-42f0-a32c-9a44c8a5837a'),
 (23,5,'DATE OF REFERRAL REQUEST','en',1,1,'2013-11-12 13:36:27','FULLY_SPECIFIED',0,NULL,NULL,NULL,'62d24d95-dfa8-4d80-bcb2-50ba51716fc2'),
 (24,6,'Refer patient to','en',1,1,'2013-11-12 13:42:00','FULLY_SPECIFIED',0,NULL,NULL,NULL,'6f60dbe2-3f39-4c89-9fc2-871d5b90b4f0'),
 (25,7,'REASON FOR REFERRAL TO ANOTHER SITE','en',1,1,'2013-11-12 13:43:54','FULLY_SPECIFIED',0,NULL,NULL,NULL,'70924ae9-71d2-4546-ab34-7bbb19b8a2f6'),
 (26,7,'REFERRAL REASON','en',0,1,'2013-11-12 13:43:54','SHORT',0,NULL,NULL,NULL,'d82998b0-5911-4137-bc51-230df004b496'),
 (27,8,'Referral Urgency','en',1,1,'2013-11-12 13:47:24','FULLY_SPECIFIED',0,NULL,NULL,NULL,'c92cb7cd-acc1-4a25-850f-b5bb75f227af'),
 (28,9,'Urgent','en',1,1,'2013-11-12 13:50:11','FULLY_SPECIFIED',0,NULL,NULL,NULL,'c9a2918e-335f-4b23-82fa-a719508c5c6e'),
 (29,10,'Routine','en',1,1,'2013-11-12 13:50:54','FULLY_SPECIFIED',0,NULL,NULL,NULL,'5069087c-79f8-4a3b-8d4c-48443dd20303'),
 (30,11,'Immediate Referral','en',1,1,'2013-11-12 13:51:39','FULLY_SPECIFIED',0,NULL,NULL,NULL,'56046bfb-78c0-4042-9774-6d0bd632517a');
/*!40000 ALTER TABLE `concept_name` ENABLE KEYS */;


--
-- Definition of table `concept_name_tag`
--

DROP TABLE IF EXISTS `concept_name_tag`;
CREATE TABLE `concept_name_tag` (
  `concept_name_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_name_tag_id`),
  UNIQUE KEY `concept_name_tag_unique_tags` (`tag`),
  UNIQUE KEY `concept_name_tag_uuid_index` (`uuid`),
  KEY `user_who_created_name_tag` (`creator`),
  KEY `user_who_voided_name_tag` (`voided_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_name_tag`
--

/*!40000 ALTER TABLE `concept_name_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_name_tag` ENABLE KEYS */;


--
-- Definition of table `concept_name_tag_map`
--

DROP TABLE IF EXISTS `concept_name_tag_map`;
CREATE TABLE `concept_name_tag_map` (
  `concept_name_id` int(11) NOT NULL,
  `concept_name_tag_id` int(11) NOT NULL,
  KEY `mapped_concept_name` (`concept_name_id`),
  KEY `mapped_concept_name_tag` (`concept_name_tag_id`),
  CONSTRAINT `mapped_concept_name` FOREIGN KEY (`concept_name_id`) REFERENCES `concept_name` (`concept_name_id`),
  CONSTRAINT `mapped_concept_name_tag` FOREIGN KEY (`concept_name_tag_id`) REFERENCES `concept_name_tag` (`concept_name_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_name_tag_map`
--

/*!40000 ALTER TABLE `concept_name_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_name_tag_map` ENABLE KEYS */;


--
-- Definition of table `concept_numeric`
--

DROP TABLE IF EXISTS `concept_numeric`;
CREATE TABLE `concept_numeric` (
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `hi_absolute` double DEFAULT NULL,
  `hi_critical` double DEFAULT NULL,
  `hi_normal` double DEFAULT NULL,
  `low_absolute` double DEFAULT NULL,
  `low_critical` double DEFAULT NULL,
  `low_normal` double DEFAULT NULL,
  `units` varchar(50) DEFAULT NULL,
  `precise` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `numeric_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_numeric`
--

/*!40000 ALTER TABLE `concept_numeric` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_numeric` ENABLE KEYS */;


--
-- Definition of table `concept_proposal`
--

DROP TABLE IF EXISTS `concept_proposal`;
CREATE TABLE `concept_proposal` (
  `concept_proposal_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `original_text` varchar(255) NOT NULL DEFAULT '',
  `final_text` varchar(255) DEFAULT NULL,
  `obs_id` int(11) DEFAULT NULL,
  `obs_concept_id` int(11) DEFAULT NULL,
  `state` varchar(32) NOT NULL DEFAULT 'UNMAPPED',
  `comments` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `locale` varchar(50) NOT NULL DEFAULT '',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_proposal_id`),
  UNIQUE KEY `concept_proposal_uuid_index` (`uuid`),
  KEY `user_who_changed_proposal` (`changed_by`),
  KEY `concept_for_proposal` (`concept_id`),
  KEY `user_who_created_proposal` (`creator`),
  KEY `encounter_for_proposal` (`encounter_id`),
  KEY `proposal_obs_concept_id` (`obs_concept_id`),
  KEY `proposal_obs_id` (`obs_id`),
  CONSTRAINT `concept_for_proposal` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `encounter_for_proposal` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `proposal_obs_concept_id` FOREIGN KEY (`obs_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `proposal_obs_id` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `user_who_changed_proposal` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_proposal` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_proposal`
--

/*!40000 ALTER TABLE `concept_proposal` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_proposal` ENABLE KEYS */;


--
-- Definition of table `concept_proposal_tag_map`
--

DROP TABLE IF EXISTS `concept_proposal_tag_map`;
CREATE TABLE `concept_proposal_tag_map` (
  `concept_proposal_id` int(11) NOT NULL,
  `concept_name_tag_id` int(11) NOT NULL,
  KEY `mapped_concept_proposal_tag` (`concept_name_tag_id`),
  KEY `mapped_concept_proposal` (`concept_proposal_id`),
  CONSTRAINT `mapped_concept_proposal` FOREIGN KEY (`concept_proposal_id`) REFERENCES `concept_proposal` (`concept_proposal_id`),
  CONSTRAINT `mapped_concept_proposal_tag` FOREIGN KEY (`concept_name_tag_id`) REFERENCES `concept_name_tag` (`concept_name_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_proposal_tag_map`
--

/*!40000 ALTER TABLE `concept_proposal_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_proposal_tag_map` ENABLE KEYS */;


--
-- Definition of table `concept_reference_map`
--

DROP TABLE IF EXISTS `concept_reference_map`;
CREATE TABLE `concept_reference_map` (
  `concept_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_reference_term_id` int(11) NOT NULL,
  `concept_map_type_id` int(11) NOT NULL DEFAULT '1',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_map_id`),
  KEY `map_for_concept` (`concept_id`),
  KEY `map_creator` (`creator`),
  KEY `mapped_concept_map_type` (`concept_map_type_id`),
  KEY `mapped_user_changed_ref_term` (`changed_by`),
  KEY `mapped_concept_reference_term` (`concept_reference_term_id`),
  CONSTRAINT `mapped_concept_map_type` FOREIGN KEY (`concept_map_type_id`) REFERENCES `concept_map_type` (`concept_map_type_id`),
  CONSTRAINT `mapped_concept_reference_term` FOREIGN KEY (`concept_reference_term_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`),
  CONSTRAINT `mapped_user_changed_ref_term` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `map_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_reference_map`
--

/*!40000 ALTER TABLE `concept_reference_map` DISABLE KEYS */;
INSERT INTO `concept_reference_map` (`concept_map_id`,`concept_reference_term_id`,`concept_map_type_id`,`creator`,`date_created`,`concept_id`,`changed_by`,`date_changed`,`uuid`) VALUES 
 (1,1,2,1,'2013-11-12 13:40:15',5,NULL,NULL,'ef6e9771-3d6d-4664-8332-64b9ad115be6'),
 (2,2,1,1,'2013-11-12 13:42:00',6,NULL,NULL,'a610d953-809b-4cc6-8127-5893ae5668c1'),
 (3,5,2,1,'2013-11-12 13:45:35',7,NULL,NULL,'bda185aa-636d-4f51-9e0c-382d237c9299'),
 (4,3,2,1,'2013-11-12 13:45:35',7,NULL,NULL,'5f01ddc2-0b6b-403b-8f0f-9b8a8579020d'),
 (5,4,2,1,'2013-11-12 13:45:35',7,NULL,NULL,'a7c16cec-16ba-4010-a820-2d1a64895aa3'),
 (6,6,2,1,'2013-11-12 13:47:45',8,NULL,NULL,'b1eb65f4-bde0-4c12-9fb0-0887db72fceb'),
 (7,7,2,1,'2013-11-12 13:50:11',9,NULL,NULL,'22164bd5-b5ab-4bd7-abcc-1cfa2548a929'),
 (8,8,2,1,'2013-11-12 13:50:54',10,NULL,NULL,'1537c517-7277-4e73-a0f4-c3d617f2bf2c'),
 (9,9,2,1,'2013-11-12 13:51:39',11,NULL,NULL,'ab08cbc5-3da8-4b35-968e-f27e28e5de15');
/*!40000 ALTER TABLE `concept_reference_map` ENABLE KEYS */;


--
-- Definition of table `concept_reference_source`
--

DROP TABLE IF EXISTS `concept_reference_source`;
CREATE TABLE `concept_reference_source` (
  `concept_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `hl7_code` varchar(50) DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_source_id`),
  UNIQUE KEY `concept_source_unique_hl7_codes` (`hl7_code`),
  KEY `unique_hl7_code` (`hl7_code`),
  KEY `concept_source_creator` (`creator`),
  KEY `user_who_retired_concept_source` (`retired_by`),
  CONSTRAINT `concept_source_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept_source` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_reference_source`
--

/*!40000 ALTER TABLE `concept_reference_source` DISABLE KEYS */;
INSERT INTO `concept_reference_source` (`concept_source_id`,`name`,`description`,`hl7_code`,`creator`,`date_created`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (1,'LOINC','LOINC (www.loinc.org)','LN',1,'2013-11-12 13:38:43',0,NULL,NULL,NULL,'b51cd7f8-6ecd-4f39-80b5-bbc414ceb7d8'),
 (2,'PIH','Partners In Health concept dictionary using concept ids and preferred English names','PIH',1,'2013-11-12 13:43:30',0,NULL,NULL,NULL,'5fc9b258-0924-47cd-a597-aa689a207c1f'),
 (3,'RWCS','Rwanda Code Set','RWCS',1,'2013-11-12 13:47:07',0,NULL,NULL,NULL,'20863a11-7206-424f-abeb-28f08fb9ed53'),
 (4,'openmrs-shr','openmrs-shr','openmrs-shr',1,'2013-11-19 12:44:48',0,NULL,NULL,NULL,'305d8dc6-dc34-4b7b-a1a5-1353a284e4d6');
/*!40000 ALTER TABLE `concept_reference_source` ENABLE KEYS */;


--
-- Definition of table `concept_reference_term`
--

DROP TABLE IF EXISTS `concept_reference_term`;
CREATE TABLE `concept_reference_term` (
  `concept_reference_term_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_source_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `version` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_reference_term_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `mapped_user_creator` (`creator`),
  KEY `mapped_user_changed` (`changed_by`),
  KEY `mapped_user_retired` (`retired_by`),
  KEY `mapped_concept_source` (`concept_source_id`),
  KEY `code` (`code`),
  CONSTRAINT `mapped_concept_source` FOREIGN KEY (`concept_source_id`) REFERENCES `concept_reference_source` (`concept_source_id`),
  CONSTRAINT `mapped_user_changed` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_retired` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_reference_term`
--

/*!40000 ALTER TABLE `concept_reference_term` DISABLE KEYS */;
INSERT INTO `concept_reference_term` (`concept_reference_term_id`,`concept_source_id`,`name`,`code`,`version`,`description`,`creator`,`date_created`,`date_changed`,`changed_by`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (1,1,NULL,'57202-4',NULL,NULL,1,'2013-11-12 13:39:59',NULL,NULL,0,NULL,NULL,NULL,'594d174c-046a-4158-843f-21133e6b0790'),
 (2,1,NULL,'57133-1',NULL,NULL,1,'2013-11-12 13:41:42',NULL,NULL,0,NULL,NULL,NULL,'484ca450-d80a-42cf-b537-2ee4417d0b5e'),
 (3,2,NULL,'1739',NULL,NULL,1,'2013-11-12 13:44:26',NULL,NULL,0,NULL,NULL,NULL,'a27be904-e502-4f5b-978d-fb894b7d9603'),
 (4,2,NULL,'REASON FOR REFERRAL TO ANOTHER SITE',NULL,NULL,1,'2013-11-12 13:44:47',NULL,NULL,0,NULL,NULL,NULL,'6892b2e9-46e7-4202-8e0b-5b6b248568c8'),
 (5,1,NULL,'42349-1',NULL,NULL,1,'2013-11-12 13:45:27',NULL,NULL,0,NULL,NULL,NULL,'a22bc6d4-e7b9-4fff-a3a8-96182f35369d'),
 (6,3,NULL,'8517',NULL,NULL,1,'2013-11-12 13:47:36',NULL,NULL,0,NULL,NULL,NULL,'a35a122c-df8b-450a-aa41-0efff537dd82'),
 (7,3,NULL,'8515',NULL,NULL,1,'2013-11-12 13:50:03',NULL,NULL,0,NULL,NULL,NULL,'ec39302a-4cb7-4b0e-a7d3-21eec07d8bd2'),
 (8,3,NULL,'8516',NULL,NULL,1,'2013-11-12 13:50:46',NULL,NULL,0,NULL,NULL,NULL,'115917c5-e905-479a-9160-beb4784de5f4'),
 (9,3,NULL,'8512',NULL,NULL,1,'2013-11-12 13:51:31',NULL,NULL,0,NULL,NULL,NULL,'924b4de2-6fe2-4d72-a5b9-9b91f4e3fab8');
/*!40000 ALTER TABLE `concept_reference_term` ENABLE KEYS */;


--
-- Definition of table `concept_reference_term_map`
--

DROP TABLE IF EXISTS `concept_reference_term_map`;
CREATE TABLE `concept_reference_term_map` (
  `concept_reference_term_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `term_a_id` int(11) NOT NULL,
  `term_b_id` int(11) NOT NULL,
  `a_is_to_b_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_reference_term_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `mapped_term_a` (`term_a_id`),
  KEY `mapped_term_b` (`term_b_id`),
  KEY `mapped_concept_map_type_ref_term_map` (`a_is_to_b_id`),
  KEY `mapped_user_creator_ref_term_map` (`creator`),
  KEY `mapped_user_changed_ref_term_map` (`changed_by`),
  CONSTRAINT `mapped_concept_map_type_ref_term_map` FOREIGN KEY (`a_is_to_b_id`) REFERENCES `concept_map_type` (`concept_map_type_id`),
  CONSTRAINT `mapped_term_a` FOREIGN KEY (`term_a_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`),
  CONSTRAINT `mapped_term_b` FOREIGN KEY (`term_b_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`),
  CONSTRAINT `mapped_user_changed_ref_term_map` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_creator_ref_term_map` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_reference_term_map`
--

/*!40000 ALTER TABLE `concept_reference_term_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_reference_term_map` ENABLE KEYS */;


--
-- Definition of table `concept_set`
--

DROP TABLE IF EXISTS `concept_set`;
CREATE TABLE `concept_set` (
  `concept_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `concept_set` int(11) NOT NULL DEFAULT '0',
  `sort_weight` double DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_set_id`),
  UNIQUE KEY `concept_set_uuid_index` (`uuid`),
  KEY `idx_concept_set_concept` (`concept_id`),
  KEY `has_a` (`concept_set`),
  KEY `user_who_created` (`creator`),
  CONSTRAINT `has_a` FOREIGN KEY (`concept_set`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_created` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_set`
--

/*!40000 ALTER TABLE `concept_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_set` ENABLE KEYS */;


--
-- Definition of table `concept_set_derived`
--

DROP TABLE IF EXISTS `concept_set_derived`;
CREATE TABLE `concept_set_derived` (
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `concept_set` int(11) NOT NULL DEFAULT '0',
  `sort_weight` double DEFAULT NULL,
  PRIMARY KEY (`concept_id`,`concept_set`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_set_derived`
--

/*!40000 ALTER TABLE `concept_set_derived` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_set_derived` ENABLE KEYS */;


--
-- Definition of table `concept_state_conversion`
--

DROP TABLE IF EXISTS `concept_state_conversion`;
CREATE TABLE `concept_state_conversion` (
  `concept_state_conversion_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT '0',
  `program_workflow_id` int(11) DEFAULT '0',
  `program_workflow_state_id` int(11) DEFAULT '0',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_state_conversion_id`),
  UNIQUE KEY `unique_workflow_concept_in_conversion` (`program_workflow_id`,`concept_id`),
  UNIQUE KEY `concept_state_conversion_uuid_index` (`uuid`),
  KEY `concept_triggers_conversion` (`concept_id`),
  KEY `conversion_to_state` (`program_workflow_state_id`),
  CONSTRAINT `concept_triggers_conversion` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `conversion_involves_workflow` FOREIGN KEY (`program_workflow_id`) REFERENCES `program_workflow` (`program_workflow_id`),
  CONSTRAINT `conversion_to_state` FOREIGN KEY (`program_workflow_state_id`) REFERENCES `program_workflow_state` (`program_workflow_state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_state_conversion`
--

/*!40000 ALTER TABLE `concept_state_conversion` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_state_conversion` ENABLE KEYS */;


--
-- Definition of table `concept_stop_word`
--

DROP TABLE IF EXISTS `concept_stop_word`;
CREATE TABLE `concept_stop_word` (
  `concept_stop_word_id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(50) NOT NULL,
  `locale` varchar(20) NOT NULL DEFAULT 'en',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_stop_word_id`),
  UNIQUE KEY `Unique_StopWord_Key` (`word`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_stop_word`
--

/*!40000 ALTER TABLE `concept_stop_word` DISABLE KEYS */;
INSERT INTO `concept_stop_word` (`concept_stop_word_id`,`word`,`locale`,`uuid`) VALUES 
 (1,'A','en','f5f45540-e2a7-11df-87ae-18a905e044dc'),
 (2,'AND','en','f5f469ae-e2a7-11df-87ae-18a905e044dc'),
 (3,'AT','en','f5f47070-e2a7-11df-87ae-18a905e044dc'),
 (4,'BUT','en','f5f476c4-e2a7-11df-87ae-18a905e044dc'),
 (5,'BY','en','f5f47d04-e2a7-11df-87ae-18a905e044dc'),
 (6,'FOR','en','f5f4834e-e2a7-11df-87ae-18a905e044dc'),
 (7,'HAS','en','f5f48a24-e2a7-11df-87ae-18a905e044dc'),
 (8,'OF','en','f5f49064-e2a7-11df-87ae-18a905e044dc'),
 (9,'THE','en','f5f496ae-e2a7-11df-87ae-18a905e044dc'),
 (10,'TO','en','f5f49cda-e2a7-11df-87ae-18a905e044dc');
/*!40000 ALTER TABLE `concept_stop_word` ENABLE KEYS */;


--
-- Definition of table `concept_word`
--

DROP TABLE IF EXISTS `concept_word`;
CREATE TABLE `concept_word` (
  `concept_word_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `word` varchar(50) NOT NULL DEFAULT '',
  `locale` varchar(20) NOT NULL DEFAULT '',
  `concept_name_id` int(11) NOT NULL,
  `weight` double DEFAULT '1',
  PRIMARY KEY (`concept_word_id`),
  KEY `word_in_concept_name` (`word`),
  KEY `concept_word_concept_idx` (`concept_id`),
  KEY `concept_word_weight_index` (`weight`),
  KEY `word_for_name` (`concept_name_id`),
  CONSTRAINT `word_for` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `word_for_name` FOREIGN KEY (`concept_name_id`) REFERENCES `concept_name` (`concept_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `concept_word`
--

/*!40000 ALTER TABLE `concept_word` DISABLE KEYS */;
INSERT INTO `concept_word` (`concept_word_id`,`concept_id`,`word`,`locale`,`concept_name_id`,`weight`) VALUES 
 (21,1,'SIM','pt',4,11.9111111111111),
 (22,1,'YES','en',8,11.9111111111111),
 (23,1,'TRUE','en',7,10.5625),
 (24,1,'SÌ','it',2,15.15),
 (25,1,'VERO','it',1,10.5),
 (26,1,'VERDADEIRO','pt',3,8.31),
 (27,1,'SÍ','es',10,15.15),
 (28,1,'OUI','fr',6,11.9111111111111),
 (29,1,'VERDADERO','es',9,8.45679012345679),
 (30,1,'VRAI','fr',5,10.5),
 (31,2,'FALSO','es',19,9.72),
 (32,2,'NO','en',18,15.15),
 (33,2,'FALSO','it',11,9.72),
 (34,2,'NO','it',12,15.15),
 (35,2,'FAUX','fr',15,10.5),
 (36,2,'NON','fr',16,11.9111111111111),
 (37,2,'NÃO','pt',14,11.9111111111111),
 (38,2,'FALSO','pt',13,9.72),
 (39,2,'NO','es',20,15.15),
 (40,2,'FALSE','en',17,9.78),
 (41,3,'REQUEST','en',21,1.33101851851852),
 (42,3,'DATE','en',21,2.625),
 (43,3,'OF','en',21,1.44444444444444),
 (44,3,'REFERRAL','en',21,1.36574074074074),
 (45,4,'TO','en',22,1.37083333333333),
 (46,4,'REFER','en',22,2.5375),
 (47,4,'PATIENT','en',22,1.39285714285714),
 (52,5,'OF','en',23,1.44444444444444),
 (53,5,'REFERRAL','en',23,1.36574074074074),
 (54,5,'REQUEST','en',23,1.33101851851852),
 (55,5,'DATE','en',23,2.625),
 (56,6,'PATIENT','en',24,1.39285714285714),
 (57,6,'REFER','en',24,2.5375),
 (58,6,'TO','en',24,1.37083333333333),
 (67,7,'REASON','en',26,1.33666666666667),
 (68,7,'REASON','en',25,2.33571428571429),
 (69,7,'REFERRAL','en',26,2.205),
 (70,7,'TO','en',25,1.3234693877551),
 (71,7,'ANOTHER','en',25,1.31190476190476),
 (72,7,'FOR','en',25,1.39285714285714),
 (73,7,'SITE','en',25,1.30625),
 (74,7,'REFERRAL','en',25,1.34285714285714),
 (79,9,'URGENT','en',28,9.40277777777778),
 (80,10,'ROUTINE','en',29,9.06122448979592),
 (81,11,'IMMEDIATE','en',30,2.25),
 (82,11,'REFERRAL','en',30,1.35606060606061),
 (83,8,'URGENCY','en',27,1.36875),
 (84,8,'REFERRAL','en',27,2.3125);
/*!40000 ALTER TABLE `concept_word` ENABLE KEYS */;


--
-- Definition of table `drug`
--

DROP TABLE IF EXISTS `drug`;
CREATE TABLE `drug` (
  `drug_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `combination` tinyint(1) NOT NULL DEFAULT '0',
  `dosage_form` int(11) DEFAULT NULL,
  `dose_strength` double DEFAULT NULL,
  `maximum_daily_dose` double DEFAULT NULL,
  `minimum_daily_dose` double DEFAULT NULL,
  `route` int(11) DEFAULT NULL,
  `units` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`drug_id`),
  UNIQUE KEY `drug_uuid_index` (`uuid`),
  KEY `primary_drug_concept` (`concept_id`),
  KEY `drug_creator` (`creator`),
  KEY `drug_changed_by` (`changed_by`),
  KEY `dosage_form_concept` (`dosage_form`),
  KEY `drug_retired_by` (`retired_by`),
  KEY `route_concept` (`route`),
  CONSTRAINT `dosage_form_concept` FOREIGN KEY (`dosage_form`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `drug_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `drug_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `drug_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `primary_drug_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `route_concept` FOREIGN KEY (`route`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `drug`
--

/*!40000 ALTER TABLE `drug` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug` ENABLE KEYS */;


--
-- Definition of table `drug_ingredient`
--

DROP TABLE IF EXISTS `drug_ingredient`;
CREATE TABLE `drug_ingredient` (
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `ingredient_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ingredient_id`,`concept_id`),
  KEY `combination_drug` (`concept_id`),
  CONSTRAINT `combination_drug` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `drug_ingredient`
--

/*!40000 ALTER TABLE `drug_ingredient` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_ingredient` ENABLE KEYS */;


--
-- Definition of table `drug_order`
--

DROP TABLE IF EXISTS `drug_order`;
CREATE TABLE `drug_order` (
  `order_id` int(11) NOT NULL DEFAULT '0',
  `drug_inventory_id` int(11) DEFAULT '0',
  `dose` double DEFAULT NULL,
  `equivalent_daily_dose` double DEFAULT NULL,
  `units` varchar(255) DEFAULT NULL,
  `frequency` varchar(255) DEFAULT NULL,
  `prn` tinyint(1) NOT NULL DEFAULT '0',
  `complex` tinyint(1) NOT NULL DEFAULT '0',
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `inventory_item` (`drug_inventory_id`),
  CONSTRAINT `extends_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `inventory_item` FOREIGN KEY (`drug_inventory_id`) REFERENCES `drug` (`drug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `drug_order`
--

/*!40000 ALTER TABLE `drug_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_order` ENABLE KEYS */;


--
-- Definition of table `encounter`
--

DROP TABLE IF EXISTS `encounter`;
CREATE TABLE `encounter` (
  `encounter_id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_type` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `location_id` int(11) DEFAULT NULL,
  `form_id` int(11) DEFAULT NULL,
  `encounter_datetime` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `encounter_uuid_index` (`uuid`),
  KEY `encounter_datetime_idx` (`encounter_datetime`),
  KEY `encounter_ibfk_1` (`creator`),
  KEY `encounter_type_id` (`encounter_type`),
  KEY `encounter_form` (`form_id`),
  KEY `encounter_location` (`location_id`),
  KEY `encounter_patient` (`patient_id`),
  KEY `user_who_voided_encounter` (`voided_by`),
  KEY `encounter_changed_by` (`changed_by`),
  KEY `encounter_visit_id_fk` (`visit_id`),
  CONSTRAINT `encounter_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_form` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`),
  CONSTRAINT `encounter_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `encounter_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `encounter_type_id` FOREIGN KEY (`encounter_type`) REFERENCES `encounter_type` (`encounter_type_id`),
  CONSTRAINT `encounter_visit_id_fk` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`),
  CONSTRAINT `user_who_voided_encounter` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `encounter`
--

/*!40000 ALTER TABLE `encounter` DISABLE KEYS */;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`,`patient_id`,`location_id`,`form_id`,`encounter_datetime`,`creator`,`date_created`,`voided`,`voided_by`,`date_voided`,`void_reason`,`changed_by`,`date_changed`,`visit_id`,`uuid`) VALUES 
 (10,1,23,3,NULL,'2013-11-12 00:00:00',1,'2013-11-19 12:59:56',0,NULL,NULL,NULL,NULL,NULL,NULL,'f4c478ed-cfaf-4ad6-ac82-6e4280957aa1');
/*!40000 ALTER TABLE `encounter` ENABLE KEYS */;


--
-- Definition of table `encounter_provider`
--

DROP TABLE IF EXISTS `encounter_provider`;
CREATE TABLE `encounter_provider` (
  `encounter_provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `encounter_role_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `date_voided` datetime DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`encounter_provider_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_id_fk` (`encounter_id`),
  KEY `provider_id_fk` (`provider_id`),
  KEY `encounter_role_id_fk` (`encounter_role_id`),
  KEY `encounter_provider_creator` (`creator`),
  KEY `encounter_provider_changed_by` (`changed_by`),
  KEY `encounter_provider_voided_by` (`voided_by`),
  CONSTRAINT `encounter_provider_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `encounter_provider_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_provider_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_role_id_fk` FOREIGN KEY (`encounter_role_id`) REFERENCES `encounter_role` (`encounter_role_id`),
  CONSTRAINT `provider_id_fk` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `encounter_provider`
--

/*!40000 ALTER TABLE `encounter_provider` DISABLE KEYS */;
INSERT INTO `encounter_provider` (`encounter_provider_id`,`encounter_id`,`provider_id`,`encounter_role_id`,`creator`,`date_created`,`changed_by`,`date_changed`,`voided`,`date_voided`,`voided_by`,`void_reason`,`uuid`) VALUES 
 (1,10,1,2,1,'2013-11-19 12:59:56',NULL,NULL,0,NULL,NULL,NULL,'79f50f7f-c233-42bc-aad6-88702d60e53f');
/*!40000 ALTER TABLE `encounter_provider` ENABLE KEYS */;


--
-- Definition of table `encounter_role`
--

DROP TABLE IF EXISTS `encounter_role`;
CREATE TABLE `encounter_role` (
  `encounter_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`encounter_role_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_role_creator_fk` (`creator`),
  KEY `encounter_role_changed_by_fk` (`changed_by`),
  KEY `encounter_role_retired_by_fk` (`retired_by`),
  CONSTRAINT `encounter_role_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_role_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_role_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `encounter_role`
--

/*!40000 ALTER TABLE `encounter_role` DISABLE KEYS */;
INSERT INTO `encounter_role` (`encounter_role_id`,`name`,`description`,`creator`,`date_created`,`changed_by`,`date_changed`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (1,'Unknown','Unknown encounter role for legacy providers with no encounter role set',1,'2011-08-18 14:00:00',NULL,NULL,0,NULL,NULL,NULL,'a0b03050-c99b-11e0-9572-0800200c9a66'),
 (2,'SHR Provider','Created by the SHR',1,'2013-11-19 12:59:56',NULL,NULL,0,NULL,NULL,NULL,'27822cae-4b50-42ca-9c45-8cb0e637ce09');
/*!40000 ALTER TABLE `encounter_role` ENABLE KEYS */;


--
-- Definition of table `encounter_type`
--

DROP TABLE IF EXISTS `encounter_type`;
CREATE TABLE `encounter_type` (
  `encounter_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`encounter_type_id`),
  UNIQUE KEY `encounter_type_uuid_index` (`uuid`),
  KEY `encounter_type_retired_status` (`retired`),
  KEY `user_who_created_type` (`creator`),
  KEY `user_who_retired_encounter_type` (`retired_by`),
  CONSTRAINT `user_who_created_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_encounter_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `encounter_type`
--

/*!40000 ALTER TABLE `encounter_type` DISABLE KEYS */;
INSERT INTO `encounter_type` (`encounter_type_id`,`name`,`description`,`creator`,`date_created`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (1,'ANC Referral','ANC Referral',1,'2013-11-05 13:13:41',0,NULL,NULL,NULL,'3eb32440-4b94-419d-b753-68b57f88cb29');
/*!40000 ALTER TABLE `encounter_type` ENABLE KEYS */;


--
-- Definition of table `errorqueue`
--

DROP TABLE IF EXISTS `errorqueue`;
CREATE TABLE `errorqueue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time_response_received` datetime DEFAULT NULL,
  `error` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `errorqueue`
--

/*!40000 ALTER TABLE `errorqueue` DISABLE KEYS */;
/*!40000 ALTER TABLE `errorqueue` ENABLE KEYS */;


--
-- Definition of table `field`
--

DROP TABLE IF EXISTS `field`;
CREATE TABLE `field` (
  `field_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `field_type` int(11) DEFAULT NULL,
  `concept_id` int(11) DEFAULT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `attribute_name` varchar(50) DEFAULT NULL,
  `default_value` text,
  `select_multiple` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`field_id`),
  UNIQUE KEY `field_uuid_index` (`uuid`),
  KEY `field_retired_status` (`retired`),
  KEY `user_who_changed_field` (`changed_by`),
  KEY `concept_for_field` (`concept_id`),
  KEY `user_who_created_field` (`creator`),
  KEY `type_of_field` (`field_type`),
  KEY `user_who_retired_field` (`retired_by`),
  CONSTRAINT `concept_for_field` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `type_of_field` FOREIGN KEY (`field_type`) REFERENCES `field_type` (`field_type_id`),
  CONSTRAINT `user_who_changed_field` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_field` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_field` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `field`
--

/*!40000 ALTER TABLE `field` DISABLE KEYS */;
/*!40000 ALTER TABLE `field` ENABLE KEYS */;


--
-- Definition of table `field_answer`
--

DROP TABLE IF EXISTS `field_answer`;
CREATE TABLE `field_answer` (
  `field_id` int(11) NOT NULL DEFAULT '0',
  `answer_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`field_id`,`answer_id`),
  UNIQUE KEY `field_answer_uuid_index` (`uuid`),
  KEY `field_answer_concept` (`answer_id`),
  KEY `user_who_created_field_answer` (`creator`),
  CONSTRAINT `answers_for_field` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`),
  CONSTRAINT `field_answer_concept` FOREIGN KEY (`answer_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_created_field_answer` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `field_answer`
--

/*!40000 ALTER TABLE `field_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_answer` ENABLE KEYS */;


--
-- Definition of table `field_type`
--

DROP TABLE IF EXISTS `field_type`;
CREATE TABLE `field_type` (
  `field_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `is_set` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`field_type_id`),
  UNIQUE KEY `field_type_uuid_index` (`uuid`),
  KEY `user_who_created_field_type` (`creator`),
  CONSTRAINT `user_who_created_field_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `field_type`
--

/*!40000 ALTER TABLE `field_type` DISABLE KEYS */;
INSERT INTO `field_type` (`field_type_id`,`name`,`description`,`is_set`,`creator`,`date_created`,`uuid`) VALUES 
 (1,'Concept','',0,1,'2005-02-22 00:00:00','8d5e7d7c-c2cc-11de-8d13-0010c6dffd0f'),
 (2,'Database element','',0,1,'2005-02-22 00:00:00','8d5e8196-c2cc-11de-8d13-0010c6dffd0f'),
 (3,'Set of Concepts','',1,1,'2005-02-22 00:00:00','8d5e836c-c2cc-11de-8d13-0010c6dffd0f'),
 (4,'Miscellaneous Set','',1,1,'2005-02-22 00:00:00','8d5e852e-c2cc-11de-8d13-0010c6dffd0f'),
 (5,'Section','',1,1,'2005-02-22 00:00:00','8d5e86fa-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `field_type` ENABLE KEYS */;


--
-- Definition of table `form`
--

DROP TABLE IF EXISTS `form`;
CREATE TABLE `form` (
  `form_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `version` varchar(50) NOT NULL DEFAULT '',
  `build` int(11) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `xslt` text,
  `template` text,
  `description` text,
  `encounter_type` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`form_id`),
  UNIQUE KEY `form_uuid_index` (`uuid`),
  KEY `form_published_index` (`published`),
  KEY `form_retired_index` (`retired`),
  KEY `form_published_and_retired_index` (`published`,`retired`),
  KEY `user_who_last_changed_form` (`changed_by`),
  KEY `user_who_created_form` (`creator`),
  KEY `form_encounter_type` (`encounter_type`),
  KEY `user_who_retired_form` (`retired_by`),
  CONSTRAINT `form_encounter_type` FOREIGN KEY (`encounter_type`) REFERENCES `encounter_type` (`encounter_type_id`),
  CONSTRAINT `user_who_created_form` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_last_changed_form` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_form` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `form`
--

/*!40000 ALTER TABLE `form` DISABLE KEYS */;
INSERT INTO `form` (`form_id`,`name`,`version`,`build`,`published`,`xslt`,`template`,`description`,`encounter_type`,`creator`,`date_created`,`changed_by`,`date_changed`,`retired`,`retired_by`,`date_retired`,`retired_reason`,`uuid`) VALUES 
 (1,'RHEA ANC 5: Referral Form','1.0',NULL,0,NULL,NULL,'RHEA ANC 5: Referral Form',1,1,'2013-11-12 13:34:43',1,'2013-11-12 13:52:45',0,NULL,NULL,NULL,'adddc999-8064-41e7-bd58-db23be8c59be');
/*!40000 ALTER TABLE `form` ENABLE KEYS */;


--
-- Definition of table `form_field`
--

DROP TABLE IF EXISTS `form_field`;
CREATE TABLE `form_field` (
  `form_field_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL DEFAULT '0',
  `field_id` int(11) NOT NULL DEFAULT '0',
  `field_number` int(11) DEFAULT NULL,
  `field_part` varchar(5) DEFAULT NULL,
  `page_number` int(11) DEFAULT NULL,
  `parent_form_field` int(11) DEFAULT NULL,
  `min_occurs` int(11) DEFAULT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `sort_weight` double DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`form_field_id`),
  UNIQUE KEY `form_field_uuid_index` (`uuid`),
  KEY `user_who_last_changed_form_field` (`changed_by`),
  KEY `user_who_created_form_field` (`creator`),
  KEY `field_within_form` (`field_id`),
  KEY `form_containing_field` (`form_id`),
  KEY `form_field_hierarchy` (`parent_form_field`),
  CONSTRAINT `field_within_form` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`),
  CONSTRAINT `form_containing_field` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`),
  CONSTRAINT `form_field_hierarchy` FOREIGN KEY (`parent_form_field`) REFERENCES `form_field` (`form_field_id`),
  CONSTRAINT `user_who_created_form_field` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_last_changed_form_field` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `form_field`
--

/*!40000 ALTER TABLE `form_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_field` ENABLE KEYS */;


--
-- Definition of table `form_resource`
--

DROP TABLE IF EXISTS `form_resource`;
CREATE TABLE `form_resource` (
  `form_resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value_reference` text NOT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`form_resource_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `unique_form_and_name` (`form_id`,`name`),
  CONSTRAINT `form_resource_form_fk` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `form_resource`
--

/*!40000 ALTER TABLE `form_resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_resource` ENABLE KEYS */;


--
-- Definition of table `global_property`
--

DROP TABLE IF EXISTS `global_property`;
CREATE TABLE `global_property` (
  `property` varchar(255) NOT NULL DEFAULT '',
  `property_value` text,
  `description` text,
  `uuid` char(38) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  PRIMARY KEY (`property`),
  UNIQUE KEY `global_property_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `global_property`
--

/*!40000 ALTER TABLE `global_property` DISABLE KEYS */;
INSERT INTO `global_property` (`property`,`property_value`,`description`,`uuid`,`datatype`,`datatype_config`,`preferred_handler`,`handler_config`) VALUES 
 ('application.name','OpenMRS','The name of this application, as presented to the user, for example on the login and welcome pages.','2668742b-f7d4-4ade-ae53-eaac49c668ee',NULL,NULL,NULL,NULL),
 ('autoCloseVisits.visitType',NULL,'comma-separated list of the visit type(s) to automatically close','99b50374-6830-47b2-b035-e30cc2460e00',NULL,NULL,NULL,NULL),
 ('concept.caseSensitiveNamesInConceptNameTable','true','Indicates whether names in the concept_name table are case sensitive or not. Setting this to false for MySQL with a case insensitive collation improves search performance.','4ecca5c1-c304-4bd1-8f07-729da4b636dc',NULL,NULL,NULL,NULL),
 ('concept.causeOfDeath','5002','Concept id of the concept defining the CAUSE OF DEATH concept','86fa7353-c7b2-40a0-b995-aa99ab480a27',NULL,NULL,NULL,NULL),
 ('concept.cd4_count','5497','Concept id of the concept defining the CD4 count concept','0aca5a2f-2894-46d8-a6b2-1159dfa8f7b6',NULL,NULL,NULL,NULL),
 ('concept.defaultConceptMapType','NARROWER-THAN','Default concept map type which is used when no other is set','b2c0f0bb-6cff-4e87-8ded-1528549f7b77',NULL,NULL,NULL,NULL),
 ('concept.false','2','Concept id of the concept defining the FALSE boolean concept','5fc1def7-0921-432b-b9db-4d766679fe42',NULL,NULL,NULL,NULL),
 ('concept.height','5090','Concept id of the concept defining the HEIGHT concept','0ac8567d-d6a0-4d25-ac3c-b40e0864f326',NULL,NULL,NULL,NULL),
 ('concept.medicalRecordObservations','1238','The concept id of the MEDICAL_RECORD_OBSERVATIONS concept.  This concept_id is presumed to be the generic grouping (obr) concept in hl7 messages.  An obs_group row is not created for this concept.','a29f18e4-0de4-4e17-9f39-684c2715e836',NULL,NULL,NULL,NULL),
 ('concept.nextScheduledVisit','5096','The return visit date for a patient concept id','ec878919-7127-4093-8de7-19ca4fe8a0a6',NULL,NULL,NULL,NULL),
 ('concept.none','1107','Concept id of the concept defining the NONE concept','0ee22cd8-8e04-46b3-a0b2-aaba45ebfc81',NULL,NULL,NULL,NULL),
 ('concept.otherNonCoded','5622','Concept id of the concept defining the OTHER NON-CODED concept','69ec3133-cecb-41a1-9593-78f67f90f67a',NULL,NULL,NULL,NULL),
 ('concept.patientDied','1742','Concept id of the concept defining the PATIENT DIED concept','f8ba0328-589c-4039-8085-8efa4cee6fe2',NULL,NULL,NULL,NULL),
 ('concept.problemList','1284','The concept id of the PROBLEM LIST concept.  This concept_id is presumed to be the generic grouping (obr) concept in hl7 messages.  An obs_group row is not created for this concept.','eab88da5-6eea-4298-acda-50b1e5d2116a',NULL,NULL,NULL,NULL),
 ('concept.reasonExitedCare',NULL,'Concept id of the concept defining the REASON EXITED CARE concept','bab80c8d-8a46-40c1-ae75-02b337c78d35',NULL,NULL,NULL,NULL),
 ('concept.reasonOrderStopped','1812','Concept id of the concept defining the REASON ORDER STOPPED concept','e849942c-eafd-42e4-b552-9fc6b61d738a',NULL,NULL,NULL,NULL),
 ('concept.true','1','Concept id of the concept defining the TRUE boolean concept','8e135124-d4fd-4174-83f4-f27b3d7df341',NULL,NULL,NULL,NULL),
 ('concept.weight','5089','Concept id of the concept defining the WEIGHT concept','1fd19858-52bd-4e51-9fc9-9aa92214cc11',NULL,NULL,NULL,NULL),
 ('conceptDrug.dosageForm.conceptClasses',NULL,'A comma-separated list of the allowed concept classes for the dosage form field of the concept drug management form.','a44e9ee1-8cf8-4253-b813-2fb9c70e88f6',NULL,NULL,NULL,NULL),
 ('conceptDrug.route.conceptClasses',NULL,'A comma-separated list of the allowed concept classes for the route field of the concept drug management form.','16eed6ec-7b39-4a6d-93b9-62a767f593d9',NULL,NULL,NULL,NULL),
 ('concepts.locked','false','if true, do not allow editing concepts','d193459d-8bc4-4a6f-989b-5ae170fc1270','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('concept_map_type_management.enable','false','Enables or disables management of concept map types','037e9651-bcd1-4a5d-b41b-bea29d351daa','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('dashboard.encounters.maximumNumberToShow',NULL,'An integer which, if specified, would determine the maximum number of encounters to display on the encounter tab of the patient dashboard.','e54a4ca8-beb5-4c1f-9bd5-21f4738227fa',NULL,NULL,NULL,NULL),
 ('dashboard.encounters.providerDisplayRoles',NULL,'A comma-separated list of encounter roles (by name or id). Providers with these roles in an encounter will be displayed on the encounter tab of the patient dashboard.','980d5c10-3b1e-4fd0-aa13-0853f06eb2e5',NULL,NULL,NULL,NULL),
 ('dashboard.encounters.showEditLink','true','true/false whether or not to show the \'Edit Encounter\' link on the patient dashboard','e2ad5a35-eecb-40cf-9e03-e5a45b1e4712','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('dashboard.encounters.showEmptyFields','true','true/false whether or not to show empty fields on the \'View Encounter\' window','2c3fa608-bffc-484d-bbbb-4774ba439163','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('dashboard.encounters.showViewLink','true','true/false whether or not to show the \'View Encounter\' link on the patient dashboard','234d15ab-ab4e-4324-b4f5-718024b87a92','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('dashboard.encounters.usePages','smart','true/false/smart on how to show the pages on the \'View Encounter\' window.  \'smart\' means that if > 50% of the fields have page numbers defined, show data in pages','6c83848e-80d7-4c59-a5d2-6faf098cf074',NULL,NULL,NULL,NULL),
 ('dashboard.header.programs_to_show',NULL,'List of programs to show Enrollment details of in the patient header. (Should be an ordered comma-separated list of program_ids or names.)','0882dab5-48b6-4605-b3d1-3db986a4ac51',NULL,NULL,NULL,NULL),
 ('dashboard.header.workflows_to_show',NULL,'List of programs to show Enrollment details of in the patient header. List of workflows to show current status of in the patient header. These will only be displayed if they belong to a program listed above. (Should be a comma-separated list of program_workflow_ids.)','0eaf73e9-4563-4915-80ed-e0e4d45a0ad5',NULL,NULL,NULL,NULL),
 ('dashboard.overview.showConcepts',NULL,'Comma delimited list of concepts ids to show on the patient dashboard overview tab','c75a7dd4-b4bd-4bb8-8333-94a8318ee98b',NULL,NULL,NULL,NULL),
 ('dashboard.regimen.displayDrugSetIds','ANTIRETROVIRAL DRUGS,TUBERCULOSIS TREATMENT DRUGS','Drug sets that appear on the Patient Dashboard Regimen tab. Comma separated list of name of concepts that are defined as drug sets.','9322e9b6-6978-4104-9e67-c9139c65a4ae',NULL,NULL,NULL,NULL),
 ('dashboard.regimen.displayFrequencies','7 days/week,6 days/week,5 days/week,4 days/week,3 days/week,2 days/week,1 days/week','Frequency of a drug order that appear on the Patient Dashboard. Comma separated list of name of concepts that are defined as drug frequencies.','438c5cb6-e535-421f-ac6a-66683097ddc6',NULL,NULL,NULL,NULL),
 ('dashboard.regimen.standardRegimens','<list>  <regimenSuggestion>    <drugComponents>      <drugSuggestion>        <drugId>2</drugId>        <dose>1</dose>        <units>tab(s)</units>        <frequency>2/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>    </drugComponents>    <displayName>3TC + d4T(30) + NVP (Triomune-30)</displayName>    <codeName>standardTri30</codeName>    <canReplace>ANTIRETROVIRAL DRUGS</canReplace>  </regimenSuggestion>  <regimenSuggestion>    <drugComponents>      <drugSuggestion>        <drugId>3</drugId>        <dose>1</dose>        <units>tab(s)</units>        <frequency>2/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>    </drugComponents>    <displayName>3TC + d4T(40) + NVP (Triomune-40)</displayName>    <codeName>standardTri40</codeName>    <canReplace>ANTIRETROVIRAL DRUGS</canReplace>  </regimenSuggestion>  <regimenSuggestion>    <drugComponents>      <drugSuggestion>        <drugId>39</drugId>        <dose>1</dose>        <units>tab(s)</units>        <frequency>2/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>      <drugSuggestion>        <drugId>22</drugId>        <dose>200</dose>        <units>mg</units>        <frequency>2/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>    </drugComponents>    <displayName>AZT + 3TC + NVP</displayName>    <codeName>standardAztNvp</codeName>    <canReplace>ANTIRETROVIRAL DRUGS</canReplace>  </regimenSuggestion>  <regimenSuggestion>    <drugComponents>      <drugSuggestion reference=\"../../../regimenSuggestion[3]/drugComponents/drugSuggestion\"/>      <drugSuggestion>        <drugId>11</drugId>        <dose>600</dose>        <units>mg</units>        <frequency>1/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>    </drugComponents>    <displayName>AZT + 3TC + EFV(600)</displayName>    <codeName>standardAztEfv</codeName>    <canReplace>ANTIRETROVIRAL DRUGS</canReplace>  </regimenSuggestion>  <regimenSuggestion>    <drugComponents>      <drugSuggestion>        <drugId>5</drugId>        <dose>30</dose>        <units>mg</units>        <frequency>2/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>      <drugSuggestion>        <drugId>42</drugId>        <dose>150</dose>        		<units>mg</units>        <frequency>2/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>      <drugSuggestion reference=\"../../../regimenSuggestion[4]/drugComponents/drugSuggestion[2]\"/>    </drugComponents>    <displayName>d4T(30) + 3TC + EFV(600)</displayName>    <codeName>standardD4t30Efv</codeName>    <canReplace>ANTIRETROVIRAL DRUGS</canReplace>  </regimenSuggestion>  <regimenSuggestion>    <drugComponents>      <drugSuggestion>        <drugId>6</drugId>        <dose>40</dose>        <units>mg</units>        <frequency>2/day x 7 days/week</frequency>        <instructions></instructions>      </drugSuggestion>      <drugSuggestion reference=\"../../../regimenSuggestion[5]/drugComponents/drugSuggestion[2]\"/>      <drugSuggestion reference=\"../../../regimenSuggestion[4]/drugComponents/drugSuggestion[2]\"/>    </drugComponents>    <displayName>d4T(40) + 3TC + EFV(600)</displayName>    <codeName>standardD4t40Efv</codeName>    <canReplace>ANTIRETROVIRAL DRUGS</canReplace>  </regimenSuggestion></list>','XML description of standard drug regimens, to be shown as shortcuts on the dashboard regimen entry tab','23f02f5d-a3b7-4c55-85ef-42f429213a4f',NULL,NULL,NULL,NULL),
 ('dashboard.relationships.show_types',NULL,'Types of relationships separated by commas.  Doctor/Patient,Parent/Child','9d823c08-5d84-46e5-9ad8-44517fd5e2c8',NULL,NULL,NULL,NULL),
 ('dashboard.showPatientName','false','Whether or not to display the patient name in the patient dashboard title. Note that enabling this could be security risk if multiple users operate on the same computer.','fdac0318-4bbe-4c56-8484-2740a472bba0','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('default_locale','en_GB','Specifies the default locale. You can specify both the language code(ISO-639) and the country code(ISO-3166), e.g. \'en_GB\' or just country: e.g. \'en\'','511a3c4b-b506-44ea-be22-e50f42e5ceb3',NULL,NULL,NULL,NULL),
 ('default_location','Unknown Location','The name of the location to use as a system default','e725b933-8848-4ce5-a133-7509758a217b',NULL,NULL,NULL,NULL),
 ('default_theme',NULL,'Default theme for users.  OpenMRS ships with themes of \'green\', \'orange\', \'purple\', and \'legacy\'','4221633c-f533-43c1-a7c0-0b05ce1d2321',NULL,NULL,NULL,NULL),
 ('encounterForm.obsSortOrder','number','The sort order for the obs listed on the encounter edit form.  \'number\' sorts on the associated numbering from the form schema.  \'weight\' sorts on the order displayed in the form schema.','6f1b8368-8446-459b-8289-ac031dcee46f',NULL,NULL,NULL,NULL),
 ('EncounterType.encounterTypes.locked','false','saving, retiring or deleting an Encounter Type is not permitted, if true','cefa1ad6-b99d-4749-b744-d698802a5e91','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('FormEntry.enableDashboardTab','true','true/false whether or not to show a Form Entry tab on the patient dashboard','d863edf5-e829-4c98-97c0-8bda23f437ef','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('FormEntry.enableOnEncounterTab','false','true/false whether or not to show a Enter Form button on the encounters tab of the patient dashboard','60f07c17-c10f-4410-990c-e635f0b423c3','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('graph.color.absolute','rgb(20,20,20)','Color of the \'invalid\' section of numeric graphs on the patient dashboard.','67943709-feaf-462c-b92e-5408999ea15a',NULL,NULL,NULL,NULL),
 ('graph.color.critical','rgb(200,0,0)','Color of the \'critical\' section of numeric graphs on the patient dashboard.','a4ccf869-3144-46d3-a909-b74c610ca9c8',NULL,NULL,NULL,NULL),
 ('graph.color.normal','rgb(255,126,0)','Color of the \'normal\' section of numeric graphs on the patient dashboard.','fa00dc78-bc70-4f1b-95b5-2ad09619fd6a',NULL,NULL,NULL,NULL),
 ('groovy.database_version','1.0.1','DO NOT MODIFY.  Current database version number for the groovy module.','8e8d6791-a15b-4591-b7a8-94c1e2edc89b',NULL,NULL,NULL,NULL),
 ('groovy.mandatory','false','true/false whether or not the groovy module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','66d18767-425f-4bfa-823e-f6acc7c7aaa1',NULL,NULL,NULL,NULL),
 ('groovy.started','false','DO NOT MODIFY. true/false whether or not the groovy module has been started.  This is used to make sure modules that were running  prior to a restart are started again','fffa6c78-ee41-436d-a005-a84ede4bc39a',NULL,NULL,NULL,NULL),
 ('gzip.enabled','false','Set to \'true\' to turn on OpenMRS\'s gzip filter, and have the webapp compress data before sending it to any client that supports it. Generally use this if you are running Tomcat standalone. If you are running Tomcat behind Apache, then you\'d want to use Apache to do gzip compression.','c57010d3-0c0e-4d2e-9684-952badde6f02','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('hieproviderhelper.mandatory','false','true/false whether or not the hieproviderhelper module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','6a649489-f50d-4930-adf8-73e897ea2846',NULL,NULL,NULL,NULL),
 ('hieproviderhelper.started','true','DO NOT MODIFY. true/false whether or not the hieproviderhelper module has been started.  This is used to make sure modules that were running  prior to a restart are started again','dbde14cf-066c-4495-bb92-513e00099974',NULL,NULL,NULL,NULL),
 ('hl7query.mandatory','false','true/false whether or not the hl7query module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','d8b7293b-380c-48b4-8178-ca46337517d3',NULL,NULL,NULL,NULL),
 ('hl7query.messageFacility',NULL,'This is the value sent in MSH-6.','e118b559-0cb2-4648-8144-5c7141f5dd61',NULL,NULL,NULL,NULL),
 ('hl7query.messageInternationalizationCode','RWA','This is the value sent in MSH-12.2.','a341104e-41aa-4f67-82b0-4dc488f34ac5',NULL,NULL,NULL,NULL),
 ('hl7query.messageProcessingId','D','This is the value sent in MSH-11.1.','4a08e562-a795-4851-95c7-0e86279b7828',NULL,NULL,NULL,NULL),
 ('hl7query.messageProcessingMode','C','This is the value sent in MSH-11.2.','3ed5975b-2741-44e0-bfbd-39f643b346ef',NULL,NULL,NULL,NULL),
 ('hl7query.messageProfile','CLSM_V0.83','This is the value sent in MSH-21.','162d790a-f9e1-4c7f-b7b5-5aca7f0e139c',NULL,NULL,NULL,NULL),
 ('hl7query.messageSource','OPENMRS','This is the value sent in MSH-4.','9d1f4cc3-8af2-4b4b-be55-9fcf3f874132',NULL,NULL,NULL,NULL),
 ('hl7query.messageType','ORU_R01','This is the value sent in MSH-9.','20694612-2084-4beb-8eef-e85b348c4f7f',NULL,NULL,NULL,NULL),
 ('hl7query.messageVersion','2.5','This is the value sent in MSH-12.1.','e2849a9e-14ce-4e18-8a76-12a87a6b59cb',NULL,NULL,NULL,NULL),
 ('hl7query.ORUR01Template','Generic ORUR01','The default ORUR01 template to use to create the hl7 messages','66041067-1bab-4b8f-9fd6-3156605aa287',NULL,NULL,NULL,NULL),
 ('hl7query.started','true','DO NOT MODIFY. true/false whether or not the hl7query module has been started.  This is used to make sure modules that were running  prior to a restart are started again','626e1c69-3979-49f4-aa6d-d3c13ebd57be',NULL,NULL,NULL,NULL),
 ('hl7_archive.dir','hl7_archives','The default name or absolute path for the folder where to write the hl7_in_archives.','b2bfd63b-67e4-4146-b8bb-17086757e917',NULL,NULL,NULL,NULL),
 ('hl7_processor.ignore_missing_patient_non_local','false','If true, hl7 messages for patients that are not found and are non-local will silently be dropped/ignored','84487585-79a9-42e0-88a8-0e6d661cc423','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('htmlformentry.database_version','1.2.0','DO NOT MODIFY.  Current database version number for the htmlformentry module.','8183a2f0-c9a9-40f5-a396-50615ff04d9f',NULL,NULL,NULL,NULL),
 ('htmlformentry.dateFormat',NULL,'Always display dates in HTML Forms in this (Java) date format. E.g. \"dd/MMM/yyyy\" for 31/Jan/2012.','9db5aa8c-7840-46ff-8ec2-1aa573f8ef50',NULL,NULL,NULL,NULL),
 ('htmlformentry.mandatory','false','true/false whether or not the htmlformentry module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','656b7882-1216-4071-b062-13ead3b93c5a',NULL,NULL,NULL,NULL),
 ('htmlformentry.showDateFormat','true','Set to true if you want static text for the date format to be displayed next to date widgets, else set to false.','44bf49b8-4453-4bdb-ba61-35e1207d693c',NULL,NULL,NULL,NULL),
 ('htmlformentry.started','true','DO NOT MODIFY. true/false whether or not the htmlformentry module has been started.  This is used to make sure modules that were running  prior to a restart are started again','e38dcdae-fda7-4214-a29c-56afe7f0211d',NULL,NULL,NULL,NULL),
 ('htmlformentry19ext.mandatory','false','true/false whether or not the htmlformentry19ext module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','fa2afb21-2c70-4cb3-9f78-78a4657beb89',NULL,NULL,NULL,NULL),
 ('htmlformentry19ext.started','true','DO NOT MODIFY. true/false whether or not the htmlformentry19ext module has been started.  This is used to make sure modules that were running  prior to a restart are started again','edfd33bc-e731-4141-8612-c944e165d284',NULL,NULL,NULL,NULL),
 ('htmlwidgets.mandatory','false','true/false whether or not the htmlwidgets module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','835518e0-6f6b-4559-ae2b-1b5c830b2deb',NULL,NULL,NULL,NULL),
 ('htmlwidgets.started','true','DO NOT MODIFY. true/false whether or not the htmlwidgets module has been started.  This is used to make sure modules that were running  prior to a restart are started again','7c7b90ce-2535-4966-9275-18f5040057e7',NULL,NULL,NULL,NULL),
 ('idgen.database_version','2.4.1','DO NOT MODIFY.  Current database version number for the idgen module.','6b46340c-2dd4-4a1c-a02a-1a52453d67c0',NULL,NULL,NULL,NULL),
 ('idgen.mandatory','false','true/false whether or not the idgen module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','5cc4634d-0504-482c-9e20-7d4ae13304b8',NULL,NULL,NULL,NULL),
 ('idgen.started','true','DO NOT MODIFY. true/false whether or not the idgen module has been started.  This is used to make sure modules that were running  prior to a restart are started again','7c1476ec-486b-4fe0-a6bb-2a5f856e905f',NULL,NULL,NULL,NULL),
 ('layout.address.format','<org.openmrs.layout.web.address.AddressTemplate>\r\n    <nameMappings class=\"properties\">\r\n      <property name=\"postalCode\" value=\"Location.postalCode\"/>\r\n      <property name=\"longitude\" value=\"Location.longitude\"/>\r\n      <property name=\"address2\" value=\"Location.address2\"/>\r\n      <property name=\"address1\" value=\"Location.address1\"/>\r\n      <property name=\"startDate\" value=\"PersonAddress.startDate\"/>\r\n      <property name=\"country\" value=\"Location.country\"/>\r\n      <property name=\"endDate\" value=\"personAddress.endDate\"/>\r\n      <property name=\"stateProvince\" value=\"Location.stateProvince\"/>\r\n      <property name=\"latitude\" value=\"Location.latitude\"/>\r\n      <property name=\"cityVillage\" value=\"Location.cityVillage\"/>\r\n    </nameMappings>\r\n    <sizeMappings class=\"properties\">\r\n      <property name=\"postalCode\" value=\"10\"/>\r\n      <property name=\"longitude\" value=\"10\"/>\r\n      <property name=\"address2\" value=\"40\"/>\r\n      <property name=\"address1\" value=\"40\"/>\r\n      <property name=\"startDate\" value=\"10\"/>\r\n      <property name=\"country\" value=\"10\"/>\r\n      <property name=\"endDate\" value=\"10\"/>\r\n      <property name=\"stateProvince\" value=\"10\"/>\r\n      <property name=\"latitude\" value=\"10\"/>\r\n      <property name=\"cityVillage\" value=\"10\"/>\r\n    </sizeMappings>\r\n    <lineByLineFormat>\r\n      <string>address1</string>\r\n      <string>address2</string>\r\n      <string>cityVillage stateProvince country postalCode</string>\r\n      <string>latitude longitude</string>\r\n      <string>startDate endDate</string>\r\n    </lineByLineFormat>\r\n  </org.openmrs.layout.web.address.AddressTemplate>','XML description of address formats','a56a16c6-c30b-42cc-bd8f-9a7536f8f793',NULL,NULL,NULL,NULL),
 ('layout.name.format','short','Format in which to display the person names.  Valid values are short, long','35fb2507-b406-44fe-ae3f-e9a8bfb3a667',NULL,NULL,NULL,NULL),
 ('locale.allowed.list','en, es, fr, it, pt','Comma delimited list of locales allowed for use on system','a54a9ae6-b634-478b-8eb9-45daf335c606',NULL,NULL,NULL,NULL),
 ('location.field.style','default','Type of widget to use for location fields','7066d5d4-b863-450b-9254-04d8b0dfc819',NULL,NULL,NULL,NULL),
 ('log.layout','%p - %C{1}.%M(%L) |%d{ISO8601}| %m%n','A log layout pattern which is used by the OpenMRS file appender.','0e618cb8-6728-4f27-af2f-b42356b7fb8d',NULL,NULL,NULL,NULL),
 ('log.level','org.openmrs.api:info','Logging levels for log4j.xml. Valid format is class:level,class:level. If class not specified, \'org.openmrs.api\' presumed. Valid levels are trace, debug, info, warn, error or fatal','6c3f5ae6-d74c-4a19-9e4c-400e6bc051b4',NULL,NULL,NULL,NULL),
 ('log.location',NULL,'A directory where the OpenMRS log file appender is stored. The log file name is \'openmrs.log\'.','547e486f-9e76-461d-a8e6-f3b2d9621c65',NULL,NULL,NULL,NULL),
 ('logic.default.ruleClassDirectory','logic/class','Default folder where compiled rule will be stored','1440126f-3b0f-4e07-93cf-1aceca339001',NULL,NULL,NULL,NULL),
 ('logic.default.ruleJavaDirectory','logic/sources','Default folder where rule\'s java file will be stored','70e13d09-be77-48e5-8198-06dbbbc26d3a',NULL,NULL,NULL,NULL),
 ('logic.defaultTokens.conceptClasses',NULL,'When registering default tokens for logic, if you specify a comma-separated list of concept class names here, only concepts of those classes will have tokens registered. If you leave this blank, all classes will have tokens registered for their concepts.','2c7ac740-99cd-42de-ac72-3d279de59ed8',NULL,NULL,NULL,NULL),
 ('logic.mandatory','false','true/false whether or not the logic module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','78a072a7-9de0-4491-994f-8885258d23ec',NULL,NULL,NULL,NULL),
 ('logic.started','true','DO NOT MODIFY. true/false whether or not the logic module has been started.  This is used to make sure modules that were running  prior to a restart are started again','315950c0-e8c9-4c4b-b155-07c29f6b9024',NULL,NULL,NULL,NULL),
 ('mail.debug','false','true/false whether to print debugging information during mailing','7daf31ae-944c-4c16-a65d-68fa4bb2a92d',NULL,NULL,NULL,NULL),
 ('mail.default_content_type','text/plain','Content type to append to the mail messages','103695f0-b9ba-4bc2-8a26-dc7a11e55038',NULL,NULL,NULL,NULL),
 ('mail.from','info@openmrs.org','Email address to use as the default from address','1a9e07a2-0af0-4809-8757-fd3812dc784c',NULL,NULL,NULL,NULL),
 ('mail.password','test','Password for the SMTP user (if smtp_auth is enabled)','288e1775-f5f5-49e4-af29-464727194ad3',NULL,NULL,NULL,NULL),
 ('mail.smtp_auth','false','true/false whether the smtp host requires authentication','e9668305-8f6c-4dcc-9415-df268c3216de',NULL,NULL,NULL,NULL),
 ('mail.smtp_host','localhost','SMTP host name','b54a4e24-125e-40ca-9678-f1cfc46a4c20',NULL,NULL,NULL,NULL),
 ('mail.smtp_port','25','SMTP port','badf8db8-1a84-4a00-a1a6-094a3cd9eb59',NULL,NULL,NULL,NULL),
 ('mail.transport_protocol','smtp','Transport protocol for the messaging engine. Valid values: smtp','dd607517-1a0b-4688-ae7b-a4644b955e50',NULL,NULL,NULL,NULL),
 ('mail.user','test','Username of the SMTP user (if smtp_auth is enabled)','2e4bab54-d986-45d2-8482-2b90cbb8d01e',NULL,NULL,NULL,NULL),
 ('minSearchCharacters','3','Number of characters user must input before searching is started.','ebb46fb5-c903-4602-ba9f-8a5d897184b5',NULL,NULL,NULL,NULL),
 ('module_repository_folder','modules','Name of the folder in which to store the modules','92038e81-ad94-4532-ac2d-9ee1172244ca',NULL,NULL,NULL,NULL),
 ('newPatientForm.relationships',NULL,'Comma separated list of the RelationshipTypes to show on the new/short patient form.  The list is defined like \'3a, 4b, 7a\'.  The number is the RelationshipTypeId and the \'a\' vs \'b\' part is which side of the relationship is filled in by the user.','f94dc3c2-8913-4d5c-9e67-5c66ec842b1b',NULL,NULL,NULL,NULL),
 ('new_patient_form.showRelationships','false','true/false whether or not to show the relationship editor on the addPatient.htm screen','f17e338e-8d69-4b59-8607-3e47102210b9','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('obs.complex_obs_dir','complex_obs','Default directory for storing complex obs.','a2a1052e-adb2-4e8d-9cac-68ee6610108a',NULL,NULL,NULL,NULL),
 ('patient.defaultPatientIdentifierValidator','org.openmrs.patient.impl.LuhnIdentifierValidator','This property sets the default patient identifier validator.  The default validator is only used in a handful of (mostly legacy) instances.  For example, it\'s used to generate the isValidCheckDigit calculated column and to append the string \"(default)\" to the name of the default validator on the editPatientIdentifierType form.','9dfc0f70-e233-460f-949d-6dd6ea4f1c2b',NULL,NULL,NULL,NULL),
 ('patient.headerAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that will be shown on the patient dashboard','a08f9ac5-51ca-4141-813f-416056b50979',NULL,NULL,NULL,NULL),
 ('patient.identifierPrefix',NULL,'This property is only used if patient.identifierRegex is empty.  The string here is prepended to the sql indentifier search string.  The sql becomes \"... where identifier like \'<PREFIX><QUERY STRING><SUFFIX>\';\".  Typically this value is either a percent sign (%) or empty.','3cad29ce-0b3b-491d-ab50-0c46d514758e',NULL,NULL,NULL,NULL),
 ('patient.identifierRegex',NULL,'WARNING: Using this search property can cause a drop in mysql performance with large patient sets.  A MySQL regular expression for the patient identifier search strings.  The @SEARCH@ string is replaced at runtime with the user\'s search string.  An empty regex will cause a simply \'like\' sql search to be used. Example: ^0*@SEARCH@([A-Z]+-[0-9])?$','398c6001-0591-46c9-a250-ca477698e795',NULL,NULL,NULL,NULL),
 ('patient.identifierSearchPattern',NULL,'If this is empty, the regex or suffix/prefix search is used.  Comma separated list of identifiers to check.  Allows for faster searching of multiple options rather than the slow regex. e.g. @SEARCH@,0@SEARCH@,@SEARCH-1@-@CHECKDIGIT@,0@SEARCH-1@-@CHECKDIGIT@ would turn a request for \"4127\" into a search for \"in (\'4127\',\'04127\',\'412-7\',\'0412-7\')\"','aa756db0-4d10-4895-bac1-61181780af8d',NULL,NULL,NULL,NULL),
 ('patient.identifierSuffix',NULL,'This property is only used if patient.identifierRegex is empty.  The string here is prepended to the sql indentifier search string.  The sql becomes \"... where identifier like \'<PREFIX><QUERY STRING><SUFFIX>\';\".  Typically this value is either a percent sign (%) or empty.','aca1ad85-7920-4ddd-ac00-7cb961755a5f',NULL,NULL,NULL,NULL),
 ('patient.listingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for patients in _lists_','27072a5a-a396-4106-bee6-4f57a1710faa',NULL,NULL,NULL,NULL),
 ('patient.nameValidationRegex','^[a-zA-Z \\-]+$','Names of the patients must pass this regex. Eg : ^[a-zA-Z \\-]+$ contains only english alphabet letters, spaces, and hyphens. A value of .* or the empty string means no validation is done.','56a509a5-4c95-49a5-8f89-bb8d63880d6a',NULL,NULL,NULL,NULL),
 ('patient.viewingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for patients when _viewing individually_','d49783c4-445e-4b36-ba8b-44725addaea3',NULL,NULL,NULL,NULL),
 ('patientflags.database_version','1.2.10','DO NOT MODIFY.  Current database version number for the patientflags module.','42534137-8f6d-4a92-9dce-eeafc4347b28',NULL,NULL,NULL,NULL),
 ('patientflags.mandatory','false','true/false whether or not the patientflags module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','29249146-bff3-47ee-bdd2-2b4407de3684',NULL,NULL,NULL,NULL),
 ('patientflags.patientHeaderDisplay','true','DO NOT MODIFY HERE: use \"manage flag global properties\" to modify; true/false whether or not to display flags in the Patient Dashboard overview','e55e8adb-b586-4a14-9ce6-2a5580b188c4',NULL,NULL,NULL,NULL),
 ('patientflags.patientOverviewDisplay','true','DO NOT MODIFY HERE: use \"manage flag global properties\" to modify; true/false whether or not to display flags in the Patient Dashboard header','c65e6e09-998c-49d2-a8ff-06d768c3f092',NULL,NULL,NULL,NULL),
 ('patientflags.started','true','DO NOT MODIFY. true/false whether or not the patientflags module has been started.  This is used to make sure modules that were running  prior to a restart are started again','cb178081-e5a4-4487-8c20-fcfea2429f92',NULL,NULL,NULL,NULL),
 ('patientflags.username','admin','DO NOT MODIFY HERE: user \"manage flag global properties\" to modify; Username for the OpenMRS user that will evaluate Groovy flags','297505a7-99af-493d-b070-d97fbcbea8ef',NULL,NULL,NULL,NULL),
 ('patientSearch.matchMode','START','Specifies how patient names are matched while searching patient. Valid values are \'ANYWHERE\' or \'START\'. Defaults to start if missing or invalid value is present.','51e01336-b8ed-490e-b1e1-874c8b0f30db',NULL,NULL,NULL,NULL),
 ('patient_identifier.importantTypes',NULL,'A comma delimited list of PatientIdentifier names : PatientIdentifier locations that will be displayed on the patient dashboard.  E.g.: TRACnet ID:Rwanda,ELDID:Kenya','c4123371-20ef-42e4-9381-ed75087d1747',NULL,NULL,NULL,NULL),
 ('person.searchMaxResults','1000','The maximum number of results returned by patient searches','0a69feb9-ed9b-42e5-8651-c64296dd1d2f',NULL,NULL,NULL,NULL),
 ('RegenstriefHl7Adapter.conceptDictionaryCode',NULL,'The default conceptDictionaryCode to be used','58bb0efb-253c-4a67-9fd1-7ef7dadffd17',NULL,NULL,NULL,NULL),
 ('RegenstriefHl7Adapter.database_version','1.0.1','DO NOT MODIFY.  Current database version number for the RegenstriefHl7Adapter module.','07f0e342-1915-4025-b189-36b91a2fecbf',NULL,NULL,NULL,NULL),
 ('RegenstriefHl7Adapter.encounterType.name',NULL,'The default encounterType.name to be used','2558db7d-f532-4ffb-8dee-616bf850220a',NULL,NULL,NULL,NULL),
 ('RegenstriefHl7Adapter.mandatory','false','true/false whether or not the RegenstriefHl7Adapter module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','65f1d44b-6ce8-46e8-917d-b870f84ee9f0',NULL,NULL,NULL,NULL),
 ('RegenstriefHl7Adapter.StandardCodes',NULL,'The standard conceptDictionaryCode to be used','7d0f64ce-5a9d-4405-872f-35f44ecfbbef',NULL,NULL,NULL,NULL),
 ('RegenstriefHl7Adapter.started','true','DO NOT MODIFY. true/false whether or not the RegenstriefHl7Adapter module has been started.  This is used to make sure modules that were running  prior to a restart are started again','b0e9b290-67cc-4681-a2be-ed7555fe6c1f',NULL,NULL,NULL,NULL),
 ('registration.allowBackEntry','false','If set to true this will allow the clerk to back enter registration data for previous days.','f57d4dba-c959-475c-895d-ca8d6fc19b81',NULL,NULL,NULL,NULL),
 ('registration.backEntryLimit','14','The number of days allowable to back enter registration data','6aa33e7d-3d8f-4208-bf47-0014f68fa198',NULL,NULL,NULL,NULL),
 ('registration.barCodeCount','4','The number of barcodes to print at a time, when printing barcodes.','e8f037df-4497-4f35-88ca-1a88dee2673a',NULL,NULL,NULL,NULL),
 ('registration.defaultLocationCode','416','The MOH 3-digit numeric code for the location of this health center.  NO VALUE THAT YOU ENTER HERE SHOULD BE DUPLICATED ACROSS MULTIPLE SERVERS.','f13176b0-eb60-4f6e-a446-a700f6f32d91',NULL,NULL,NULL,NULL),
 ('registration.healthCenterPersonAttribute','Health Center','The name of the person attribute type to use for the health center for a patient.','a3a56b87-6fb6-4883-b7da-8ce8ba109590',NULL,NULL,NULL,NULL),
 ('registration.insuranceNumberConcept',NULL,'The conceptID for insurance number','8245d08e-efb4-4626-8dfe-de62b6b59077',NULL,NULL,NULL,NULL),
 ('registration.insuranceTypeConcept',NULL,'The conceptID for insurance type','2b619092-138b-49df-9c17-fd9726e97dc8',NULL,NULL,NULL,NULL),
 ('registration.insuranceTypeConceptAnswers',NULL,'A list of the concept answers in the order that you\'d like to see them for insuranceTypeConcept.  comma delimited','b651d8f1-af4b-499e-b291-4231be4cce95',NULL,NULL,NULL,NULL),
 ('registration.maxRecentlyViewed','30','The max length of the list on the touchscreen homepage or recently viewed patients.','9eda84d6-65a3-4333-821c-4ce21b7f9cc3',NULL,NULL,NULL,NULL),
 ('registration.mutuellePersonAttribute','Tipo de Participante','The name of the person attribute type to use for the mutuelle number for a patient.  If null, mutuelle isn\'t asked by the application.','d1554bfe-c36c-4d6c-bf90-c171a01ca07d',NULL,NULL,NULL,NULL),
 ('registration.nationalIdType','Old Identification Number','The name of the patient identifier type to use for the national ID number.  If null, national ID isn\'t asked by the application.','db1c6576-e82a-4164-827a-6b65d5c1ebe0',NULL,NULL,NULL,NULL),
 ('registration.otherIdentifierTypes',NULL,'Optionally other patient identifier types that should can be searched on and displayed\r\non the patient page. This should be a comma-separated list of patient identifier ids.','29ebe843-ddf2-4914-a4af-3e93dc1408aa',NULL,NULL,NULL,NULL),
 ('registration.overrideHealthCenterAttribute','true','If set to true this will cause the health center attribute for the patient to be overwritten with the location of the registration visit','8d509ad8-01c0-4f44-814c-ad17d0396109',NULL,NULL,NULL,NULL),
 ('registration.parentChildRelationshipTypeId',NULL,'The integer value of the parent to child relationship type id.','0abf26ee-370b-4f80-8576-a2356f30abd1',NULL,NULL,NULL,NULL),
 ('registration.primaryIdentifierType',NULL,'Must be the ID of a Patient Identifier Type. Newly created patients will\r\nhave an identifier of this type added to them.','cfcb3653-37f5-42a8-a6f6-7504c2ba2ff4',NULL,NULL,NULL,NULL),
 ('registration.restrictSearchByHealthCenter','true','When searching for a patient by name, restrict the results to only patients for whom their \r\nhealth center is the location of the person using the touch-screen system.','9442113a-4edf-4512-9135-d948a43de707',NULL,NULL,NULL,NULL),
 ('registration.rwandaLocationCodes',NULL,'location_Name:MOH_ID pairs.  All pairs are pipe delimited.  NO VALUE THAT YOU ENTER HERE SHOULD BE DUPLICATED ACROSS MULTIPLE SERVERS.','81c4d136-4495-4ac7-b91b-62415560968c',NULL,NULL,NULL,NULL),
 ('registration.serviceRequestedConcept',NULL,'The conceptId for the services that a patient can come to the registration desk for.','6c434bdb-b8e7-4140-b43d-5a41e9066001',NULL,NULL,NULL,NULL),
 ('registration.showDiagnosisLink','false','If set to true buttons directing to the Diagnosis Capture module will be displayed','0f66ae89-3760-43ee-8769-7d9f110e6cba',NULL,NULL,NULL,NULL),
 ('report.deleteReportsAgeInHours','72','Reports that are not explicitly saved are deleted automatically when they are this many hours old. (Values less than or equal to zero means do not delete automatically)','63e49415-5185-49ed-8679-dc71eeb37283',NULL,NULL,NULL,NULL),
 ('report.xmlMacros',NULL,'Macros that will be applied to Report Schema XMLs when they are interpreted. This should be java.util.properties format.','bad0eaf9-2756-4fd8-a31d-615e8c9cf636',NULL,NULL,NULL,NULL),
 ('reporting.database_version','0.5','DO NOT MODIFY.  Current database version number for the reporting module.','70e64e02-b348-49d8-86f2-b6226e0134e5',NULL,NULL,NULL,NULL),
 ('reporting.includeDataExportsAsDataSetDefinitions','false','If reportingcompatibility is installed, this indicates whether data exports should be exposed as Dataset Definitions','f576f998-4750-49c8-a0c6-0f6de925d613',NULL,NULL,NULL,NULL),
 ('reporting.mandatory','false','true/false whether or not the reporting module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','68fa7fc1-63b9-4954-abaf-80096f68618c',NULL,NULL,NULL,NULL),
 ('reporting.maxCachedReports','10','The maximum number of reports whose underlying data and output should be kept in the cache at any one time','ecb0ddf6-244e-433f-862d-5b437654d3bd',NULL,NULL,NULL,NULL),
 ('reporting.maxReportsToRun','1','The maximum number of reports that should be processed at any one time','de1203c7-a273-4b4b-8889-18c754dff908',NULL,NULL,NULL,NULL),
 ('reporting.preferredIdentifierTypes',NULL,'Pipe-separated list of patient identifier type names, which should be displayed on default patient datasets','020c2f1a-30e2-40ea-b1ca-6ff931543898',NULL,NULL,NULL,NULL),
 ('reporting.runReportCohortFilterMode','showIfNull','Supports the values hide,showIfNull,show which determine whether the cohort selector should be available in the run report page','dcf9a29e-9f4d-4c31-836b-dbe32cb9725d',NULL,NULL,NULL,NULL),
 ('reporting.started','false','DO NOT MODIFY. true/false whether or not the reporting module has been started.  This is used to make sure modules that were running  prior to a restart are started again','2cc714cc-ee2d-4095-b8bd-9e0b71b2430a',NULL,NULL,NULL,NULL),
 ('reportingcompatibility.data_export_batch_size','7500','The number of patients to export at a time in a data export.  The larger this number the faster and more memory that is used.  The smaller this number the slower and less memory is used.','9d52bde0-9841-4224-82f0-09841ea7bd73',NULL,NULL,NULL,NULL),
 ('reportingcompatibility.mandatory','false','true/false whether or not the reportingcompatibility module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','c950f3a5-d69f-4a02-8837-530ca2a8e0cb',NULL,NULL,NULL,NULL),
 ('reportingcompatibility.patientLinkUrl','patientDashboard.form','The link url for a particular patient to view from the cohort builder','b0b13756-ab8c-45b2-9bd2-77cc9f09b689',NULL,NULL,NULL,NULL),
 ('reportingcompatibility.started','false','DO NOT MODIFY. true/false whether or not the reportingcompatibility module has been started.  This is used to make sure modules that were running  prior to a restart are started again','45db6467-06d4-4eea-9153-541489df76d8',NULL,NULL,NULL,NULL),
 ('reportProblem.url','http://errors.openmrs.org/scrap','The openmrs url where to submit bug reports','5909a4b5-be9b-4d4d-8382-1de295e907de',NULL,NULL,NULL,NULL),
 ('rheashradapter.database_version','1.0.5','DO NOT MODIFY.  Current database version number for the rheashradapter module.','29a79114-f1ad-486b-8394-f49d0f900b24',NULL,NULL,NULL,NULL),
 ('rheashradapter.encounterrole.uuid','27822cae-4b50-42ca-9c45-8cb0e637ce09','The uuid of the EncounterRole object used to persist RHEA encounters','e66da999-e058-45ef-b09f-d8bfef907c8e',NULL,NULL,NULL,NULL),
 ('rheashradapter.hie.password','2BAi3SyKVe9J','The password to send reminders to the Interopability layer','4219c90f-ca5c-47e8-9a90-364bb2d41dad',NULL,NULL,NULL,NULL),
 ('rheashradapter.hie.url','https://41.74.172.115:5000/','The url to send reminders to the Interopability layer','1f5b6b9c-7645-41a0-acf0-f428baacb7f7',NULL,NULL,NULL,NULL),
 ('rheashradapter.hie.username','rhea','The username to send reminders to the Interopability layer','54b91a56-ce7c-42a8-9594-92e237f31556',NULL,NULL,NULL,NULL),
 ('rheashradapter.keystore.password',NULL,'The keystore password used to post to the HIE','53a2734b-109f-490d-852c-7d9ee8db832a',NULL,NULL,NULL,NULL),
 ('rheashradapter.mandatory','false','true/false whether or not the rheashradapter module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','5b0243d8-7f4f-4336-af8e-f7d81238c1fc',NULL,NULL,NULL,NULL),
 ('rheashradapter.sendingFaculty',NULL,'The sending faculty value which represents the implementation','e101bafd-8d6b-4b79-baf9-27a10a142f51',NULL,NULL,NULL,NULL),
 ('rheashradapter.started','true','DO NOT MODIFY. true/false whether or not the rheashradapter module has been started.  This is used to make sure modules that were running  prior to a restart are started again','1fd4d399-ea91-4ee8-bb43-3435f89a3e2c',NULL,NULL,NULL,NULL),
 ('rheashrcorrector.mandatory','false','true/false whether or not the rheashrcorrector module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','505f6130-f9af-4afb-9482-5a5811d7e005',NULL,NULL,NULL,NULL),
 ('rheashrcorrector.started','true','DO NOT MODIFY. true/false whether or not the rheashrcorrector module has been started.  This is used to make sure modules that were running  prior to a restart are started again','1ea217af-f789-4de4-bed6-6cd517ba7ffe',NULL,NULL,NULL,NULL),
 ('scheduler.password','test','Password for the OpenMRS user that will perform the scheduler activities','de0830a3-8239-4e28-846f-2e71787e9fbc',NULL,NULL,NULL,NULL),
 ('scheduler.username','admin','Username for the OpenMRS user that will perform the scheduler activities','14479a25-710f-468b-bac1-b1123877051b',NULL,NULL,NULL,NULL),
 ('searchWidget.batchSize','200','The maximum number of search results that are returned by an ajax call','e236b95d-cc9a-4039-956d-5db7bfbe50cd',NULL,NULL,NULL,NULL),
 ('searchWidget.maximumResults','2000','Specifies the maximum number of results to return from a single search in the search widgets','ff997cd8-a998-4105-9a99-bf199b550246',NULL,NULL,NULL,NULL),
 ('searchWidget.runInSerialMode','false','Specifies whether the search widgets should make ajax requests in serial or parallel order, a value of true is appropriate for implementations running on a slow network connection and vice versa','39d553d1-9cba-461e-bc3a-cf3722069f54','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('searchWidget.searchDelayInterval','400','Specifies time interval in milliseconds when searching, between keyboard keyup event and triggering the search off, should be higher if most users are slow when typing so as to minimise the load on the server','322a14d8-9c83-414e-921c-c0cfc0228440',NULL,NULL,NULL,NULL),
 ('security.passwordCannotMatchUsername','true','Configure whether passwords must not match user\'s username or system id','3cf6aa5a-1121-4f60-adb9-a87673bcc12d','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('security.passwordCustomRegex',NULL,'Configure a custom regular expression that a password must match','409557a7-b535-47e9-bb15-2a88fe13853c',NULL,NULL,NULL,NULL),
 ('security.passwordMinimumLength','4','Configure the minimum length required of all passwords','2d814822-bfda-4e69-9913-aa538b07cdf4',NULL,NULL,NULL,NULL),
 ('security.passwordRequiresDigit','false','Configure whether passwords must contain at least one digit','6d9a0108-d497-4ae0-8ff2-4fd832fa6c5d','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('security.passwordRequiresNonDigit','true','Configure whether passwords must contain at least one non-digit','05139228-728e-416c-82c0-6903f148be9a','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('security.passwordRequiresUpperAndLowerCase','false','Configure whether passwords must contain both upper and lower case characters','2982b225-eac4-4301-8544-4c721a7233f9','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('serialization.xstream.mandatory','false','true/false whether or not the serialization.xstream module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','2d476fb9-1065-47ae-be6d-6fd94b66ea08',NULL,NULL,NULL,NULL),
 ('serialization.xstream.started','false','DO NOT MODIFY. true/false whether or not the serialization.xstream module has been started.  This is used to make sure modules that were running  prior to a restart are started again','92dfe453-7257-4263-8c12-a9caca9337b5',NULL,NULL,NULL,NULL),
 ('user.headerAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that will be shown on the user dashboard. (not used in v1.5)','6b9b2485-81c9-4cd5-9072-308218ddcfd4',NULL,NULL,NULL,NULL),
 ('user.listingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for users in _lists_','c412e7bd-39a7-4710-8ec8-0390261507ee',NULL,NULL,NULL,NULL),
 ('user.requireEmailAsUsername','false','Indicates whether a username must be a valid e-mail or not.','5fe39c2f-c489-42cd-bf2b-2eb23094ba03','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('user.viewingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for users when _viewing individually_','ed89102f-d79b-4bf6-80f5-5e4bc44d6b8f',NULL,NULL,NULL,NULL),
 ('use_patient_attribute.healthCenter','false','Indicates whether or not the \'health center\' attribute is shown when viewing/searching for patients','6e0ee762-e38f-4c15-93bc-f3daffcb9876','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('use_patient_attribute.mothersName','false','Indicates whether or not mother\'s name is able to be added/viewed for a patient','bbcde914-f615-44a3-a066-808435aa83d4','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('visits.assignmentHandler','org.openmrs.api.handler.ExistingVisitAssignmentHandler','Set to the name of the class responsible for assigning encounters to visits.','0fc8ac16-8dfb-4e0c-a548-1d8bd46dcd42',NULL,NULL,NULL,NULL),
 ('visits.autoCloseVisitType',NULL,'comma-separated list of the visit type(s) to automatically close','c64de995-2412-42ab-a721-1d8f888279e6',NULL,NULL,NULL,NULL),
 ('visits.enabled','true','Set to true to enable the Visits feature. This will replace the \'Encounters\' tab with a \'Visits\' tab on the dashboard.','e1dabc2d-6eb3-4618-860a-3cb7d2788d2f','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL),
 ('visits.encounterTypeToVisitTypeMapping',NULL,'Specifies how encounter types are mapped to visit types when automatically assigning encounters to visits. e.g 1:1, 2:1, 3:2 in the format encounterTypeId:visitTypeId','e8bb6385-8a4d-46ec-b35f-a2c84b75f67f',NULL,NULL,NULL,NULL),
 ('webservices.rest.allowedips',NULL,'A comma-separate list of IP addresses that are allowed to access the web services. An empty string allows everyone to access all ws. \r\n        IPs can be declared with bit masks e.g. 10.0.0.0/30 matches 10.0.0.0 - 10.0.0.3 and 10.0.0.0/24 matches 10.0.0.0 - 10.0.0.255.','fc6a869e-db1b-41ae-99b1-6f8376a0ea46',NULL,NULL,NULL,NULL),
 ('webservices.rest.mandatory','false','true/false whether or not the webservices.rest module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','a8142a4a-4fa8-4814-a080-ed517a4efd06',NULL,NULL,NULL,NULL),
 ('webservices.rest.maxResultsAbsolute','100','The absolute max results limit. If the client requests a larger number of results, then will get an error','e4ef1715-c7e0-4bd2-8542-90692cc02c10',NULL,NULL,NULL,NULL),
 ('webservices.rest.maxResultsDefault','50','The default max results limit if the user does not provide a maximum when making the web service call.','beaa9839-867e-4060-b80e-3c9aa6891806',NULL,NULL,NULL,NULL),
 ('webservices.rest.started','true','DO NOT MODIFY. true/false whether or not the webservices.rest module has been started.  This is used to make sure modules that were running  prior to a restart are started again','cade5010-64d8-4d0e-9a42-c6e4996c8594',NULL,NULL,NULL,NULL),
 ('webservices.rest.uriPrefix',NULL,'The URI prefix through which clients consuming web services will connect to the web application, should be of the form http://{ipAddress}:{port}/{contextPath}','7f6fb53e-9096-4670-a51e-c29cfdbc11b0',NULL,NULL,NULL,NULL),
 ('xforms.allowBindEdit','false','Set to true if you want to allow editing of question bindings when designing forms.','1c4d8225-fa6e-4a2f-84b5-9b58fca84627',NULL,NULL,NULL,NULL),
 ('xforms.archive_dir','xforms/archive/%Y/%M','Directory containing the xforms archive items.  This will contain xform model xml files that have been processed and then submitted successfully into the formentry queue.','23b2eb19-6670-4523-80a2-be4aa4f43bc4',NULL,NULL,NULL,NULL),
 ('xforms.autoGeneratePatientIdentifier','false','Set to true if you want the idgen module to generate patient identifiers when creating new patients using the xforms module.','56c1df3d-7aa7-41c0-9d38-717c1352f119',NULL,NULL,NULL,NULL),
 ('xforms.cohortSerializer','org.openmrs.module.xforms.serialization.DefaultCohortSerializer','The patient cohort (cohort_id and name) serializer','44c2ee50-0044-43e7-8d26-1a06110cb432',NULL,NULL,NULL,NULL),
 ('xforms.complexobs_dir','xforms/complexobs','Directory for storing complex obs used by the xforms module.','76145a82-72ea-4ac2-8482-0dda59bd4823',NULL,NULL,NULL,NULL),
 ('xforms.database_version','3.7.9','DO NOT MODIFY.  Current database version number for the xforms module.','1c048b63-6fab-480f-9aa5-3af4a73e1cbb',NULL,NULL,NULL,NULL),
 ('xforms.dateDisplayFormat','dd/MM/yyyy','The display format of dates used by the xforms module.','93e406c0-ba52-4726-b360-8b5bee19295f',NULL,NULL,NULL,NULL),
 ('xforms.dateSubmitFormat','yyyy-MM-dd','The format of the dates passed in the xml of the xforms model. Please make sure this matches with the date format of your data entry applications, else you will get wrong dates on the server.','b84458cf-4d0c-4440-b779-aa8cf291ed8f',NULL,NULL,NULL,NULL),
 ('xforms.dateTimeDisplayFormat','dd/MM/yyyy hh:mm a','The display format of datetime used by the xforms module.','0d649a7b-98b7-48f4-940d-3ddef8793e4e',NULL,NULL,NULL,NULL),
 ('xforms.dateTimeSubmitFormat','yyyy-MM-dd\'T\'HH:mm:ssZ','The format of the datetime passed in the xml of the xforms model. Please make sure this matches with the date format of your data entry applications, else you will get wrong dates on the server.','7f23aa89-7fe7-4cb1-8a78-e3f7042f191d',NULL,NULL,NULL,NULL),
 ('xforms.decimalSeparators','en:.;fr:.;es:,;it:.;pt:.','The decimal separators for each locale. e.g:  en:.;fr:.;es:,;it:.;pt:.','d1785475-a430-4853-adca-809d8d6d451e',NULL,NULL,NULL,NULL),
 ('xforms.defaultFontFamily','Verdana, \'Lucida Grande\', \'Trebuchet MS\', Arial, Sans-Serif','The default font family used by the form designer.','b1c378fd-3fb4-467f-a231-b49740496ddb',NULL,NULL,NULL,NULL),
 ('xforms.defaultFontSize','16','The default font size used by the form designer.','7cdf766e-01cb-41eb-a4b7-a9db49d0767d',NULL,NULL,NULL,NULL),
 ('xforms.encounterDateIncludesTime','false','Set to true if the encounter date should include time.','d56c0477-c7ba-4e7e-a497-631786b3f439',NULL,NULL,NULL,NULL),
 ('xforms.error_dir','xforms/error','Directory containing the xforms error items.  This will contain xform model xml files that have not been submitted into the formentry queue because of processing errors.','7d244e48-bcff-4102-ac3b-b62a5a215e02',NULL,NULL,NULL,NULL),
 ('xforms.includeUsersInXformsDownload','true','Set to true if you want to include users when downloading xforms, else set to false if you want to always load the users list separately.','60fa1196-0ec0-490e-a7a8-9d7a564cf15e',NULL,NULL,NULL,NULL),
 ('xforms.isRemoteFormEntry','false','Set to true if this is a remote form entry server (Not the main server).','e6aad737-6919-452b-ad37-c13d08da0551',NULL,NULL,NULL,NULL),
 ('xforms.localeList','en:English','The list of locales supported by the form designer. e.g:  en:English,fr:French,es:Spanish,it:Italian,pt:Portuguese','684993f4-5bc0-442a-8d63-fdf585d45b0b',NULL,NULL,NULL,NULL),
 ('xforms.mandatory','false','true/false whether or not the xforms module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','711ed7d8-dcf7-4dea-b379-afcbfc95d39b',NULL,NULL,NULL,NULL),
 ('xforms.multiSelectAppearance','full','The appearance of multi select input fields. Allowed values are: {full,minimal,compact}','b0a6ac68-a824-46ff-8e0b-a3d0d8c989a7',NULL,NULL,NULL,NULL),
 ('xforms.newPatientFormId',NULL,'The id of the form for creating new patients','bca60efd-7242-489b-a1f9-c949e1894129',NULL,NULL,NULL,NULL),
 ('xforms.new_patient_identifier_type_id','1','The id of the patient identifier type which will be used when creating new patients from forms which do not have a patient_identifier.identifier_type_id field.','850fa008-c5f0-468e-9a69-60693629e130',NULL,NULL,NULL,NULL),
 ('xforms.overwriteValidationsOnRefresh','false','Set to true if, on refresh, you want custom validations to be replaced by those from the database concepts.','e852920b-f9d8-4edd-ba4f-e8222a7fac5d',NULL,NULL,NULL,NULL),
 ('xforms.patientDownloadCohort',NULL,'The cohort for patients to download','030aba92-7722-4c02-b348-071a1af6e512',NULL,NULL,NULL,NULL),
 ('xforms.patientRegEncounterFormId','0','The id of the encounter form which will be combined with the patient registration form.','ba8c4b16-770a-4522-b5af-ba675e4fd313',NULL,NULL,NULL,NULL),
 ('xforms.patientSerializer','org.openmrs.module.xforms.serialization.DefaultPatientSerializer','The patient set serializer','3115d4fb-eeeb-4536-a999-4bb26000b095',NULL,NULL,NULL,NULL),
 ('xforms.preferredConceptSource',NULL,'The name for preferred concept source to be used for forms that can be shared with other OpenMRS installations.','50caf4fd-9ddb-4491-90f5-226675fd0e9e',NULL,NULL,NULL,NULL),
 ('xforms.queue_dir','xforms/queue','Directory containing the xforms queue items. This will contain xforms xml model files submitted and awaiting processing to be submitted into the formentry queue.','819e9f7e-49a3-43df-9e21-2e0a936533cb',NULL,NULL,NULL,NULL),
 ('xforms.rejectExistingPatientCreation','true','Set to true to Reject forms for patients considered new when they already exist, by virture of patient identifier. Else set to false to allow them.','5431afe4-feaf-44a9-a372-262eb78b146f',NULL,NULL,NULL,NULL),
 ('xforms.savedSearchSerializer','org.openmrs.module.xforms.serialization.DefaultSavedSearchSerializer','The patient saved search serializer','d470b03e-3407-43a0-80e0-a1b105332dba',NULL,NULL,NULL,NULL),
 ('xforms.saveFormat','purcforms','The format in which the xforms will be saved. For now we support two formats: purcforms and javarosa','a1701c44-1977-4675-8c7a-5afa87e0033a',NULL,NULL,NULL,NULL),
 ('xforms.searchNewPatientAfterFormSubmission','true','Set to true if you want to search for a new patient after submitting a form, else set to false if you want to go back to the same patient.','b1a3f595-cf58-4b32-9f1e-92ed3cbb2006',NULL,NULL,NULL,NULL),
 ('xforms.setDefaultLocation','false','Set to true if you want to set the default location to that of the logged on user.','843a4e23-28fb-41fd-a5e9-b200568e68ce',NULL,NULL,NULL,NULL),
 ('xforms.setDefaultProvider','false','Set to true if you want to set the default provider to the logged on user, if he or she has the provider role.','0d86ce3d-cbd5-4fb2-a16b-e720c7287269',NULL,NULL,NULL,NULL),
 ('xforms.showDesignSurfaceTab','true','Set to true if you want to display the Design Surface tab of the form designer.','a303929a-5c96-4065-b1ac-e16a55ee64cb',NULL,NULL,NULL,NULL),
 ('xforms.showJavaScriptTab','false','Set to true if you want to display the JavaScript tab of the form designer.','3ea82a4d-9f49-4aa3-9389-28078a7940c2',NULL,NULL,NULL,NULL),
 ('xforms.showLanguageTab','false','Set to true if you want to display the language xml tab of the form designer.','1ffad1f1-0a13-4a61-a9e4-970ec2d38b1b',NULL,NULL,NULL,NULL),
 ('xforms.showLayoutXmlTab','false','Set to true if you want to display the layout xml tab of the form designer.','3b719ddf-3052-41dd-af66-da9082171e3a',NULL,NULL,NULL,NULL),
 ('xforms.showModelXmlTab','false','Set to true if you want to display the model xml tab of the form designer.','8c11472e-5010-419b-bc44-e6f911bbfff0',NULL,NULL,NULL,NULL),
 ('xforms.showOfflineFormDesigner','false','Set to true if you want to show the form designer in off line mode.','947b552f-bd3f-4f1f-9199-e200dd3a94b3',NULL,NULL,NULL,NULL),
 ('xforms.showPreviewTab','true','Set to true if you want to display the Preview tab of the form designer.','ff6b9ac4-bf86-4b09-b103-78756ac03074',NULL,NULL,NULL,NULL),
 ('xforms.showSubmitSuccessMsg','false','Set to true if you want to display the form submitted successfully message every time a form is submitted successfully.','a8f1b607-31f3-417c-b9af-415aeb5b04e8',NULL,NULL,NULL,NULL),
 ('xforms.showXformsSourceTab','false','Set to true if you want to display the xforms source tab of the form designer.','f7715b1f-c06b-4593-b703-5ce4f0700fbd',NULL,NULL,NULL,NULL),
 ('xforms.singleSelectAppearance','minimal','The appearance of single select input fields. Allowed values are: {full,minimal,compact}','c81584b3-4bbf-4ca6-adcf-694e17077c2c',NULL,NULL,NULL,NULL),
 ('xforms.smsFieldSepChar','=','The separator between questions and answers in the sms text.','dfc6c750-e8dd-49c1-9f2b-89b1ff98b9e0',NULL,NULL,NULL,NULL),
 ('xforms.smsSendFailureReports','true','Set to true if you want sms sender to get failure reports, else set to false.','791eec2c-c0b2-4859-9a6c-eb8c93ce3940',NULL,NULL,NULL,NULL),
 ('xforms.smsSendSuccessReports','true','Set to true if you want sms sender to get success reports, else set to false.','1997473b-7545-4f28-a908-89e1ab193f07',NULL,NULL,NULL,NULL),
 ('xforms.started','true','DO NOT MODIFY. true/false whether or not the xforms module has been started.  This is used to make sure modules that were running  prior to a restart are started again','5b8e5b56-1c5f-43f6-b77a-dd8f1fd41247',NULL,NULL,NULL,NULL),
 ('xforms.timeDisplayFormat','hh:mm a','The display format of time used by the xforms module.','35c86d0b-28b2-4386-840f-7e33a84362bb',NULL,NULL,NULL,NULL),
 ('xforms.timeSubmitFormat','HH:mm:ss','The format of the time passed in the xml of the xforms model. Please make sure this matches with the date format of your data entry applications, else you will get wrong times on the server.','32618e93-a48c-4a9c-82fb-db2a214f1b6c',NULL,NULL,NULL,NULL),
 ('xforms.undoRedoBufferSize','-1','Set to the maximum number of actions you can undo or redo. The bigger the size, the more memory your browser needs. Default value is 100. Set to -1 if you do not want any limit.','c0f5a70f-99e9-4820-8763-6a38baa2cab7',NULL,NULL,NULL,NULL),
 ('xforms.useConceptIdAsHint','false','Set to true if you want to display the concept Id as the default field description.','0986b7f9-7825-49dc-9bff-76b2880df950',NULL,NULL,NULL,NULL),
 ('xforms.useEncounterXform','true','Set to true if you want to use XForms to edit encounters instead of the default openmrs edit encounter screen, else set to false.','84603f23-dd69-489e-b824-a89ed3a6bf36',NULL,NULL,NULL,NULL),
 ('xforms.usePatientXform','false','Set to true if you want to use XForms to create new patients instead of the default openmrs create patient form, else set to false.','8aee4c7a-4cbf-4557-adf2-29ab7200f2ba',NULL,NULL,NULL,NULL),
 ('xforms.userSerializer','org.openmrs.module.xforms.serialization.DefaultUserSerializer','The user set serializer','f12845c9-a725-4185-a116-d714c1bc0c5e',NULL,NULL,NULL,NULL),
 ('xforms.useStoredXform','true','Set to true if you want to use XForms uploaded into the database, else set to false if you want to always build an XForm on the fly from the current form definition.','4f2c912a-4c85-4a3b-8340-29fb8c4d86e3',NULL,NULL,NULL,NULL),
 ('xforms.xformDownloadFolder',NULL,'Folder to which XForms are download','60d85310-2a31-4434-9141-7b6ce0f4d357',NULL,NULL,NULL,NULL),
 ('xforms.xformSerializer','org.fcitmuk.epihandy.EpihandyXformSerializer','The XForms serializer','45aa1316-240a-4bc4-aead-219c5a843c0c',NULL,NULL,NULL,NULL),
 ('xforms.xformUploadFolder',NULL,'Folder from which XForms data is uploaded','511a947c-c496-4561-99ff-21c6fa9ac9a7',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `global_property` ENABLE KEYS */;


--
-- Definition of table `groovy_scripts`
--

DROP TABLE IF EXISTS `groovy_scripts`;
CREATE TABLE `groovy_scripts` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `script` mediumtext NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `User who wrote this script` (`creator`),
  KEY `User who changed this script` (`changed_by`),
  CONSTRAINT `User who changed this script` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `User who wrote this script` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `groovy_scripts`
--

/*!40000 ALTER TABLE `groovy_scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `groovy_scripts` ENABLE KEYS */;


--
-- Definition of table `hl7_in_archive`
--

DROP TABLE IF EXISTS `hl7_in_archive`;
CREATE TABLE `hl7_in_archive` (
  `hl7_in_archive_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` varchar(255) DEFAULT NULL,
  `hl7_data` text NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `message_state` int(11) DEFAULT '2',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`hl7_in_archive_id`),
  UNIQUE KEY `hl7_in_archive_uuid_index` (`uuid`),
  KEY `hl7_in_archive_message_state_idx` (`message_state`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hl7_in_archive`
--

/*!40000 ALTER TABLE `hl7_in_archive` DISABLE KEYS */;
INSERT INTO `hl7_in_archive` (`hl7_in_archive_id`,`hl7_source`,`hl7_source_key`,`hl7_data`,`date_created`,`message_state`,`uuid`) VALUES 
 (1,1,'7a7a949c-6f56-4a2b-abdd-92da47f57ed0','<?xml version=\"1.0\"?>\n<ORU_R01 xmlns=\"urn:hl7-org:v2xml\">\n    <MSH>\n        <MSH.1>|</MSH.1>\n        <MSH.2>^~\\&amp;amp;</MSH.2>\n        <MSH.4>\n            <HD.1>999</HD.1>\n        </MSH.4>\n        <MSH.6>\n            <HD.1>Shared Health Record</HD.1>\n        </MSH.6>\n        <MSH.7>\n            <TS.1>20131112203404</TS.1>\n        </MSH.7>\n        <MSH.9>\n            <MSG.1>ORU</MSG.1>\n            <MSG.2>R01</MSG.2>\n            <MSG.3>ORU_R01</MSG.3>\n        </MSH.9>\n        <MSH.10>7a7a949c-6f56-4a2b-abdd-92da47f57ed0</MSH.10>\n        <MSH.11>\n            <PT.1>D</PT.1>\n            <PT.2>C</PT.2>\n        </MSH.11>\n        <MSH.12>\n            <VID.1>2.5</VID.1>\n            <VID.2>\n                <CE.1>RWA</CE.1>\n            </VID.2>\n        </MSH.12>\n        <MSH.21>\n            <EI.1>CLSM_V0.83</EI.1>\n        </MSH.21>\n    </MSH>\n    <ORU_R01.PATIENT_RESULT>\n        <ORU_R01.PATIENT>\n            <PID>\n                <PID.3>\n                    <CX.1>4dbd7470-3c0d-11e3-9287-22000a9aa860</CX.1>\n                    <CX.5>ECID</CX.5>\n                </PID.3>\n                <PID.5>\n                    <XPN.1>\n                        <FN.1>Yates</FN.1>\n                    </XPN.1>\n                    <XPN.2>Bryan</XPN.2>\n                </PID.5>\n            </PID>\n            <ORU_R01.VISIT>\n                <PV1>\n                    <PV1.2>0</PV1.2>\n                    <PV1.3>\n                        <PL.1>103</PL.1>\n                        <PL.4>\n                            <HD.1>Rwamagana</HD.1>\n                        </PL.4>\n                    </PV1.3>\n                    <PV1.4>ANC Referral</PV1.4>\n                    <PV1.7>\n                        <XCN.1>3525410</XCN.1>\n                        <XCN.2>\n                            <FN.1>Doctor</FN.1>\n                        </XCN.2>\n                        <XCN.3>John</XCN.3>\n                        <XCN.13>EPID</XCN.13>\n                    </PV1.7>\n                    <PV1.44>\n                        <TS.1>201311120834</TS.1>\n                    </PV1.44>\n                </PV1>\n            </ORU_R01.VISIT>\n        </ORU_R01.PATIENT>\n        <ORU_R01.ORDER_OBSERVATION>\n            <ORC>\n                <ORC.1>RE</ORC.1>\n                <ORC.9>\n                    <TS.1>201311122034</TS.1>\n                </ORC.9>\n                <ORC.12>\n                    <XCN.1>3</XCN.1>\n                </ORC.12>\n                <ORC.16>\n                    <CE.1>Identifier</CE.1>\n                    <CE.2>Text</CE.2>\n                    <CE.3>Name of Coding System</CE.3>\n                </ORC.16>\n            </ORC>\n            <OBR>\n                <OBR.1>0</OBR.1>\n                <OBR.3>\n                    <EI.1>37</EI.1>\n                </OBR.3>\n                <OBR.4>\n                    <CE.2>ANC Referral</CE.2>\n                </OBR.4>\n                <OBR.7>\n                    <TS.1>201311120000</TS.1>\n                </OBR.7>\n                <OBR.20>103</OBR.20>\n                <OBR.21>Rwamagana</OBR.21>\n            </OBR>\n        </ORU_R01.ORDER_OBSERVATION>\n        <ORU_R01.ORDER_OBSERVATION>\n            <OBR>\n                <OBR.1>1</OBR.1>\n                <OBR.18>0</OBR.18>\n                <OBR.29>\n                    <EIP.2>\n                        <EI.3>37</EI.3>\n                    </EIP.2>\n                </OBR.29>\n            </OBR>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>0</OBX.1>\n                    <OBX.2>ST</OBX.2>\n                    <OBX.3>\n                        <CE.1>57133-1</CE.1>\n                        <CE.2>Refer patient to</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>Healthcare unit/clinic</OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>1</OBX.1>\n                    <OBX.2>CE</OBX.2>\n                    <OBX.3>\n                        <CE.1>8517</CE.1>\n                        <CE.2>Referral Urgency</CE.2>\n                        <CE.3>RWCS</CE.3>\n                    </OBX.3>\n                    <OBX.5>\n                        <CE.1>8512</CE.1>\n                        <CE.2>Immediate Referral</CE.2>\n                        <CE.3>RWCS</CE.3>\n                    </OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>2</OBX.1>\n                    <OBX.2>ST</OBX.2>\n                    <OBX.3>\n                        <CE.1>42349-1</CE.1>\n                        <CE.2>REASON FOR REFERRAL TO ANOTHER SITE</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>Reason</OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>3</OBX.1>\n                    <OBX.2>TS</OBX.2>\n                    <OBX.3>\n                        <CE.1>57202-4</CE.1>\n                        <CE.2>DATE OF REFERRAL REQUEST</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>\n                        <TS.1>20131029000000</TS.1>\n                    </OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n        </ORU_R01.ORDER_OBSERVATION>\n    </ORU_R01.PATIENT_RESULT>\n</ORU_R01>','2013-11-19 12:59:56',2,'cb22cd90-590e-4ce8-83ab-0fb4dce872aa'),
 (2,1,'7a7a949c-6f56-4a2b-abdd-92da47f57ed0','<?xml version=\"1.0\"?>\n<ORU_R01 xmlns=\"urn:hl7-org:v2xml\">\n    <MSH>\n        <MSH.1>|</MSH.1>\n        <MSH.2>^~\\&amp;amp;</MSH.2>\n        <MSH.4>\n            <HD.1>999</HD.1>\n        </MSH.4>\n        <MSH.6>\n            <HD.1>Shared Health Record</HD.1>\n        </MSH.6>\n        <MSH.7>\n            <TS.1>20131112203404</TS.1>\n        </MSH.7>\n        <MSH.9>\n            <MSG.1>ORU</MSG.1>\n            <MSG.2>R01</MSG.2>\n            <MSG.3>ORU_R01</MSG.3>\n        </MSH.9>\n        <MSH.10>7a7a949c-6f56-4a2b-abdd-92da47f57ed0</MSH.10>\n        <MSH.11>\n            <PT.1>D</PT.1>\n            <PT.2>C</PT.2>\n        </MSH.11>\n        <MSH.12>\n            <VID.1>2.5</VID.1>\n            <VID.2>\n                <CE.1>RWA</CE.1>\n            </VID.2>\n        </MSH.12>\n        <MSH.21>\n            <EI.1>CLSM_V0.83</EI.1>\n        </MSH.21>\n    </MSH>\n    <ORU_R01.PATIENT_RESULT>\n        <ORU_R01.PATIENT>\n            <PID>\n                <PID.3>\n                    <CX.1>4dbd7470-3c0d-11e3-9287-22000a9aa860</CX.1>\n                    <CX.5>ECID</CX.5>\n                </PID.3>\n                <PID.5>\n                    <XPN.1>\n                        <FN.1>Yates</FN.1>\n                    </XPN.1>\n                    <XPN.2>Bryan</XPN.2>\n                </PID.5>\n            </PID>\n            <ORU_R01.VISIT>\n                <PV1>\n                    <PV1.2>0</PV1.2>\n                    <PV1.3>\n                        <PL.1>103</PL.1>\n                        <PL.4>\n                            <HD.1>Rwamagana</HD.1>\n                        </PL.4>\n                    </PV1.3>\n                    <PV1.4>ANC Referral</PV1.4>\n                    <PV1.7>\n                        <XCN.1>3525410</XCN.1>\n                        <XCN.2>\n                            <FN.1>Doctor</FN.1>\n                        </XCN.2>\n                        <XCN.3>John</XCN.3>\n                        <XCN.13>EPID</XCN.13>\n                    </PV1.7>\n                    <PV1.44>\n                        <TS.1>201311120834</TS.1>\n                    </PV1.44>\n                </PV1>\n            </ORU_R01.VISIT>\n        </ORU_R01.PATIENT>\n        <ORU_R01.ORDER_OBSERVATION>\n            <ORC>\n                <ORC.1>RE</ORC.1>\n                <ORC.9>\n                    <TS.1>201311122034</TS.1>\n                </ORC.9>\n                <ORC.12>\n                    <XCN.1>3</XCN.1>\n                </ORC.12>\n                <ORC.16>\n                    <CE.1>Identifier</CE.1>\n                    <CE.2>Text</CE.2>\n                    <CE.3>Name of Coding System</CE.3>\n                </ORC.16>\n            </ORC>\n            <OBR>\n                <OBR.1>0</OBR.1>\n                <OBR.3>\n                    <EI.1>37</EI.1>\n                </OBR.3>\n                <OBR.4>\n                    <CE.2>ANC Referral</CE.2>\n                </OBR.4>\n                <OBR.7>\n                    <TS.1>201311120000</TS.1>\n                </OBR.7>\n                <OBR.20>103</OBR.20>\n                <OBR.21>Rwamagana</OBR.21>\n            </OBR>\n        </ORU_R01.ORDER_OBSERVATION>\n        <ORU_R01.ORDER_OBSERVATION>\n            <OBR>\n                <OBR.1>1</OBR.1>\n                <OBR.18>0</OBR.18>\n                <OBR.29>\n                    <EIP.2>\n                        <EI.3>37</EI.3>\n                    </EIP.2>\n                </OBR.29>\n            </OBR>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>0</OBX.1>\n                    <OBX.2>ST</OBX.2>\n                    <OBX.3>\n                        <CE.1>57133-1</CE.1>\n                        <CE.2>Refer patient to</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>Healthcare unit/clinic</OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>1</OBX.1>\n                    <OBX.2>CE</OBX.2>\n                    <OBX.3>\n                        <CE.1>8517</CE.1>\n                        <CE.2>Referral Urgency</CE.2>\n                        <CE.3>RWCS</CE.3>\n                    </OBX.3>\n                    <OBX.5>\n                        <CE.1>8512</CE.1>\n                        <CE.2>Immediate Referral</CE.2>\n                        <CE.3>RWCS</CE.3>\n                    </OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>2</OBX.1>\n                    <OBX.2>ST</OBX.2>\n                    <OBX.3>\n                        <CE.1>42349-1</CE.1>\n                        <CE.2>REASON FOR REFERRAL TO ANOTHER SITE</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>Reason</OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>3</OBX.1>\n                    <OBX.2>TS</OBX.2>\n                    <OBX.3>\n                        <CE.1>57202-4</CE.1>\n                        <CE.2>DATE OF REFERRAL REQUEST</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>\n                        <TS.1>20131029000000</TS.1>\n                    </OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n        </ORU_R01.ORDER_OBSERVATION>\n    </ORU_R01.PATIENT_RESULT>\n</ORU_R01>','2013-11-19 13:15:24',2,'41e5cbd8-bfa6-43c5-b05f-8bbb92197b1d');
/*!40000 ALTER TABLE `hl7_in_archive` ENABLE KEYS */;


--
-- Definition of table `hl7_in_error`
--

DROP TABLE IF EXISTS `hl7_in_error`;
CREATE TABLE `hl7_in_error` (
  `hl7_in_error_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` text,
  `hl7_data` text NOT NULL,
  `error` varchar(255) NOT NULL DEFAULT '',
  `error_details` mediumtext,
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`hl7_in_error_id`),
  UNIQUE KEY `hl7_in_error_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hl7_in_error`
--

/*!40000 ALTER TABLE `hl7_in_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_error` ENABLE KEYS */;


--
-- Definition of table `hl7_in_queue`
--

DROP TABLE IF EXISTS `hl7_in_queue`;
CREATE TABLE `hl7_in_queue` (
  `hl7_in_queue_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` text,
  `hl7_data` text NOT NULL,
  `message_state` int(11) NOT NULL DEFAULT '0',
  `date_processed` datetime DEFAULT NULL,
  `error_msg` text,
  `date_created` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`hl7_in_queue_id`),
  UNIQUE KEY `hl7_in_queue_uuid_index` (`uuid`),
  KEY `hl7_source_with_queue` (`hl7_source`),
  CONSTRAINT `hl7_source_with_queue` FOREIGN KEY (`hl7_source`) REFERENCES `hl7_source` (`hl7_source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hl7_in_queue`
--

/*!40000 ALTER TABLE `hl7_in_queue` DISABLE KEYS */;
INSERT INTO `hl7_in_queue` (`hl7_in_queue_id`,`hl7_source`,`hl7_source_key`,`hl7_data`,`message_state`,`date_processed`,`error_msg`,`date_created`,`uuid`) VALUES 
 (1,1,'7a7a949c-6f56-4a2b-abdd-92da47f57ed0','<?xml version=\"1.0\"?>\n<ORU_R01 xmlns=\"urn:hl7-org:v2xml\">\n    <MSH>\n        <MSH.1>|</MSH.1>\n        <MSH.2>^~\\&amp;amp;</MSH.2>\n        <MSH.4>\n            <HD.1>999</HD.1>\n        </MSH.4>\n        <MSH.6>\n            <HD.1>Shared Health Record</HD.1>\n        </MSH.6>\n        <MSH.7>\n            <TS.1>20131112203404</TS.1>\n        </MSH.7>\n        <MSH.9>\n            <MSG.1>ORU</MSG.1>\n            <MSG.2>R01</MSG.2>\n            <MSG.3>ORU_R01</MSG.3>\n        </MSH.9>\n        <MSH.10>7a7a949c-6f56-4a2b-abdd-92da47f57ed0</MSH.10>\n        <MSH.11>\n            <PT.1>D</PT.1>\n            <PT.2>C</PT.2>\n        </MSH.11>\n        <MSH.12>\n            <VID.1>2.5</VID.1>\n            <VID.2>\n                <CE.1>RWA</CE.1>\n            </VID.2>\n        </MSH.12>\n        <MSH.21>\n            <EI.1>CLSM_V0.83</EI.1>\n        </MSH.21>\n    </MSH>\n    <ORU_R01.PATIENT_RESULT>\n        <ORU_R01.PATIENT>\n            <PID>\n                <PID.3>\n                    <CX.1>4dbd7470-3c0d-11e3-9287-22000a9aa860</CX.1>\n                    <CX.5>ECID</CX.5>\n                </PID.3>\n                <PID.5>\n                    <XPN.1>\n                        <FN.1>Yates</FN.1>\n                    </XPN.1>\n                    <XPN.2>Bryan</XPN.2>\n                </PID.5>\n            </PID>\n            <ORU_R01.VISIT>\n                <PV1>\n                    <PV1.2>0</PV1.2>\n                    <PV1.3>\n                        <PL.1>103</PL.1>\n                        <PL.4>\n                            <HD.1>Rwamagana</HD.1>\n                        </PL.4>\n                    </PV1.3>\n                    <PV1.4>ANC Referral</PV1.4>\n                    <PV1.7>\n                        <XCN.1>3525410</XCN.1>\n                        <XCN.2>\n                            <FN.1>Doctor</FN.1>\n                        </XCN.2>\n                        <XCN.3>John</XCN.3>\n                        <XCN.13>EPID</XCN.13>\n                    </PV1.7>\n                    <PV1.44>\n                        <TS.1>201311120834</TS.1>\n                    </PV1.44>\n                </PV1>\n            </ORU_R01.VISIT>\n        </ORU_R01.PATIENT>\n        <ORU_R01.ORDER_OBSERVATION>\n            <ORC>\n                <ORC.1>RE</ORC.1>\n                <ORC.9>\n                    <TS.1>201311122034</TS.1>\n                </ORC.9>\n                <ORC.12>\n                    <XCN.1>3</XCN.1>\n                </ORC.12>\n                <ORC.16>\n                    <CE.1>Identifier</CE.1>\n                    <CE.2>Text</CE.2>\n                    <CE.3>Name of Coding System</CE.3>\n                </ORC.16>\n            </ORC>\n            <OBR>\n                <OBR.1>0</OBR.1>\n                <OBR.3>\n                    <EI.1>37</EI.1>\n                </OBR.3>\n                <OBR.4>\n                    <CE.2>ANC Referral</CE.2>\n                </OBR.4>\n                <OBR.7>\n                    <TS.1>201311120000</TS.1>\n                </OBR.7>\n                <OBR.20>103</OBR.20>\n                <OBR.21>Rwamagana</OBR.21>\n            </OBR>\n        </ORU_R01.ORDER_OBSERVATION>\n        <ORU_R01.ORDER_OBSERVATION>\n            <OBR>\n                <OBR.1>1</OBR.1>\n                <OBR.18>0</OBR.18>\n                <OBR.29>\n                    <EIP.2>\n                        <EI.3>37</EI.3>\n                    </EIP.2>\n                </OBR.29>\n            </OBR>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>0</OBX.1>\n                    <OBX.2>ST</OBX.2>\n                    <OBX.3>\n                        <CE.1>57133-1</CE.1>\n                        <CE.2>Refer patient to</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>Healthcare unit/clinic</OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>1</OBX.1>\n                    <OBX.2>CE</OBX.2>\n                    <OBX.3>\n                        <CE.1>8517</CE.1>\n                        <CE.2>Referral Urgency</CE.2>\n                        <CE.3>RWCS</CE.3>\n                    </OBX.3>\n                    <OBX.5>\n                        <CE.1>8512</CE.1>\n                        <CE.2>Immediate Referral</CE.2>\n                        <CE.3>RWCS</CE.3>\n                    </OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>2</OBX.1>\n                    <OBX.2>ST</OBX.2>\n                    <OBX.3>\n                        <CE.1>42349-1</CE.1>\n                        <CE.2>REASON FOR REFERRAL TO ANOTHER SITE</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>Reason</OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>3</OBX.1>\n                    <OBX.2>TS</OBX.2>\n                    <OBX.3>\n                        <CE.1>57202-4</CE.1>\n                        <CE.2>DATE OF REFERRAL REQUEST</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>\n                        <TS.1>20131029000000</TS.1>\n                    </OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n        </ORU_R01.ORDER_OBSERVATION>\n    </ORU_R01.PATIENT_RESULT>\n</ORU_R01>',0,NULL,NULL,'2013-11-19 12:59:56','c3f72883-1753-48ee-8656-4943f86bf0c2'),
 (2,1,'7a7a949c-6f56-4a2b-abdd-92da47f57ed0','<?xml version=\"1.0\"?>\n<ORU_R01 xmlns=\"urn:hl7-org:v2xml\">\n    <MSH>\n        <MSH.1>|</MSH.1>\n        <MSH.2>^~\\&amp;amp;</MSH.2>\n        <MSH.4>\n            <HD.1>999</HD.1>\n        </MSH.4>\n        <MSH.6>\n            <HD.1>Shared Health Record</HD.1>\n        </MSH.6>\n        <MSH.7>\n            <TS.1>20131112203404</TS.1>\n        </MSH.7>\n        <MSH.9>\n            <MSG.1>ORU</MSG.1>\n            <MSG.2>R01</MSG.2>\n            <MSG.3>ORU_R01</MSG.3>\n        </MSH.9>\n        <MSH.10>7a7a949c-6f56-4a2b-abdd-92da47f57ed0</MSH.10>\n        <MSH.11>\n            <PT.1>D</PT.1>\n            <PT.2>C</PT.2>\n        </MSH.11>\n        <MSH.12>\n            <VID.1>2.5</VID.1>\n            <VID.2>\n                <CE.1>RWA</CE.1>\n            </VID.2>\n        </MSH.12>\n        <MSH.21>\n            <EI.1>CLSM_V0.83</EI.1>\n        </MSH.21>\n    </MSH>\n    <ORU_R01.PATIENT_RESULT>\n        <ORU_R01.PATIENT>\n            <PID>\n                <PID.3>\n                    <CX.1>4dbd7470-3c0d-11e3-9287-22000a9aa860</CX.1>\n                    <CX.5>ECID</CX.5>\n                </PID.3>\n                <PID.5>\n                    <XPN.1>\n                        <FN.1>Yates</FN.1>\n                    </XPN.1>\n                    <XPN.2>Bryan</XPN.2>\n                </PID.5>\n            </PID>\n            <ORU_R01.VISIT>\n                <PV1>\n                    <PV1.2>0</PV1.2>\n                    <PV1.3>\n                        <PL.1>103</PL.1>\n                        <PL.4>\n                            <HD.1>Rwamagana</HD.1>\n                        </PL.4>\n                    </PV1.3>\n                    <PV1.4>ANC Referral</PV1.4>\n                    <PV1.7>\n                        <XCN.1>3525410</XCN.1>\n                        <XCN.2>\n                            <FN.1>Doctor</FN.1>\n                        </XCN.2>\n                        <XCN.3>John</XCN.3>\n                        <XCN.13>EPID</XCN.13>\n                    </PV1.7>\n                    <PV1.44>\n                        <TS.1>201311120834</TS.1>\n                    </PV1.44>\n                </PV1>\n            </ORU_R01.VISIT>\n        </ORU_R01.PATIENT>\n        <ORU_R01.ORDER_OBSERVATION>\n            <ORC>\n                <ORC.1>RE</ORC.1>\n                <ORC.9>\n                    <TS.1>201311122034</TS.1>\n                </ORC.9>\n                <ORC.12>\n                    <XCN.1>3</XCN.1>\n                </ORC.12>\n                <ORC.16>\n                    <CE.1>Identifier</CE.1>\n                    <CE.2>Text</CE.2>\n                    <CE.3>Name of Coding System</CE.3>\n                </ORC.16>\n            </ORC>\n            <OBR>\n                <OBR.1>0</OBR.1>\n                <OBR.3>\n                    <EI.1>37</EI.1>\n                </OBR.3>\n                <OBR.4>\n                    <CE.2>ANC Referral</CE.2>\n                </OBR.4>\n                <OBR.7>\n                    <TS.1>201311120000</TS.1>\n                </OBR.7>\n                <OBR.20>103</OBR.20>\n                <OBR.21>Rwamagana</OBR.21>\n            </OBR>\n        </ORU_R01.ORDER_OBSERVATION>\n        <ORU_R01.ORDER_OBSERVATION>\n            <OBR>\n                <OBR.1>1</OBR.1>\n                <OBR.18>0</OBR.18>\n                <OBR.29>\n                    <EIP.2>\n                        <EI.3>37</EI.3>\n                    </EIP.2>\n                </OBR.29>\n            </OBR>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>0</OBX.1>\n                    <OBX.2>ST</OBX.2>\n                    <OBX.3>\n                        <CE.1>57133-1</CE.1>\n                        <CE.2>Refer patient to</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>Healthcare unit/clinic</OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>1</OBX.1>\n                    <OBX.2>CE</OBX.2>\n                    <OBX.3>\n                        <CE.1>8517</CE.1>\n                        <CE.2>Referral Urgency</CE.2>\n                        <CE.3>RWCS</CE.3>\n                    </OBX.3>\n                    <OBX.5>\n                        <CE.1>8512</CE.1>\n                        <CE.2>Immediate Referral</CE.2>\n                        <CE.3>RWCS</CE.3>\n                    </OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>2</OBX.1>\n                    <OBX.2>ST</OBX.2>\n                    <OBX.3>\n                        <CE.1>42349-1</CE.1>\n                        <CE.2>REASON FOR REFERRAL TO ANOTHER SITE</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>Reason</OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>3</OBX.1>\n                    <OBX.2>TS</OBX.2>\n                    <OBX.3>\n                        <CE.1>57202-4</CE.1>\n                        <CE.2>DATE OF REFERRAL REQUEST</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>\n                        <TS.1>20131029000000</TS.1>\n                    </OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n        </ORU_R01.ORDER_OBSERVATION>\n    </ORU_R01.PATIENT_RESULT>\n</ORU_R01>',0,NULL,NULL,'2013-11-19 13:15:23','34ae5150-fb34-4a60-a2d4-1e13e8d6a317');
/*!40000 ALTER TABLE `hl7_in_queue` ENABLE KEYS */;


--
-- Definition of table `hl7_source`
--

DROP TABLE IF EXISTS `hl7_source`;
CREATE TABLE `hl7_source` (
  `hl7_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`hl7_source_id`),
  UNIQUE KEY `hl7_source_uuid_index` (`uuid`),
  KEY `user_who_created_hl7_source` (`creator`),
  CONSTRAINT `user_who_created_hl7_source` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hl7_source`
--

/*!40000 ALTER TABLE `hl7_source` DISABLE KEYS */;
INSERT INTO `hl7_source` (`hl7_source_id`,`name`,`description`,`creator`,`date_created`,`uuid`) VALUES 
 (1,'LOCAL','',1,'2006-09-01 00:00:00','8d6b8bb6-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `hl7_source` ENABLE KEYS */;


--
-- Definition of table `htmlformentry_html_form`
--

DROP TABLE IF EXISTS `htmlformentry_html_form`;
CREATE TABLE `htmlformentry_html_form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `xml_data` mediumtext NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `uuid` char(38) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `htmlformentry_html_form_uuid_index` (`uuid`),
  KEY `User who created htmlformentry_htmlform` (`creator`),
  KEY `Form with which this htmlform is related` (`form_id`),
  KEY `User who changed htmlformentry_htmlform` (`changed_by`),
  KEY `user_who_retired_html_form` (`retired_by`),
  CONSTRAINT `Form with which this htmlform is related` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`),
  CONSTRAINT `User who changed htmlformentry_htmlform` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `User who created htmlformentry_htmlform` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_html_form` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `htmlformentry_html_form`
--

/*!40000 ALTER TABLE `htmlformentry_html_form` DISABLE KEYS */;
INSERT INTO `htmlformentry_html_form` (`id`,`form_id`,`name`,`xml_data`,`creator`,`date_created`,`changed_by`,`date_changed`,`retired`,`uuid`,`description`,`retired_by`,`date_retired`,`retire_reason`) VALUES 
 (1,1,NULL,'<htmlform> <!-- Autogenerated example form  (template from 01-Nov-2010 -->\r\n<translations defaultLocale=\"en\">\r\n    <code name=\"Referral Request Date\">\r\n        <variant locale=\"en\" value=\"Referral Request Date\"/>\r\n        <variant locale=\"fr\" value=\"Date de la demande du transfert\"/>\r\n    </code>\r\n    <code name=\"Refer Patient To\">\r\n        <variant locale=\"en\" value=\"Refer Patient To\"/>\r\n        <variant locale=\"fr\" value=\"Transfère le patient vers\"/>\r\n    </code>\r\n    <code name=\"Reason For Referral\">\r\n        <variant locale=\"en\" value=\"Reason For Referral\"/>\r\n        <variant locale=\"fr\" value=\"Raisons du transfert vers un autre site\"/>\r\n    </code>\r\n   <code name=\"Referral Urgency\">\r\n        <variant locale=\"en\" value=\"Referral Urgency\"/>\r\n        <variant locale=\"fr\" value=\"Urgence du Transfert\"/>\r\n    </code>\r\n<code name=\"Immediate Referral\">\r\n        <variant locale=\"en\" value=\"Immediate Referral\"/>\r\n        <variant locale=\"fr\" value=\"renvoi immédiat\"/>\r\n    </code>\r\n<code name=\"Urgent\">\r\n        <variant locale=\"en\" value=\"Urgent\"/>\r\n        <variant locale=\"fr\" value=\"Urgent\"/>\r\n    </code>\r\n<code name=\"Routine\">\r\n        <variant locale=\"en\" value=\"Routine\"/>\r\n        <variant locale=\"fr\" value=\"Routine\"/>\r\n    </code>\r\n\r\n</translations>\r\n<macros> \r\npaperFormId = (Fill this in) \r\nheaderColor =#009d8e\r\nfontOnHeaderColor = white \r\n</macros>\r\n\r\n<style>\r\n.section {\r\n	border: 1px solid$headerColor;\r\n	padding: 2px;\r\n	text-align: left;\r\n	margin-bottom: 1em;\r\n}\r\n\r\n.sectionHeader {\r\n	background-color: $headerColor;\r\n	color: $fontOnHeaderColor;\r\n	display: block;\r\n	padding: 2px;\r\n	font-weight: bold;\r\n}\r\n\r\ntable.baseline-aligned td {\r\n	vertical-align: center;\r\n}\r\n</style>\r\n\r\n<span style=\"float: right\">Paper Form ID: $paperFormId</span>\r\n<h2>RHEA Referral Form (v1.0)</h2>\r\n<includeIf velocityTest=\"$patient.gender == \'F\' \">\r\n<section headerLabel=\"1. Encounter Details\">\r\n	<table class=\"baseline-aligned\">\r\n		<tr>\r\n			<td>Date:</td>\r\n			<td><encounterDate default=\"today\" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>Location:</td>\r\n			<td><encounterLocation default=\"GlobalProperty:registration.defaultLocationCode\"/></td>\r\n		</tr>\r\n		<tr>\r\n			<td>Provider:</td>\r\n			<td><encounterProvider default=\"currentUser\"/></td>\r\n		</tr>\r\n	</table>\r\n</section>\r\n\r\n<section headerLabel=\"2. Referral Information\">\r\n	<table class=\"baseline-aligned\">\r\n\r\n\r\n		<tr>\r\n			\r\n			<td><obs conceptId=\"3\" labelCode=\"Referral Request Date\"/></td>\r\n		</tr>\r\n		<tr>\r\n			\r\n			<td><obs conceptId=\"4\" style=\"textarea\" rows=\"3\" cols=\"30\" labelCode=\"Refer Patient To\"/></td>\r\n		</tr>\r\n\r\n	</table>\r\n</section>\r\n\r\n<submit /> \r\n\r\n</includeIf>\r\n<includeIf velocityTest=\"$patient.gender == \'M\' \">\r\n<section headerLabel=\"Invalid Patient Message\">\r\n\r\n		<table border=\"0\" width=\"100%\">\r\n           \r\n        <tr><td>This Form Is Only Filled For Female Patients:</td>\r\n				\r\n        </tr>\r\n\r\n     </table>\r\n\r\n	</section>\r\n</includeIf> \r\n</htmlform>',1,'2013-11-05 13:17:20',1,'2013-11-05 13:44:15',0,'93dff753-53bd-4917-9d96-3edafd8464ed',NULL,NULL,NULL,NULL),
 (2,1,NULL,'<htmlform> <!-- Autogenerated example form  (template from 01-Nov-2010 -->\r\n<translations defaultLocale=\"en\">\r\n    <code name=\"Referral Request Date\">\r\n        <variant locale=\"en\" value=\"Referral Request Date\"/>\r\n        <variant locale=\"fr\" value=\"Date de la demande du transfert\"/>\r\n    </code>\r\n    <code name=\"Refer Patient To\">\r\n        <variant locale=\"en\" value=\"Refer Patient To\"/>\r\n        <variant locale=\"fr\" value=\"Transfère le patient vers\"/>\r\n    </code>\r\n    <code name=\"Reason For Referral\">\r\n        <variant locale=\"en\" value=\"Reason For Referral\"/>\r\n        <variant locale=\"fr\" value=\"Raisons du transfert vers un autre site\"/>\r\n    </code>\r\n   <code name=\"Referral Urgency\">\r\n        <variant locale=\"en\" value=\"Referral Urgency\"/>\r\n        <variant locale=\"fr\" value=\"Urgence du Transfert\"/>\r\n    </code>\r\n<code name=\"Immediate Referral\">\r\n        <variant locale=\"en\" value=\"Immediate Referral\"/>\r\n        <variant locale=\"fr\" value=\"renvoi immédiat\"/>\r\n    </code>\r\n<code name=\"Urgent\">\r\n        <variant locale=\"en\" value=\"Urgent\"/>\r\n        <variant locale=\"fr\" value=\"Urgent\"/>\r\n    </code>\r\n<code name=\"Routine\">\r\n        <variant locale=\"en\" value=\"Routine\"/>\r\n        <variant locale=\"fr\" value=\"Routine\"/>\r\n    </code>\r\n\r\n</translations>\r\n<macros> \r\npaperFormId = (Fill this in) \r\nheaderColor =#009d8e\r\nfontOnHeaderColor = white \r\n</macros>\r\n\r\n<style>\r\n.section {\r\n	border: 1px solid$headerColor;\r\n	padding: 2px;\r\n	text-align: left;\r\n	margin-bottom: 1em;\r\n}\r\n\r\n.sectionHeader {\r\n	background-color: $headerColor;\r\n	color: $fontOnHeaderColor;\r\n	display: block;\r\n	padding: 2px;\r\n	font-weight: bold;\r\n}\r\n\r\ntable.baseline-aligned td {\r\n	vertical-align: center;\r\n}\r\n</style>\r\n\r\n<span style=\"float: right\">Paper Form ID: $paperFormId</span>\r\n<h2>RHEA Referral Form (v1.0)</h2>\r\n<includeIf velocityTest=\"$patient.gender == \'F\' \">\r\n<section headerLabel=\"1. Encounter Details\">\r\n	<table class=\"baseline-aligned\">\r\n		<tr>\r\n			<td>Date:</td>\r\n			<td><encounterDate default=\"today\" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>Location:</td>\r\n			<td><encounterLocation default=\"GlobalProperty:registration.defaultLocationCode\"/></td>\r\n		</tr>\r\n		<tr>\r\n			<td>Provider:</td>\r\n			<td><encounterProvider default=\"currentUser\"/></td>\r\n		</tr>\r\n	</table>\r\n</section>\r\n\r\n<section headerLabel=\"2. Referral Information\">\r\n	<table class=\"baseline-aligned\">\r\n\r\n\r\n		<tr>\r\n			\r\n			<td><obs conceptId=\"5\" labelCode=\"Referral Request Date\"/></td>\r\n		</tr>\r\n		<tr>\r\n			\r\n			<td><obs conceptId=\"6\" style=\"textarea\" rows=\"3\" cols=\"30\" labelCode=\"Refer Patient To\"/></td>\r\n		</tr>\r\n		<tr>\r\n			\r\n			<td><obs conceptId=\"7\" style=\"textarea\" rows=\"3\" cols=\"30\" labelCode=\"Reason For Referral\"/></td>\r\n		</tr>\r\n		<tr>\r\n			\r\n			<td><obs conceptId=\"8\" labelCode=\"Referral Urgency\"  style=\"radio\"  answerCodes=\"Immediate Referral,Urgent,Routine\"/></td>\r\n		</tr>\r\n	</table>\r\n</section>\r\n\r\n<submit /> \r\n\r\n</includeIf>\r\n<includeIf velocityTest=\"$patient.gender == \'M\' \">\r\n<section headerLabel=\"Invalid Patient Message\">\r\n\r\n		<table border=\"0\" width=\"100%\">\r\n           \r\n        <tr><td>This Form Is Only Filled For Female Patients:</td>\r\n				\r\n        </tr>\r\n\r\n     </table>\r\n\r\n	</section>\r\n</includeIf> \r\n</htmlform>',1,'2013-11-12 13:34:43',1,'2013-11-12 13:52:45',0,'3081752f-9264-469c-bc35-c3c64a943b27',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `htmlformentry_html_form` ENABLE KEYS */;


--
-- Definition of table `idgen_auto_generation_option`
--

DROP TABLE IF EXISTS `idgen_auto_generation_option`;
CREATE TABLE `idgen_auto_generation_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier_type` int(11) NOT NULL,
  `source` int(11) NOT NULL,
  `manual_entry_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `automatic_generation_enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier_type` (`identifier_type`),
  KEY `source for idgen_auto_generation_option` (`source`),
  CONSTRAINT `identifier_type for idgen_auto_generation_option` FOREIGN KEY (`identifier_type`) REFERENCES `patient_identifier_type` (`patient_identifier_type_id`),
  CONSTRAINT `source for idgen_auto_generation_option` FOREIGN KEY (`source`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `idgen_auto_generation_option`
--

/*!40000 ALTER TABLE `idgen_auto_generation_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_auto_generation_option` ENABLE KEYS */;


--
-- Definition of table `idgen_id_pool`
--

DROP TABLE IF EXISTS `idgen_id_pool`;
CREATE TABLE `idgen_id_pool` (
  `id` int(11) NOT NULL,
  `source` int(11) DEFAULT NULL,
  `batch_size` int(11) DEFAULT NULL,
  `min_pool_size` int(11) DEFAULT NULL,
  `sequential` tinyint(1) NOT NULL DEFAULT '0',
  `refill_with_scheduled_task` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `source for idgen_id_pool` (`source`),
  CONSTRAINT `id for idgen_id_pool` FOREIGN KEY (`id`) REFERENCES `idgen_identifier_source` (`id`),
  CONSTRAINT `source for idgen_id_pool` FOREIGN KEY (`source`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `idgen_id_pool`
--

/*!40000 ALTER TABLE `idgen_id_pool` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_id_pool` ENABLE KEYS */;


--
-- Definition of table `idgen_identifier_source`
--

DROP TABLE IF EXISTS `idgen_identifier_source`;
CREATE TABLE `idgen_identifier_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `identifier_type` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id for idgen_identifier_source` (`id`),
  KEY `identifier_type for idgen_identifier_source` (`identifier_type`),
  KEY `creator for idgen_identifier_source` (`creator`),
  KEY `changed_by for idgen_identifier_source` (`changed_by`),
  KEY `retired_by for idgen_identifier_source` (`retired_by`),
  CONSTRAINT `changed_by for idgen_identifier_source` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `creator for idgen_identifier_source` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `identifier_type for idgen_identifier_source` FOREIGN KEY (`identifier_type`) REFERENCES `patient_identifier_type` (`patient_identifier_type_id`),
  CONSTRAINT `retired_by for idgen_identifier_source` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `idgen_identifier_source`
--

/*!40000 ALTER TABLE `idgen_identifier_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_identifier_source` ENABLE KEYS */;


--
-- Definition of table `idgen_log_entry`
--

DROP TABLE IF EXISTS `idgen_log_entry`;
CREATE TABLE `idgen_log_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `date_generated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `generated_by` int(11) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id for idgen_log` (`id`),
  KEY `source for idgen_log` (`source`),
  KEY `generated_by for idgen_log` (`generated_by`),
  CONSTRAINT `generated_by for idgen_log` FOREIGN KEY (`generated_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `source for idgen_log` FOREIGN KEY (`source`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `idgen_log_entry`
--

/*!40000 ALTER TABLE `idgen_log_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_log_entry` ENABLE KEYS */;


--
-- Definition of table `idgen_pooled_identifier`
--

DROP TABLE IF EXISTS `idgen_pooled_identifier`;
CREATE TABLE `idgen_pooled_identifier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `pool_id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `date_used` datetime DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pool_id for idgen_pooled_identifier` (`pool_id`),
  CONSTRAINT `pool_id for idgen_pooled_identifier` FOREIGN KEY (`pool_id`) REFERENCES `idgen_id_pool` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `idgen_pooled_identifier`
--

/*!40000 ALTER TABLE `idgen_pooled_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_pooled_identifier` ENABLE KEYS */;


--
-- Definition of table `idgen_remote_source`
--

DROP TABLE IF EXISTS `idgen_remote_source`;
CREATE TABLE `idgen_remote_source` (
  `id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `user` varchar(50) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id for idgen_remote_source` FOREIGN KEY (`id`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `idgen_remote_source`
--

/*!40000 ALTER TABLE `idgen_remote_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_remote_source` ENABLE KEYS */;


--
-- Definition of table `idgen_reserved_identifier`
--

DROP TABLE IF EXISTS `idgen_reserved_identifier`;
CREATE TABLE `idgen_reserved_identifier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id for idgen_reserved_identifier` (`id`),
  KEY `source for idgen_reserved_identifier` (`source`),
  CONSTRAINT `source for idgen_reserved_identifier` FOREIGN KEY (`source`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `idgen_reserved_identifier`
--

/*!40000 ALTER TABLE `idgen_reserved_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_reserved_identifier` ENABLE KEYS */;


--
-- Definition of table `idgen_seq_id_gen`
--

DROP TABLE IF EXISTS `idgen_seq_id_gen`;
CREATE TABLE `idgen_seq_id_gen` (
  `id` int(11) NOT NULL,
  `next_sequence_value` int(11) NOT NULL DEFAULT '-1',
  `base_character_set` varchar(255) NOT NULL,
  `first_identifier_base` varchar(50) NOT NULL,
  `prefix` varchar(20) DEFAULT NULL,
  `suffix` varchar(20) DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id for idgen_seq_id_gen` FOREIGN KEY (`id`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `idgen_seq_id_gen`
--

/*!40000 ALTER TABLE `idgen_seq_id_gen` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_seq_id_gen` ENABLE KEYS */;


--
-- Definition of table `liquibasechangelog`
--

DROP TABLE IF EXISTS `liquibasechangelog`;
CREATE TABLE `liquibasechangelog` (
  `ID` varchar(63) NOT NULL,
  `AUTHOR` varchar(63) NOT NULL,
  `FILENAME` varchar(200) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`,`AUTHOR`,`FILENAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `liquibasechangelog`
--

/*!40000 ALTER TABLE `liquibasechangelog` DISABLE KEYS */;
INSERT INTO `liquibasechangelog` (`ID`,`AUTHOR`,`FILENAME`,`DATEEXECUTED`,`ORDEREXECUTED`,`EXECTYPE`,`MD5SUM`,`DESCRIPTION`,`COMMENTS`,`TAG`,`LIQUIBASE`) VALUES 
 ('0','bwolfe','liquibase-update-to-latest.xml','2011-09-20 00:00:00',10016,'MARK_RAN','3:ccc4741ff492cb385f44e714053920af',NULL,NULL,NULL,NULL),
 ('02232009-1141','nribeka','liquibase-update-to-latest.xml','2013-11-04 16:28:04',10063,'EXECUTED','3:b5921fb42deb90fe52e042838d0638a0','Modify Column','Modify the password column to fit the output of SHA-512 function',NULL,'2.0.1'),
 ('1','upul','liquibase-update-to-latest.xml','2013-11-04 16:27:54',10043,'MARK_RAN','3:7fbc03c45bb69cd497b096629d32c3f5','Add Column','Add the column to person_attribute type to connect each type to a privilege',NULL,'2.0.1'),
 ('1-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:27:54',10044,'EXECUTED','3:37a6dc66c67e8c518f9d50971387b438','Modify data type','(Fixed)Modified edit_privilege to correct column size',NULL,'2.0.1'),
 ('1001200030538-000456','dkayiwa','liquibase.xml','2013-11-08 10:34:20',10497,'EXECUTED','3:ff702435bc107dcdf2e0bc0a5133bc23','Insert Row','',NULL,'2.0.5'),
 ('1111256230538-332111','dkayiwa','liquibase.xml','2013-11-08 10:34:20',10493,'EXECUTED','3:5c8977198be18d92c176575f4d90d581','Insert Row','',NULL,'2.0.5'),
 ('1226348923233-12','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:45',10021,'EXECUTED','3:7efb7ed5267126e1e44c9f344e35dd7d','Insert Row (x12)','',NULL,'2.0.1'),
 ('1226348923233-13','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:45',10022,'EXECUTED','3:8b9e14aa00a4382aa2623b39400c9110','Insert Row (x2)','',NULL,'2.0.1'),
 ('1226348923233-14','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:46',10025,'EXECUTED','3:8910082a3b369438f86025e4006b7538','Insert Row (x4)','',NULL,'2.0.1'),
 ('1226348923233-15','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:46',10026,'EXECUTED','3:8485e0ebef4dc368ab6b87de939f8e82','Insert Row (x15)','',NULL,'2.0.1'),
 ('1226348923233-16','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:46',10027,'EXECUTED','3:5778f109b607f882cc274750590d5004','Insert Row','',NULL,'2.0.1'),
 ('1226348923233-17','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:46',10029,'EXECUTED','3:3c324233bf1f386dcc4a9be55401c260','Insert Row (x2)','',NULL,'2.0.1'),
 ('1226348923233-18','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:46',10030,'EXECUTED','3:40ad1a506929811955f4d7d4753d576e','Insert Row (x2)','',NULL,'2.0.1'),
 ('1226348923233-2','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:45',10018,'EXECUTED','3:35613fc962f41ed143c46e578fd64a70','Insert Row (x5)','',NULL,'2.0.1'),
 ('1226348923233-20','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:46',10031,'EXECUTED','3:0ce5c5b83b4754b44f4bcda8eb866f3a','Insert Row','',NULL,'2.0.1'),
 ('1226348923233-21','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:46',10032,'EXECUTED','3:51c90534135f429c1bcde82be0f6157d','Insert Row','',NULL,'2.0.1'),
 ('1226348923233-22','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:46',10033,'EXECUTED','3:ccf0fca99e44d670270d1aa9bc75a450','Insert Row','',NULL,'2.0.1'),
 ('1226348923233-23','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:46',10034,'EXECUTED','3:19f78a07a33a5efc28b4712a07b02a29','Insert Row','',NULL,'2.0.1'),
 ('1226348923233-6','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:45',10019,'EXECUTED','3:a947f43a1881ac56186039709a4a0ac8','Insert Row (x13)','',NULL,'2.0.1'),
 ('1226348923233-8','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:45',10020,'EXECUTED','3:dceb0cc19be3545af8639db55785d66e','Insert Row (x7)','',NULL,'2.0.1'),
 ('1226412230538-24','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:45',10023,'EXECUTED','3:0b77e92c0d1482c1bef7ca1add6b233b','Insert Row (x2)','',NULL,'2.0.1'),
 ('1226412230538-7','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:46',10024,'EXECUTED','3:c189f41d824649ef72dc3cef74d3580b','Insert Row (x106)','',NULL,'2.0.1'),
 ('1226412230538-9a','ben (generated)','liquibase-core-data.xml','2013-11-04 16:27:46',10035,'EXECUTED','3:73c2b426be208fb50f088ad4ee76c8d6','Insert Row (x4)','',NULL,'2.0.1'),
 ('1227123456789-100','dkayiwa','liquibase-schema-only.xml','2013-11-04 16:27:28',178,'EXECUTED','3:24751e1218f5fff3d2abf8e281e557c5','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-1','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:16',1,'EXECUTED','3:a851046bb3eb5b0daccb6e69ef8a9a00','Create Table','',NULL,'2.0.1'),
 ('1227303685425-10','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:16',8,'EXECUTED','3:7430a11c085ba88572d613b2db14bde5','Create Table','',NULL,'2.0.1'),
 ('1227303685425-100','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:22',114,'EXECUTED','3:8d20fc37ce4266cba349eeef66951688','Create Index','',NULL,'2.0.1'),
 ('1227303685425-101','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:22',115,'EXECUTED','3:cc9b2ad0c2ff9ad6fcfd2f56b52d795f','Create Index','',NULL,'2.0.1'),
 ('1227303685425-102','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:22',116,'EXECUTED','3:97d1301e8ab7f35e109c733fdedde10f','Create Index','',NULL,'2.0.1'),
 ('1227303685425-103','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:22',117,'EXECUTED','3:2447e4abc7501a18f401594e4c836fff','Create Index','',NULL,'2.0.1'),
 ('1227303685425-104','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:22',118,'EXECUTED','3:8d6c644eaf9f696e3fee1362863c26ec','Create Index','',NULL,'2.0.1'),
 ('1227303685425-105','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:22',119,'EXECUTED','3:fb3838f818387718d9b4cbf410d653cd','Create Index','',NULL,'2.0.1'),
 ('1227303685425-106','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:22',120,'EXECUTED','3:a644de1082a85ab7a0fc520bb8fc23d7','Create Index','',NULL,'2.0.1'),
 ('1227303685425-107','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:22',121,'EXECUTED','3:f11eb4e4bc4a5192b7e52622965aacb2','Create Index','',NULL,'2.0.1'),
 ('1227303685425-108','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:25',135,'EXECUTED','3:07fc6fd2c0086f941aed0b2c95c89dc8','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-109','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:25',136,'EXECUTED','3:c2911be31587bbc868a55f13fcc3ba5e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-11','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:16',9,'EXECUTED','3:b8724523516ff0f0b65dd941a50602a3','Create Table','',NULL,'2.0.1'),
 ('1227303685425-110','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:25',137,'EXECUTED','3:32c42fa39fe81932aa02974bb19567ed','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-111','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:25',138,'EXECUTED','3:f35c8159ca7f84ae551bdb988b833760','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-112','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:25',139,'EXECUTED','3:df0a45bc276e7484f183e3190cff8394','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-115','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:25',140,'EXECUTED','3:d3b13502ef9794718d68bd0697fd7c2b','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-116','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:25',141,'EXECUTED','3:6014d91cadbbfc05bd364619d94a4f18','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-117','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:25',142,'EXECUTED','3:0841471be0ebff9aba768017b9a9717b','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-118','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:26',143,'EXECUTED','3:c73351f905761c3cee7235b526eff1a0','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-119','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:26',144,'EXECUTED','3:cd72c79bfd3c807ba5451d8ca5cb2612','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-12','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:16',10,'EXECUTED','3:800659d0d88dddbbcf73352fe52f67f1','Create Table','',NULL,'2.0.1'),
 ('1227303685425-120','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:26',145,'EXECUTED','3:b07d718d9d2b64060584d4c460ffc277','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-121','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:26',146,'EXECUTED','3:be141d71df248fba87a322b35f13b4db','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-122','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:26',147,'EXECUTED','3:7bcc45dda3aeea4ab3916701483443d3','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-123','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:26',148,'EXECUTED','3:031e4dcf20174b92bbbb07323b86d569','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-124','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:26',149,'EXECUTED','3:7d277181a4e9d5e14f9cb1220c6c4c57','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-125','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:26',150,'EXECUTED','3:7172ef61a904cd7ae765f0205d9e66dd','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-126','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:26',151,'EXECUTED','3:0d9a3ffc816c3e4e8649df3de01a8ff6','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-128','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:26',152,'EXECUTED','3:3a9357d6283b2bb97c1423825d6d57eb','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-129','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:26',153,'EXECUTED','3:e3923913d6f34e0e8bc7333834884419','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-13','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:16',11,'EXECUTED','3:982544aff0ae869f5ac9691d5c93a7e4','Create Table','',NULL,'2.0.1'),
 ('1227303685425-130','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:26',154,'EXECUTED','3:dae7a98f3643acfe9db5c3b4b9e8f4ea','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-131','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:26',155,'EXECUTED','3:44a4e4791a0f727fffc96b9dab0a3fa8','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-132','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:26',156,'EXECUTED','3:16dcc5a95708dbdaff07ed27507d8e29','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-134','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:27',157,'EXECUTED','3:c37757ed38ace0bb94d8455a49e3049a','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-135','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:27',158,'EXECUTED','3:ab40ab94ab2f86a0013ecbf9dd034de4','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-136','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:27',159,'EXECUTED','3:3878ab735b369d778a7feb2b92746352','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-137','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:27',160,'EXECUTED','3:a7bf99f775c2f07b534a4df4e5c5c20b','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-139','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:27',161,'EXECUTED','3:f0a1690648292d939876bdeefa74792a','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-14','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:16',12,'EXECUTED','3:0132a13f3ff3c212ad7e11a9a0890bbb','Create Table','',NULL,'2.0.1'),
 ('1227303685425-140','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:27',162,'EXECUTED','3:7ba4860a1e0a00ff49a93d4e86929691','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-141','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:27',163,'EXECUTED','3:5b176976d808cf8b1b8fae7d2b19e059','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-142','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:27',164,'EXECUTED','3:5538db250e63d70a79dce2c5a74ee528','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-143','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:27',165,'EXECUTED','3:a981ac9be845bf6c6098aa98cd4d8456','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-144','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:27',166,'EXECUTED','3:84428d9dce773758f73616129935d888','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-145','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:27',167,'EXECUTED','3:6b8af6c242f1d598591478897feed2d8','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-146','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:27',168,'EXECUTED','3:a8cddf3b63050686248e82a3b6de781f','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-147','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:27',169,'EXECUTED','3:e8b5350ad40fa006c088f08fae4d3141','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-149','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:27',170,'EXECUTED','3:b6c44ee5824ae261a9a87b8ac60fe23d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-15','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',13,'EXECUTED','3:4a873d83a95eddbb316f93856df2650b','Create Table','',NULL,'2.0.1'),
 ('1227303685425-150','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:28',171,'EXECUTED','3:f8c495d78d68c9fc701271a8e5d1f102','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-151','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:28',172,'EXECUTED','3:94dc5b8d27f275fb06cc230eb313e430','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-153','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:28',173,'EXECUTED','3:2a04930665fe64516765263d1a9b0775','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-154','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:28',174,'EXECUTED','3:adfef8b8dd7b774b268b0968b7400f42','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-155','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:28',175,'EXECUTED','3:540b0422c733b464a33ca937348d8b4c','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-158','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:28',176,'EXECUTED','3:d1d73e19bab5821f256c01a83e2d945f','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-159','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:28',177,'EXECUTED','3:c23d0cd0eec5f20385b4182af18fc835','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-16','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',14,'EXECUTED','3:4c19b5c980b58e54af005e1fa50359ae','Create Table','',NULL,'2.0.1'),
 ('1227303685425-160','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:28',179,'EXECUTED','3:cc64f6e676cb6a448f73599d8149490c','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-161','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:28',180,'EXECUTED','3:f48e300a3439d90fa2d518b3d6e145a5','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-162','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:28',181,'EXECUTED','3:467e31995c41be55426a5256d99312c4','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-163','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:28',182,'EXECUTED','3:45a4519c252f7e42d649292b022ec158','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-164','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:28',183,'EXECUTED','3:dfd51e701b716c07841c2e4ea6f59f3e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-165','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:28',184,'EXECUTED','3:0d69b82ce833ea585e95a6887f800108','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-166','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',185,'EXECUTED','3:2070f44c444e1e6efdbe7dfb9f7b846d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-167','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',186,'EXECUTED','3:9196c0f9792007c72233649cc7c2ac58','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-168','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',187,'EXECUTED','3:33d644a49e92a4bbd4cb653d6554c8d0','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-169','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',188,'EXECUTED','3:e75c37cbd9aa22cf95b2dc89fdb2c831','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-17','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',15,'EXECUTED','3:4746a23e815903ede82cf95e9f8fbe2c','Create Table','',NULL,'2.0.1'),
 ('1227303685425-170','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',189,'EXECUTED','3:ac31515d8822caa0c87705cb0706e52f','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-171','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',190,'EXECUTED','3:b40823e1322acea52497f43033e72e5e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-173','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',191,'EXECUTED','3:b37c0b43a23ad3b072e34055875f7dcc','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-174','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',192,'EXECUTED','3:f8c5737a51f0f040e9fac3060c246e46','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-175','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',193,'EXECUTED','3:87cc15f9622b014d01d4df512a3f835e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-176','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',194,'EXECUTED','3:f57273dfbaba02ea785a0e165994f74b','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-177','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',195,'EXECUTED','3:1555790e99827ded259d5ec7860eb1b1','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-178','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',196,'EXECUTED','3:757206752885a07d1eea5585ad9e2dce','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-179','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',197,'EXECUTED','3:018efd7d7a5e84f7c2c9cec7299d596e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-18','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',16,'EXECUTED','3:2eb2063d3e1233e7ebc23f313da5bff6','Create Table','',NULL,'2.0.1'),
 ('1227303685425-180','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',198,'EXECUTED','3:9ba52b3b7059674e881b7611a3428bde','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-181','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',199,'EXECUTED','3:ffee79a7426d7e41cf65889c2a5064f2','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-182','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',200,'EXECUTED','3:380743d4f027534180d818f5c507fae9','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-183','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',201,'EXECUTED','3:6882a4cf798e257af34753a8b5e7a157','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-184','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:29',202,'EXECUTED','3:93473623db4b6e7ca7813658da5b6771','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-185','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',203,'EXECUTED','3:f19a46800a4695266f3372aa709650b2','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-186','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',204,'EXECUTED','3:adfd7433de8d3b196d1166f62e497f8d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-187','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',205,'EXECUTED','3:88b09239d29fbddd8bf4640df9f3e235','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-188','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',206,'EXECUTED','3:777e5970e09a3a1608bf7c40ef1ea1db','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-189','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',207,'EXECUTED','3:40dab4e434aa06340ba046fbd1382c6d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-19','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',17,'EXECUTED','3:767502bbf13ec4df5a926047d81d519b','Create Table','',NULL,'2.0.1'),
 ('1227303685425-190','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',208,'EXECUTED','3:8766098ff9779a913d5642862955eaff','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-191','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',209,'EXECUTED','3:2a52afd1df6dcf64ec21f3c6ffe1d022','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-192','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',210,'EXECUTED','3:fa5de48b1490faa157e1977529034169','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-193','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',211,'EXECUTED','3:1213cb90fa9bd1561a371cc53c262d0f','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-194','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',212,'EXECUTED','3:2eb07e7388ff8d68d36cf2f3552c1a7c','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-195','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',213,'EXECUTED','3:d6ec9bb7b3bab333dcea4a3c18083616','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-196','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',214,'EXECUTED','3:df03afd5ef34e472fd6d43ef74a859e1','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-197','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',215,'EXECUTED','3:a0811395501a4423ca66de08fcf53895','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-198','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',216,'EXECUTED','3:e46a78b95280d9082557ed991af8dbe7','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-199','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',217,'EXECUTED','3:e57afffae0d6a439927e45cde4393363','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-2','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:16',2,'EXECUTED','3:d90246bb4d8342608e818a872d3335f1','Create Table','',NULL,'2.0.1'),
 ('1227303685425-20','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',18,'EXECUTED','3:e0a8a4978c536423320f1ff44520169a','Create Table','',NULL,'2.0.1'),
 ('1227303685425-200','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',218,'EXECUTED','3:667c2308fcf366f47fab8d9df3a3b2ae','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-201','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',219,'EXECUTED','3:104750a2b7779fa43e8457071e0bc33e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-202','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',220,'EXECUTED','3:4b813b03362a54d89a28ed1b10bc9069','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-203','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:30',221,'EXECUTED','3:526893ceedd67d8a26747e314a15f501','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-204','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',222,'EXECUTED','3:d0dbb7cc972e73f6a429b273ef63132e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-205','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',223,'EXECUTED','3:44244a3065d9a5531a081d176aa4e93d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-207','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',224,'EXECUTED','3:77ade071c48615dbb39cbf9f01610c0e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-208','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',225,'EXECUTED','3:04495bf48c23d0fe56133da87c4e9a66','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-209','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',226,'EXECUTED','3:ff99d75d98ce0428a57100aeb558a529','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-21','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',19,'EXECUTED','3:f2353036e6382f45f91af5d8024fb04c','Create Table','',NULL,'2.0.1'),
 ('1227303685425-210','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',227,'EXECUTED','3:537b2e8f88277a6276bcdac5d1493e4e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-211','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',228,'EXECUTED','3:3da39190692480b0a610b5c66fd056b8','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-212','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',229,'EXECUTED','3:347f20b32a463b73f0a93de13731a3a3','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-213','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',230,'EXECUTED','3:b89ee7f6dd678737268566b7e7d0d5d3','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-214','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',231,'EXECUTED','3:5f4b3400ecb50d46e04a18b6b57821c8','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-215','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',232,'EXECUTED','3:3dfa6664ca6b77eee492af73908f7312','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-216','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',233,'EXECUTED','3:7f7dbdcdaf3914e33458c0d67bc326db','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-217','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',234,'EXECUTED','3:1f03c97bd9b3ee1c2726656c6a0db795','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-218','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',235,'EXECUTED','3:e0a67bb4f3ea4b44de76fd73ca02ddb3','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-219','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',236,'EXECUTED','3:9a347c93be3356b84358ada2264ed201','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-22','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',20,'EXECUTED','3:5bd93e476a8390b82bc90ef367a200ec','Create Table','',NULL,'2.0.1'),
 ('1227303685425-220','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:31',237,'EXECUTED','3:8a744c0020e6c6ae519ed0a04d79f82d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-221','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',238,'EXECUTED','3:cc3f5b38ea88221efe32bc99be062edf','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-222','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',239,'EXECUTED','3:a90ffe3cbe9ddd1704e702e71ba5a216','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-223','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',240,'EXECUTED','3:ee4b79223897197c46c79d6ed2e68538','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-224','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',241,'EXECUTED','3:56d7625e53d13008ae7a31d09ba7dab8','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-225','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',242,'EXECUTED','3:b94477e4e6ecf22bc973408d2d01a868','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-226','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',243,'EXECUTED','3:d7a0cde832f1f557f0f42710645c1b50','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-227','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',244,'EXECUTED','3:6873a8454254a783dbcbe608828c0bd0','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-228','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',245,'EXECUTED','3:6ffcdbbe70b8f8e096785a3c2fe83318','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-229','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',246,'EXECUTED','3:ef5d7095407e0df6a1fcaf7c3c55872b','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-23','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',21,'EXECUTED','3:c3aa4ad35ead35e805a99083a95a1c86','Create Table','',NULL,'2.0.1'),
 ('1227303685425-230','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',247,'EXECUTED','3:306710c2acba2e689bf1121d577f449b','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-231','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',248,'EXECUTED','3:71f320edc9221ce73876d80077b7b94d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-232','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',249,'EXECUTED','3:8dfba47fb6719dc743b231cc645a8378','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-234','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',250,'EXECUTED','3:9b12808a0fe62d6951bcd61f9cbff3f8','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-235','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',251,'EXECUTED','3:a3e9822b106a9bb42f5b9d28dc70335c','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-236','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',252,'EXECUTED','3:388be0f658f8bf6df800fe3efd4dadb3','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-237','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:32',253,'EXECUTED','3:eee4cb65598835838fd6deb8e4043693','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-239','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',254,'EXECUTED','3:3b38e45410dd1d02530d012a12b6b03c','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-24','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',22,'EXECUTED','3:f4f4e3a5fa3d93bb50d2004c6976cc12','Create Table','',NULL,'2.0.1'),
 ('1227303685425-240','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',255,'EXECUTED','3:095316f05dac21b4a33a141e5781d99d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-241','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',256,'EXECUTED','3:2cffae7a53d76f19e5194778cff75a4f','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-242','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',257,'EXECUTED','3:828732619d67fa932631e18827d74463','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-243','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',258,'EXECUTED','3:730166a1b0c3162e8ce882e0c8f308c5','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-244','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',259,'EXECUTED','3:77c03c05576961f7efebdfa10ae68119','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-245','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',260,'EXECUTED','3:d7d8dcaceb9793b0801c87eb2c94cd11','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-246','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',261,'EXECUTED','3:d395ea3ef18817dc23e750a1048cb4e1','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-247','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',262,'EXECUTED','3:4546bff7866082946f19e5d82ffc4d2e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-248','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',263,'EXECUTED','3:4e1071a7c1047f2d3b49778ce2f8bc40','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-249','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',264,'EXECUTED','3:fd6b7823929af9fded1f213d319eae13','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-25','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',23,'EXECUTED','3:b077d940b2b2558285d0e012565a8216','Create Table','',NULL,'2.0.1'),
 ('1227303685425-250','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',265,'EXECUTED','3:955129e5e6adf3723583c047eb33583d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-251','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',266,'EXECUTED','3:7a12c926e69a3d1a7e31da2b8d7123e5','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-252','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',267,'EXECUTED','3:eb8c61b5b792346af3d3f8732278260b','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-253','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:33',268,'EXECUTED','3:761e6c7fb13a82c6ab671039e5dc5646','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-254','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:34',269,'EXECUTED','3:9a2401574c95120e1f90d18fde428d10','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-255','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:34',270,'EXECUTED','3:cda3d0c5c91b85d9f4610554eabb331e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-256','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:34',271,'EXECUTED','3:ebf6243c66261bf0168e72ceccd0fdb8','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-257','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:34',272,'EXECUTED','3:8dc087b963a10a52a22312c3c995cec2','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-258','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:34',273,'EXECUTED','3:489d5e366070f6b2424b8e5a20d0118f','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-259','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:34',274,'EXECUTED','3:d8d2a1cfddf07123a8e6f52b1e71705d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-26','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',24,'EXECUTED','3:f12258fb2abe22275b3dadc9388db385','Create Table','',NULL,'2.0.1'),
 ('1227303685425-260','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:34',275,'EXECUTED','3:741f0c9e309b8515b713decb56ed6cb2','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-261','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:34',276,'EXECUTED','3:7034f7db7864956b7ca13ceb70cc8a92','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-262','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:34',277,'EXECUTED','3:e3a5995253a29723231b0912b971fb5a','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-263','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:35',278,'EXECUTED','3:b1d3718c15765d4a3bf89cb61376d3af','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-264','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:35',279,'EXECUTED','3:973683323e2ce886f07ef53a6836ad1e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-265','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:35',280,'EXECUTED','3:eff44c0cd530b852864042134ebccb47','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-266','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:35',281,'EXECUTED','3:2493248589e21293811c01cdb6c2fb87','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-267','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:35',282,'EXECUTED','3:ee636bdbc5839d7de0914648e1f07431','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-268','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:35',283,'EXECUTED','3:96710f10538b24f39e74ebc13eb6a3fc','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-269','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:35',284,'EXECUTED','3:5be60bacdaf2ab2d8a3103e36b32f6b9','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-27','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',25,'EXECUTED','3:3090d60e01f0d79558be2a0d4474bab2','Create Table','',NULL,'2.0.1'),
 ('1227303685425-270','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:35',285,'EXECUTED','3:35a1f2d06c31af2f02df3e7aea4d05a5','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-271','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:35',286,'EXECUTED','3:64d94dfba329b70a842a09b01b952850','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-272','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:35',287,'EXECUTED','3:0e3787e31b95815106e7e051b9c4a79a','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-273','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:35',288,'EXECUTED','3:00949a7bd184ed4ee994eabf4b98a41f','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-274','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:35',289,'EXECUTED','3:b63e3786d661815d2b7c63b277796fc9','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-275','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',290,'EXECUTED','3:7e0ac267990b953ff9efe8fece53b4dd','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-276','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',291,'EXECUTED','3:d66f7691a19406c215b3b4b4c5330775','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-277','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',292,'EXECUTED','3:9b7c8b6ab0b9f8ffde5e7853efa40db5','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-278','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',293,'EXECUTED','3:e5f95724ac551e5905c604e59af444f9','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-279','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',294,'EXECUTED','3:6b4a4c9072a92897562aa595c27aaae4','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-28','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',26,'EXECUTED','3:820861ebdc0a6d458460eaede7b89d02','Create Table','',NULL,'2.0.1'),
 ('1227303685425-280','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',295,'EXECUTED','3:8fb315815532eb73c13fac2dac763f69','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-281','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',296,'EXECUTED','3:1bed6131408c745505800d96130d3b30','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-282','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',297,'EXECUTED','3:ecf4138f4fd2d1e8be720381ac401623','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-283','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',298,'EXECUTED','3:00b414c29dcc3be9683f28ff3f2d9b20','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-284','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',299,'EXECUTED','3:b71dcc206a323ffa6ac4cd658de7b435','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-285','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',300,'EXECUTED','3:17423acbed3db4325d48d91e9f0e7147','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-286','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',301,'EXECUTED','3:2d8576bdbc9dd67137ba462b563022d8','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-287','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',302,'EXECUTED','3:6798c27ddf8ca72952030d6005422c1e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-288','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',303,'EXECUTED','3:b28ec2579454fa7a13fd3896420ad1ff','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-289','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',304,'EXECUTED','3:cbfff99e22305c5570cdc8fdb33f3542','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-29','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',27,'EXECUTED','3:1262b1f0d8fbe0faa2b997dc4e2d9f3e','Create Table','',NULL,'2.0.1'),
 ('1227303685425-290','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',305,'EXECUTED','3:66957ec2b3211869a1ad777de33e7983','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-291','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',306,'EXECUTED','3:18b7da760f632dc6baf910fe5001212d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-292','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:36',307,'EXECUTED','3:a1a914015e07b1637a9c655a9be3cfcd','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-293','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:37',308,'EXECUTED','3:5fedacb04729210c4a27bbfa2a3704f1','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-294','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:37',309,'EXECUTED','3:cf53101d520adb79fd1827819bcf0401','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-295','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:37',310,'EXECUTED','3:22b93c390cd6054f3dc8b62814d143cf','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-296','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:37',311,'EXECUTED','3:8b71fc2ae6be26a1ddc499cfc6e2cdba','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-297','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:37',312,'EXECUTED','3:d10fb06a37b1433a248b549ebae31e63','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-298','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:37',313,'EXECUTED','3:a3008458deed3c8c95f475395df6d788','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-299','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:37',314,'EXECUTED','3:b380ee7cce1b82a2f983d242b45c63b3','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-30','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',28,'EXECUTED','3:b344fe20f1c79ecc79687d659413f28f','Create Table','',NULL,'2.0.1'),
 ('1227303685425-300','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:37',315,'EXECUTED','3:01f02c28d4f52e712aad87873aaa40f8','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-301','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:37',316,'EXECUTED','3:adf03ccc09e8f37f827b8ffbf3afff83','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('1227303685425-31','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',29,'EXECUTED','3:d5f458ea72058575123569b4db6216c0','Create Table','',NULL,'2.0.1'),
 ('1227303685425-32','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',30,'EXECUTED','3:c8b2b1bb1eb7b3885c89f436210cc2d5','Create Table','',NULL,'2.0.1'),
 ('1227303685425-33','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',31,'EXECUTED','3:8124cf09cf5ae1ad5497c2b3879cfc20','Create Table','',NULL,'2.0.1'),
 ('1227303685425-34','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',32,'EXECUTED','3:932891c87e465fd79e869fe90f79d096','Create Table','',NULL,'2.0.1'),
 ('1227303685425-35','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',33,'EXECUTED','3:528a3f364b7acce00fcc4d49153a5626','Create Table','',NULL,'2.0.1'),
 ('1227303685425-36','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',34,'EXECUTED','3:54f0d6646a553e76886b9be84671cde5','Create Table','',NULL,'2.0.1'),
 ('1227303685425-37','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:17',35,'EXECUTED','3:b6a91bc894fef6c05f454b7332f777b9','Create Table','',NULL,'2.0.1'),
 ('1227303685425-39','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',36,'EXECUTED','3:8bb49b4cdedf592333d7879e4c1bff6e','Create Table','',NULL,'2.0.1'),
 ('1227303685425-4','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:16',3,'EXECUTED','3:2399825568bb21ac5c1d9372dcd27ae5','Create Table','',NULL,'2.0.1'),
 ('1227303685425-40','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',37,'EXECUTED','3:33f6e2acca9108ba1402b48e04433703','Create Table','',NULL,'2.0.1'),
 ('1227303685425-41','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',38,'EXECUTED','3:a65a25558c348c19863a0088ae031ad7','Create Table','',NULL,'2.0.1'),
 ('1227303685425-42','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',39,'EXECUTED','3:1264d39b6cb1fa81263df8f7a0819a5e','Create Table','',NULL,'2.0.1'),
 ('1227303685425-43','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',40,'EXECUTED','3:857890caafdf8d1d90c0edfa7727757d','Create Table','',NULL,'2.0.1'),
 ('1227303685425-44','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',41,'EXECUTED','3:af5db0fa12dbfa1d5185e46a2258a85a','Create Table','',NULL,'2.0.1'),
 ('1227303685425-45','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',42,'EXECUTED','3:36fb2673ce44e91d0073f196b0b02648','Create Table','',NULL,'2.0.1'),
 ('1227303685425-46','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',43,'EXECUTED','3:5b67939f133a563ee5f5827f9aa9c9be','Create Table','',NULL,'2.0.1'),
 ('1227303685425-47','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',44,'EXECUTED','3:41c5b2b054252c246a78bf76a78b5cb6','Create Table','',NULL,'2.0.1'),
 ('1227303685425-48','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',45,'EXECUTED','3:21a9216ce39f11b3a628c84a8805a9f0','Create Table','',NULL,'2.0.1'),
 ('1227303685425-49','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',46,'EXECUTED','3:53ccf09d39a474b771735ea62c287781','Create Table','',NULL,'2.0.1'),
 ('1227303685425-5','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:16',4,'EXECUTED','3:724250031b597a578cff5da78869e276','Create Table','',NULL,'2.0.1'),
 ('1227303685425-50','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',47,'EXECUTED','3:018a20cf81a2050d39e52dc5005fa869','Create Table','',NULL,'2.0.1'),
 ('1227303685425-51','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',48,'EXECUTED','3:03b6a8eff85819bfff1b6e0f6ba47291','Create Table','',NULL,'2.0.1'),
 ('1227303685425-52','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',49,'EXECUTED','3:c8f8131aff3d0b7d3d8ce207f50caf87','Create Table','',NULL,'2.0.1'),
 ('1227303685425-53','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',50,'EXECUTED','3:db8cb0a3c01beffbdf71bfc14908948b','Create Table','',NULL,'2.0.1'),
 ('1227303685425-54','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',51,'EXECUTED','3:7945d6d09bbd69ff1ec325015175a7ca','Create Table','',NULL,'2.0.1'),
 ('1227303685425-55','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',52,'EXECUTED','3:4dd8e21ae8f81cef037246da178cd670','Create Table','',NULL,'2.0.1'),
 ('1227303685425-56','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',53,'EXECUTED','3:9fcb808d4c751b4d65850479558590d9','Create Table','',NULL,'2.0.1'),
 ('1227303685425-57','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',54,'EXECUTED','3:b89df1f5527ec85e2292215a79685721','Create Table','',NULL,'2.0.1'),
 ('1227303685425-58','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',55,'EXECUTED','3:addef20155df8b06cd656349ad6132ab','Create Table','',NULL,'2.0.1'),
 ('1227303685425-59','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',56,'EXECUTED','3:188a92fbd0be9c326a7bdfc45f9bc552','Create Table','',NULL,'2.0.1'),
 ('1227303685425-6','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:16',5,'EXECUTED','3:2862ad1b205b7319c9d1a5f51fc8b400','Create Table','',NULL,'2.0.1'),
 ('1227303685425-60','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',57,'EXECUTED','3:96712556a96dffa91dd543499992481b','Create Table','',NULL,'2.0.1'),
 ('1227303685425-61','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',58,'EXECUTED','3:f0872372f4cd869e422c1cda2084f89b','Create Table','',NULL,'2.0.1'),
 ('1227303685425-62','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',59,'EXECUTED','3:55daf6d077eac0ef7e30e6395bc4bc68','Create Table','',NULL,'2.0.1'),
 ('1227303685425-63','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:18',60,'EXECUTED','3:cdc470c39dadd7cb1a1527a82ff737d3','Create Table','',NULL,'2.0.1'),
 ('1227303685425-64','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:19',61,'EXECUTED','3:e3eb66044ea03e417837e9c1668f28e3','Create Table','',NULL,'2.0.1'),
 ('1227303685425-65','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:19',62,'EXECUTED','3:f3a2f7801224c3f3410bc9f7a1cfebff','Create Table','',NULL,'2.0.1'),
 ('1227303685425-66','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:19',63,'EXECUTED','3:93e2d359d5f6c38b95dfd47dce687c9c','Create Table','',NULL,'2.0.1'),
 ('1227303685425-67','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:19',64,'EXECUTED','3:ec491d9f71a9e334e005a4f85c9ffdc6','Create Table','',NULL,'2.0.1'),
 ('1227303685425-68','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:19',65,'EXECUTED','3:40096bd3e62db8377ce4f0a1fcea444e','Create Table','',NULL,'2.0.1'),
 ('1227303685425-7','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:16',6,'EXECUTED','3:15914ae8698b83841f0483af7477ac96','Create Table','',NULL,'2.0.1'),
 ('1227303685425-70','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:19',66,'EXECUTED','3:0df5ce250df07062c43119d18fc2a85b','Create Table','',NULL,'2.0.1'),
 ('1227303685425-71','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:19',67,'EXECUTED','3:06e7ba94af07838a3d2ebb98816412a3','Create Table','',NULL,'2.0.1'),
 ('1227303685425-72','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:19',68,'EXECUTED','3:14910dbd0e4fb5d0f571aa4c03a049ca','Create Table','',NULL,'2.0.1'),
 ('1227303685425-73','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:20',89,'EXECUTED','3:33d08000805c4b9d7db06556961553b1','Add Primary Key','',NULL,'2.0.1'),
 ('1227303685425-75','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:20',90,'EXECUTED','3:f2b0a95b4015b54d38c721906abc1fdb','Add Primary Key','',NULL,'2.0.1'),
 ('1227303685425-77','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:20',91,'EXECUTED','3:bdde9c0d7374a3468a94426199b0d930','Add Primary Key','',NULL,'2.0.1'),
 ('1227303685425-78','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:20',92,'EXECUTED','3:6fb4014a9a3ecc6ed09a896936b8342d','Add Primary Key','',NULL,'2.0.1'),
 ('1227303685425-79','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',93,'EXECUTED','3:77e1d7c49e104435d10d90cc70e006e3','Add Primary Key','',NULL,'2.0.1'),
 ('1227303685425-81','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',94,'EXECUTED','3:a5871abe4cdc3d8d9390a9b4ab0d0776','Add Primary Key','',NULL,'2.0.1'),
 ('1227303685425-82','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',95,'EXECUTED','3:2f7eab1e485fd5a653af8799a84383b4','Add Primary Key','',NULL,'2.0.1'),
 ('1227303685425-83','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',96,'EXECUTED','3:60ca763d5ac940b3bc189e2f28270bd8','Add Primary Key','',NULL,'2.0.1'),
 ('1227303685425-84','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',97,'EXECUTED','3:901f48ab4c9e3a702fc0b38c5e724a5e','Add Primary Key','',NULL,'2.0.1'),
 ('1227303685425-85','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',99,'EXECUTED','3:5544801862c8f21461acf9a22283ccab','Create Index','',NULL,'2.0.1'),
 ('1227303685425-86','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',100,'EXECUTED','3:70591fc2cd8ce2e7bda36b407bbcaa86','Create Index','',NULL,'2.0.1'),
 ('1227303685425-87','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',101,'EXECUTED','3:35c206a147d28660ffee5f87208f1f6b','Create Index','',NULL,'2.0.1'),
 ('1227303685425-88','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',102,'EXECUTED','3:d399797580e14e7d67c1c40637314476','Create Index','',NULL,'2.0.1'),
 ('1227303685425-89','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',103,'EXECUTED','3:138fa4373fe05e63fe5f923cf3c17e69','Create Index','',NULL,'2.0.1'),
 ('1227303685425-9','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:16',7,'EXECUTED','3:8e21fd558a74cbccc305182b27714cd7','Create Table','',NULL,'2.0.1'),
 ('1227303685425-90','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',104,'EXECUTED','3:4b60e13b8e209c2b5b1f981f4c28fc1b','Create Index','',NULL,'2.0.1'),
 ('1227303685425-91','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',105,'EXECUTED','3:f9c13df6f50d1e7c1fad36faa020d7a6','Create Index','',NULL,'2.0.1'),
 ('1227303685425-92','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',106,'EXECUTED','3:c24d9e0d28b3a208dbe2fc1cfaf23720','Create Index','',NULL,'2.0.1'),
 ('1227303685425-93','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',107,'EXECUTED','3:ae9beae273f9502bc01580754e0f2bdf','Create Index','',NULL,'2.0.1'),
 ('1227303685425-94','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:21',108,'EXECUTED','3:39d98e23d1480b677bc8f2341711756b','Create Index','',NULL,'2.0.1'),
 ('1227303685425-95','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:22',109,'EXECUTED','3:16ece63cd24c4c5048356cc2854235e1','Create Index','',NULL,'2.0.1'),
 ('1227303685425-96','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:22',110,'EXECUTED','3:de9943f6a1500bd3f94cb7e0c1d3bde7','Create Index','',NULL,'2.0.1'),
 ('1227303685425-97','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:22',111,'EXECUTED','3:c0fac38fa4928378abe6f47bd78926b1','Create Index','',NULL,'2.0.1'),
 ('1227303685425-98','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:22',112,'EXECUTED','3:4c8938f3ea457f5f4f4936e9cbaf898b','Create Index','',NULL,'2.0.1'),
 ('1227303685425-99','ben (generated)','liquibase-schema-only.xml','2013-11-04 16:27:22',113,'EXECUTED','3:d331ce5f04aca9071c5b897396d81098','Create Index','',NULL,'2.0.1'),
 ('1231200030538-332456','dkayiwa','liquibase.xml','2013-11-08 10:34:20',10496,'EXECUTED','3:a4e846eae5e162fec9ae1308ec5126c1','Insert Row','',NULL,'2.0.5'),
 ('1641256230538-331141','surangak','liquibase.xml','2013-11-08 10:34:20',10498,'EXECUTED','3:3cc71d028bf8068887158ecefbdde254','Update Data','',NULL,'2.0.5'),
 ('1641256230538-332231','dkayiwa','liquibase.xml','2013-11-08 10:34:20',10489,'EXECUTED','3:24b690f757ef80376e05428387e16b51','Insert Row','',NULL,'2.0.5'),
 ('1656846211232-332123','surangak','liquibase.xml','2013-11-19 12:38:29',10501,'EXECUTED','3:406a7886d3d624e2342a0885dcf6a07c','Modify data type','Modify column date* columns from VARCHAR to TIMESTAMP',NULL,'2.0.1'),
 ('1656846211232-332251','surangak','liquibase.xml','2013-11-19 12:38:29',10500,'EXECUTED','3:7a3053e5ebc771027cd85a32cde7b123','Modify data type','Modify column date* columns from VARCHAR to TIMESTAMP',NULL,'2.0.1'),
 ('1656846212538-331141','surangak','liquibase.xml','2013-11-19 12:38:29',10499,'EXECUTED','3:2ea083350ad42bb5654e6c752773698e','Modify data type','Modify column date* columns from VARCHAR to TIMESTAMP',NULL,'2.0.1'),
 ('2','upul','liquibase-update-to-latest.xml','2013-11-04 16:28:00',10045,'MARK_RAN','3:b1811e5e43321192b275d6e2fe2fa564','Add Foreign Key Constraint','Create the foreign key from the privilege required for to edit\n			a person attribute type and the privilege.privilege column',NULL,'2.0.1'),
 ('200805281223','bmckown','liquibase-update-to-latest.xml','2013-11-04 16:28:01',10047,'MARK_RAN','3:b1fc37f9ec96eac9203f0808c2f4ac26','Create Table, Add Foreign Key Constraint','Create the concept_complex table',NULL,'2.0.1'),
 ('200805281224','bmckown','liquibase-update-to-latest.xml','2013-11-04 16:28:01',10048,'MARK_RAN','3:ea32453830c2215bdb209770396002e7','Add Column','Adding the value_complex column to obs.  This may take a long time if you have a large number of observations.',NULL,'2.0.1'),
 ('200805281225','bmckown','liquibase-update-to-latest.xml','2013-11-04 16:28:01',10049,'MARK_RAN','3:5281031bcc075df3b959e94da4adcaa9','Insert Row','Adding a \'complex\' Concept Datatype',NULL,'2.0.1'),
 ('200805281226','bmckown','liquibase-update-to-latest.xml','2013-11-04 16:28:01',10050,'MARK_RAN','3:9a49a3d002485f3a77134d98fb7c8cd8','Drop Table (x2)','Dropping the mimetype and complex_obs tables as they aren\'t needed in the new complex obs setup',NULL,'2.0.1'),
 ('200809191226','smbugua','liquibase-update-to-latest.xml','2013-11-04 16:28:01',10051,'MARK_RAN','3:eed0aa27b44ecf668c81e457d99fa7de','Add Column','Adding the hl7 archive message_state column so that archives can be tracked\n			(preCondition database_version check in place because this change was in the old format in trunk for a while)',NULL,'2.0.1'),
 ('200809191927','smbugua','liquibase-update-to-latest.xml','2013-11-04 16:28:01',10052,'MARK_RAN','3:f0e4fab64749e42770e62e9330c2d288','Rename Column, Modify Column','Adding the hl7 archive message_state column so that archives can be tracked',NULL,'2.0.1'),
 ('200811261102','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:01',10046,'EXECUTED','3:158dd028359ebfd4f1c9bf2e76a5e143','Update Data','Fix field property for new Tribe person attribute',NULL,'2.0.1'),
 ('200901101524','Knoll_Frank','liquibase-update-to-latest.xml','2013-11-04 16:28:01',10053,'EXECUTED','3:feb4a087d13657164e5c3bc787b7f83f','Modify Column','Changing datatype of drug.retire_reason from DATETIME to varchar(255)',NULL,'2.0.1'),
 ('200901130950','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:01',10054,'EXECUTED','3:f1e5e7124bdb4f7378866fdb691e2780','Delete Data (x2)','Remove Manage Tribes and View Tribes privileges from all roles',NULL,'2.0.1'),
 ('200901130951','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:01',10055,'EXECUTED','3:54ac8683819837cc04f1a16b6311d668','Delete Data (x2)','Remove Manage Mime Types, View Mime Types, and Purge Mime Types privilege',NULL,'2.0.1'),
 ('200901161126','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:01',10056,'EXECUTED','3:871b9364dd87b6bfcc0005f40b6eb399','Delete Data','Removed the database_version global property',NULL,'2.0.1'),
 ('20090121-0949','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:01',10057,'EXECUTED','3:8639e35e0238019af2f9e326dd5cbc22','Custom SQL','Switched the default xslt to use PV1-19 instead of PV1-1',NULL,'2.0.1'),
 ('20090122-0853','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:01',10058,'EXECUTED','3:4903c6f81f0309313013851f09a26b85','Custom SQL, Add Lookup Table, Drop Foreign Key Constraint, Delete Data (x2), Drop Table','Remove duplicate concept name tags',NULL,'2.0.1'),
 ('20090123-0305','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:04',10059,'MARK_RAN','3:48cdf2b28fcad687072ac8133e46cba6','Add Unique Constraint','Add unique constraint to the tags table',NULL,'2.0.1'),
 ('20090214-2246','isherman','liquibase-update-to-latest.xml','2013-11-04 16:28:04',10065,'EXECUTED','3:d16c607266238df425db61908e7c8745','Custom SQL','Add weight and cd4 to patientGraphConcepts user property (mysql specific)',NULL,'2.0.1'),
 ('20090214-2247','isherman','liquibase-update-to-latest.xml','2013-11-04 16:28:04',10066,'MARK_RAN','3:e4eeb4a09c2ab695bbde832cd7b6047d','Custom SQL','Add weight and cd4 to patientGraphConcepts user property (using standard sql)',NULL,'2.0.1'),
 ('200902142212','ewolodzko','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10244,'MARK_RAN','3:df93fa2841295b29a0fcd4225c46d1a3','Add Column','Add a sortWeight field to PersonAttributeType',NULL,'2.0.1'),
 ('200902142213','ewolodzko','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10245,'EXECUTED','3:ace82a1ecb3a0c3246e39f0bebe38423','Update Data','Add default sortWeights to all current PersonAttributeTypes',NULL,'2.0.1'),
 ('20090224-1002-create-visit_type','dkayiwa','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10385,'MARK_RAN','3:ea3c0b323da2d51cf43e982177eace96','Create Table, Add Foreign Key Constraint (x3)','Create visit type table',NULL,'2.0.1'),
 ('20090224-1229','Keelhaul+bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:04',10060,'MARK_RAN','3:f8433194bcb29073c17c7765ce61aab2','Create Table, Add Foreign Key Constraint (x2)','Add location tags table',NULL,'2.0.1'),
 ('20090224-1250','Keelhaul+bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:04',10061,'MARK_RAN','3:8935a56fac2ad91275248d4675c2c090','Create Table, Add Foreign Key Constraint (x2), Add Primary Key','Add location tag map table',NULL,'2.0.1'),
 ('20090224-1256','Keelhaul+bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:04',10062,'MARK_RAN','3:9c0e7238dd1daad9edff381ba22a3ada','Add Column, Add Foreign Key Constraint','Add parent_location column to location table',NULL,'2.0.1'),
 ('20090225-1551','dthomas','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10001,'MARK_RAN','3:a3aed1685bd1051a8c4fae0eab925954',NULL,NULL,NULL,NULL),
 ('20090301-1259','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:04',10064,'EXECUTED','3:21f2ac06dee26613b73003cd1f247ea8','Update Data (x2)','Fixes the description for name layout global property',NULL,'2.0.1'),
 ('20090316-1008','vanand','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10000,'MARK_RAN','3:baa49982f1106c65ba33c845bba149b3',NULL,NULL,NULL,NULL),
 ('20090316-1008-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:32:19',10433,'EXECUTED','3:aeeb6c14cd22ffa121a2582e04025f5a','Modify Column (x36)','(Fixed)Changing from smallint to BOOLEAN type on BOOLEAN properties',NULL,'2.0.1'),
 ('200903210905','mseaton','liquibase-update-to-latest.xml','2013-11-04 16:28:04',10067,'MARK_RAN','3:720bb7a3f71f0c0a911d3364e55dd72f','Create Table, Add Foreign Key Constraint (x3)','Add a table to enable generic storage of serialized objects',NULL,'2.0.1'),
 ('200903210905-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:28:04',10068,'EXECUTED','3:a11519f50deeece1f9760d3fc1ac3f05','Modify Column','(Fixed)Add a table to enable generic storage of serialized objects',NULL,'2.0.1'),
 ('20090402-1515-38-cohort','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:09',10073,'MARK_RAN','3:5c65821ef168d9e8296466be5990ae08','Add Column','Adding \"uuid\" column to cohort table',NULL,'2.0.1');
INSERT INTO `liquibasechangelog` (`ID`,`AUTHOR`,`FILENAME`,`DATEEXECUTED`,`ORDEREXECUTED`,`EXECTYPE`,`MD5SUM`,`DESCRIPTION`,`COMMENTS`,`TAG`,`LIQUIBASE`) VALUES 
 ('20090402-1515-38-concept','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:09',10074,'MARK_RAN','3:8004d09d6e2a34623b8d0a13d6c38dc4','Add Column','Adding \"uuid\" column to concept table',NULL,'2.0.1'),
 ('20090402-1515-38-concept_answer','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:09',10075,'MARK_RAN','3:adf3f4ebf7e0eb55eb6927dea7ce2a49','Add Column','Adding \"uuid\" column to concept_answer table',NULL,'2.0.1'),
 ('20090402-1515-38-concept_class','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:09',10076,'MARK_RAN','3:f39e190a2e12c7a6163a0d8a82544228','Add Column','Adding \"uuid\" column to concept_class table',NULL,'2.0.1'),
 ('20090402-1515-38-concept_datatype','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:09',10077,'MARK_RAN','3:d68b3f2323626fee7b433f873a019412','Add Column','Adding \"uuid\" column to concept_datatype table',NULL,'2.0.1'),
 ('20090402-1515-38-concept_description','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:09',10078,'MARK_RAN','3:7d043672ede851c5dcd717171f953c75','Add Column','Adding \"uuid\" column to concept_description table',NULL,'2.0.1'),
 ('20090402-1515-38-concept_map','bwolfe','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10002,'MARK_RAN','3:c1884f56bd70a205b86e7c4038e6c6f9',NULL,NULL,NULL,NULL),
 ('20090402-1515-38-concept_name','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10079,'MARK_RAN','3:822888c5ba1132f6783fbd032c21f238','Add Column','Adding \"uuid\" column to concept_name table',NULL,'2.0.1'),
 ('20090402-1515-38-concept_name_tag','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10080,'MARK_RAN','3:dcb584d414ffd8133c97e42585bd34cd','Add Column','Adding \"uuid\" column to concept_name_tag table',NULL,'2.0.1'),
 ('20090402-1515-38-concept_proposal','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10081,'MARK_RAN','3:fe19ecccb704331741c227aa72597789','Add Column','Adding \"uuid\" column to concept_proposal table',NULL,'2.0.1'),
 ('20090402-1515-38-concept_set','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10082,'MARK_RAN','3:cdc72e16eaec2244c09e9e2fedf5806b','Add Column','Adding \"uuid\" column to concept_set table',NULL,'2.0.1'),
 ('20090402-1515-38-concept_source','bwolfe','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10003,'MARK_RAN','3:ad101415b93eaf653871eddd4fe4fc17',NULL,NULL,NULL,NULL),
 ('20090402-1515-38-concept_state_conversion','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10083,'MARK_RAN','3:5ce8a6cdbfa8742b033b0b1c12e4cd42','Add Column','Adding \"uuid\" column to concept_state_conversion table',NULL,'2.0.1'),
 ('20090402-1515-38-drug','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10084,'MARK_RAN','3:6869bd44f51cb7f63f758fbd8a7fe156','Add Column','Adding \"uuid\" column to drug table',NULL,'2.0.1'),
 ('20090402-1515-38-encounter','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10085,'MARK_RAN','3:0808491f7ec59827a0415f2949b9d90e','Add Column','Adding \"uuid\" column to encounter table',NULL,'2.0.1'),
 ('20090402-1515-38-encounter_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10086,'MARK_RAN','3:9aaac835f4d9579386990d4990ffb9d6','Add Column','Adding \"uuid\" column to encounter_type table',NULL,'2.0.1'),
 ('20090402-1515-38-field','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10087,'MARK_RAN','3:dfee5fe509457ef12b14254bab9e6df5','Add Column','Adding \"uuid\" column to field table',NULL,'2.0.1'),
 ('20090402-1515-38-field_answer','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10088,'MARK_RAN','3:c378494d6e9ae45b278c726256619cd7','Add Column','Adding \"uuid\" column to field_answer table',NULL,'2.0.1'),
 ('20090402-1515-38-field_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10089,'MARK_RAN','3:dfb47f0b85d5bdad77f3a15cc4d180ec','Add Column','Adding \"uuid\" column to field_type table',NULL,'2.0.1'),
 ('20090402-1515-38-form','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10090,'MARK_RAN','3:eb707ff99ed8ca2945a43175b904dea4','Add Column','Adding \"uuid\" column to form table',NULL,'2.0.1'),
 ('20090402-1515-38-form_field','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10091,'MARK_RAN','3:635701ccda0484966f45f0e617119100','Add Column','Adding \"uuid\" column to form_field table',NULL,'2.0.1'),
 ('20090402-1515-38-global_property','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10092,'MARK_RAN','3:1c62ba666b60eaa88ee3a90853f3bf59','Add Column','Adding \"uuid\" column to global_property table',NULL,'2.0.1'),
 ('20090402-1515-38-hl7_in_archive','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10093,'MARK_RAN','3:9c5015280eff821924416112922fd94d','Add Column','Adding \"uuid\" column to hl7_in_archive table',NULL,'2.0.1'),
 ('20090402-1515-38-hl7_in_error','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10094,'MARK_RAN','3:35b94fc079e6de9ada4329a7bbc55645','Add Column','Adding \"uuid\" column to hl7_in_error table',NULL,'2.0.1'),
 ('20090402-1515-38-hl7_in_queue','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10095,'MARK_RAN','3:494d9eaaed055d0c5af4b4d85db2095d','Add Column','Adding \"uuid\" column to hl7_in_queue table',NULL,'2.0.1'),
 ('20090402-1515-38-hl7_source','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:10',10096,'MARK_RAN','3:8bc9839788ef5ab415ccf020eb04a1f7','Add Column','Adding \"uuid\" column to hl7_source table',NULL,'2.0.1'),
 ('20090402-1515-38-location','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10097,'MARK_RAN','3:7e6b762f813310c72026677d540dee57','Add Column','Adding \"uuid\" column to location table',NULL,'2.0.1'),
 ('20090402-1515-38-location_tag','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10098,'MARK_RAN','3:6a94a67e776662268d42f09cf7c66ac0','Add Column','Adding \"uuid\" column to location_tag table',NULL,'2.0.1'),
 ('20090402-1515-38-note','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10099,'MARK_RAN','3:f0fd7b6750d07c973aad667b170cdfa8','Add Column','Adding \"uuid\" column to note table',NULL,'2.0.1'),
 ('20090402-1515-38-notification_alert','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10100,'MARK_RAN','3:f2865558fb76c7584f6e86786b0ffdea','Add Column','Adding \"uuid\" column to notification_alert table',NULL,'2.0.1'),
 ('20090402-1515-38-notification_template','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10101,'MARK_RAN','3:c05536d99eb2479211cb10010d48a2e9','Add Column','Adding \"uuid\" column to notification_template table',NULL,'2.0.1'),
 ('20090402-1515-38-obs','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10102,'MARK_RAN','3:ba99d7eccba2185e9d5ebab98007e577','Add Column','Adding \"uuid\" column to obs table',NULL,'2.0.1'),
 ('20090402-1515-38-orders','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10104,'MARK_RAN','3:732a2d4fd91690d544f0c63bdb65819f','Add Column','Adding \"uuid\" column to orders table',NULL,'2.0.1'),
 ('20090402-1515-38-order_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10103,'MARK_RAN','3:137552884c5eb5af4c3f77c90df514cb','Add Column','Adding \"uuid\" column to order_type table',NULL,'2.0.1'),
 ('20090402-1515-38-patient_identifier','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10105,'MARK_RAN','3:1a9ddcd8997bcf1a9668051d397e41c1','Add Column','Adding \"uuid\" column to patient_identifier table',NULL,'2.0.1'),
 ('20090402-1515-38-patient_identifier_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10106,'MARK_RAN','3:6170d6caa73320fd2433fba0a16e8029','Add Column','Adding \"uuid\" column to patient_identifier_type table',NULL,'2.0.1'),
 ('20090402-1515-38-patient_program','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10107,'MARK_RAN','3:8fb284b435669717f4b5aaa66e61fc10','Add Column','Adding \"uuid\" column to patient_program table',NULL,'2.0.1'),
 ('20090402-1515-38-patient_state','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10108,'MARK_RAN','3:b67eb1bbd3e2912a646f56425c38631f','Add Column','Adding \"uuid\" column to patient_state table',NULL,'2.0.1'),
 ('20090402-1515-38-person','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10109,'MARK_RAN','3:2b89eb77976b9159717e9d7b83c34cf1','Add Column','Adding \"uuid\" column to person table',NULL,'2.0.1'),
 ('20090402-1515-38-person_address','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10110,'MARK_RAN','3:cfdb17b16b6d15477bc72d4d19ac3f29','Add Column','Adding \"uuid\" column to person_address table',NULL,'2.0.1'),
 ('20090402-1515-38-person_attribute','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:11',10111,'MARK_RAN','3:2f6b7fa688987b32d99cda348c6f6c46','Add Column','Adding \"uuid\" column to person_attribute table',NULL,'2.0.1'),
 ('20090402-1515-38-person_attribute_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10112,'MARK_RAN','3:38d4dce320f2fc35db9dfcc2eafc093e','Add Column','Adding \"uuid\" column to person_attribute_type table',NULL,'2.0.1'),
 ('20090402-1515-38-person_name','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10113,'MARK_RAN','3:339f02d6797870f9e7dd704f093b088c','Add Column','Adding \"uuid\" column to person_name table',NULL,'2.0.1'),
 ('20090402-1515-38-privilege','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10114,'MARK_RAN','3:41f52c4340fdc9f0825ea9660edea8ec','Add Column','Adding \"uuid\" column to privilege table',NULL,'2.0.1'),
 ('20090402-1515-38-program','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10115,'MARK_RAN','3:a72f80159cdbd576906cd3b9069d425b','Add Column','Adding \"uuid\" column to program table',NULL,'2.0.1'),
 ('20090402-1515-38-program_workflow','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10116,'MARK_RAN','3:c69183f7e1614d5a338c0d0944f1e754','Add Column','Adding \"uuid\" column to program_workflow table',NULL,'2.0.1'),
 ('20090402-1515-38-program_workflow_state','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10117,'MARK_RAN','3:e25b0fa351bb667af3ff562855f66bb6','Add Column','Adding \"uuid\" column to program_workflow_state table',NULL,'2.0.1'),
 ('20090402-1515-38-relationship','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10118,'MARK_RAN','3:95407167e9f4984de1d710a83371ebd1','Add Column','Adding \"uuid\" column to relationship table',NULL,'2.0.1'),
 ('20090402-1515-38-relationship_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10119,'MARK_RAN','3:f8755b127c004d11a43bfd6558be01b7','Add Column','Adding \"uuid\" column to relationship_type table',NULL,'2.0.1'),
 ('20090402-1515-38-report_object','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10120,'MARK_RAN','3:b7ce0784e817be464370a3154fd4aa9c','Add Column','Adding \"uuid\" column to report_object table',NULL,'2.0.1'),
 ('20090402-1515-38-report_schema_xml','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10121,'MARK_RAN','3:ce7ae79a3e3ce429a56fa658c48889b5','Add Column','Adding \"uuid\" column to report_schema_xml table',NULL,'2.0.1'),
 ('20090402-1515-38-role','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10122,'MARK_RAN','3:f33887a0b51ab366d414e16202cf55db','Add Column','Adding \"uuid\" column to role table',NULL,'2.0.1'),
 ('20090402-1515-38-serialized_object','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10123,'MARK_RAN','3:341cfbdff8ebf188d526bf3348619dcc','Add Column','Adding \"uuid\" column to serialized_object table',NULL,'2.0.1'),
 ('20090402-1516-cohort','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10124,'EXECUTED','3:110084035197514c8d640b915230cf72','Update Data','Generating UUIDs for all rows in cohort table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-concept','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10125,'EXECUTED','3:a44bc743cb837d88f7371282f3a5871e','Update Data','Generating UUIDs for all rows in concept table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-concept_answer','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10126,'EXECUTED','3:f01d7278b153fa10a7d741607501ae1e','Update Data','Generating UUIDs for all rows in concept_answer table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-concept_class','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10127,'EXECUTED','3:786f0ec8beec453ea9487f2e77f9fb4d','Update Data','Generating UUIDs for all rows in concept_class table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-concept_datatype','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10128,'EXECUTED','3:b828e9851365ec70531dabd250374989','Update Data','Generating UUIDs for all rows in concept_datatype table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-concept_description','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10129,'EXECUTED','3:37dbfc43c73553c9c9ecf11206714cc4','Update Data','Generating UUIDs for all rows in concept_description table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-concept_map','bwolfe','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10004,'MARK_RAN','3:e843f99c0371aabee21ca94fcef01f39',NULL,NULL,NULL,NULL),
 ('20090402-1516-concept_name','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10130,'EXECUTED','3:dd414ae9367287c9c03342a79abd1d62','Update Data','Generating UUIDs for all rows in concept_name table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-concept_name_tag','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10131,'EXECUTED','3:cd7b5d0ceeb90b2254708b44c10d03e8','Update Data','Generating UUIDs for all rows in concept_name_tag table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-concept_proposal','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10132,'EXECUTED','3:fb1cfa9c5decbafc3293f3dd1d87ff2b','Update Data','Generating UUIDs for all rows in concept_proposal table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-concept_set','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10133,'EXECUTED','3:3b7f3851624014e740f89bc9a431feaa','Update Data','Generating UUIDs for all rows in concept_set table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-concept_source','bwolfe','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10005,'MARK_RAN','3:53da91ae3e39d7fb7ebca91df3bfd9a6',NULL,NULL,NULL,NULL),
 ('20090402-1516-concept_state_conversion','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10134,'EXECUTED','3:23197d24e498ad86d4e001b183cc0c6b','Update Data','Generating UUIDs for all rows in concept_state_conversion table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-drug','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10135,'EXECUTED','3:40b47df80bd425337b7bdd8b41497967','Update Data','Generating UUIDs for all rows in drug table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-encounter','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:12',10136,'EXECUTED','3:40146708b71d86d4c8c5340767a98f5e','Update Data','Generating UUIDs for all rows in encounter table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-encounter_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10137,'EXECUTED','3:738c6b6244a84fc8e6d582bcd472ffe6','Update Data','Generating UUIDs for all rows in encounter_type table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-field','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10138,'EXECUTED','3:98d2a1550e867e4ef303a4cc47ed904d','Update Data','Generating UUIDs for all rows in field table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-field_answer','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10139,'EXECUTED','3:82bdfe361286d261724eef97dd89e358','Update Data','Generating UUIDs for all rows in field_answer table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-field_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10140,'EXECUTED','3:19a8d007f6147651240ebb9539d3303a','Update Data','Generating UUIDs for all rows in field_type table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-form','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10141,'EXECUTED','3:026ddf1c9050c7367d4eb57dd4105322','Update Data','Generating UUIDs for all rows in form table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-form_field','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10142,'EXECUTED','3:a8b0bcdb35830c2badfdcb9b1cfdd3b5','Update Data','Generating UUIDs for all rows in form_field table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-global_property','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10143,'EXECUTED','3:75a5b4a9473bc9c6bfbabf8e77b0cda7','Update Data','Generating UUIDs for all rows in global_property table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-hl7_in_archive','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10144,'EXECUTED','3:09891436d8ea0ad14f7b52fd05daa237','Update Data','Generating UUIDs for all rows in hl7_in_archive table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-hl7_in_error','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10145,'EXECUTED','3:8d276bbd8bf9d9d1c64756f37ef91ed3','Update Data','Generating UUIDs for all rows in hl7_in_error table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-hl7_in_queue','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10146,'EXECUTED','3:25e8f998171accd46860717f93690ccc','Update Data','Generating UUIDs for all rows in hl7_in_queue table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-hl7_source','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10147,'EXECUTED','3:45c06e034d7158a0d09afae60c4c83d6','Update Data','Generating UUIDs for all rows in hl7_source table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-location','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10148,'EXECUTED','3:fce0f7eaab989f2ff9664fc66d6b8419','Update Data','Generating UUIDs for all rows in location table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-location_tag','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10149,'EXECUTED','3:50f26d1376ea108bbb65fd4d0633e741','Update Data','Generating UUIDs for all rows in location_tag table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-note','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10150,'EXECUTED','3:f5a0eea2a7c59fffafa674de4356e621','Update Data','Generating UUIDs for all rows in note table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-notification_alert','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10151,'EXECUTED','3:481fbab9bd53449903ac193894adbc28','Update Data','Generating UUIDs for all rows in notification_alert table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-notification_template','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10152,'EXECUTED','3:a4a2990465c4c99747f83ea880cac46a','Update Data','Generating UUIDs for all rows in notification_template table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-obs','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10153,'EXECUTED','3:26d80fdd889922821244f84e3f8039e7','Update Data','Generating UUIDs for all rows in obs table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-orders','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10155,'EXECUTED','3:ec3bc80540d78f416e1d4eef62e8e15a','Update Data','Generating UUIDs for all rows in orders table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-order_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10154,'EXECUTED','3:cae66b98b889c7ee1c8d6ab270a8d0d5','Update Data','Generating UUIDs for all rows in order_type table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-patient_identifier','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10156,'EXECUTED','3:647906cc7cf1fde9b7644b8f2541664f','Update Data','Generating UUIDs for all rows in patient_identifier table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-patient_identifier_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10157,'EXECUTED','3:85f8db0310c15a74b17e968c7730ae12','Update Data','Generating UUIDs for all rows in patient_identifier_type table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-patient_program','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10158,'EXECUTED','3:576b7db39f0212f8e92b6f4e1844ea30','Update Data','Generating UUIDs for all rows in patient_program table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-patient_state','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10159,'EXECUTED','3:250eab0f97fc4eeb4f1a930fbccfcf08','Update Data','Generating UUIDs for all rows in patient_state table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-person','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10160,'EXECUTED','3:cedc8bcd77ade51558fb2d12916e31a4','Update Data','Generating UUIDs for all rows in person table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-person_address','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10161,'EXECUTED','3:0f817424ca41e5c5b459591d6e18b3c6','Update Data','Generating UUIDs for all rows in person_address table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-person_attribute','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10162,'EXECUTED','3:7f9e09b1267c4a787a9d3e37acfd5746','Update Data','Generating UUIDs for all rows in person_attribute table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-person_attribute_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10163,'EXECUTED','3:1e5f84054b7b7fdf59673e2260f48d9d','Update Data','Generating UUIDs for all rows in person_attribute_type table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-person_name','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10164,'EXECUTED','3:f827da2c097b01ca9073c258b19e9540','Update Data','Generating UUIDs for all rows in person_name table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-privilege','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10165,'EXECUTED','3:2ab150a53c91ded0c5b53fa99fde4ba2','Update Data','Generating UUIDs for all rows in privilege table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-program','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10166,'EXECUTED','3:132b63f2efcf781187602e043122e7ff','Update Data','Generating UUIDs for all rows in program table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-program_workflow','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10167,'EXECUTED','3:d945359ed4bb6cc6a21f4554a0c50a33','Update Data','Generating UUIDs for all rows in program_workflow table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-program_workflow_state','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10168,'EXECUTED','3:4bc093882ac096562d63562ac76a1ffa','Update Data','Generating UUIDs for all rows in program_workflow_state table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-relationship','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10169,'EXECUTED','3:25e22c04ada4808cc31fd48f23703333','Update Data','Generating UUIDs for all rows in relationship table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-relationship_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10170,'EXECUTED','3:562ad77e9453595c9cd22a2cdde3cc41','Update Data','Generating UUIDs for all rows in relationship_type table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-report_object','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10171,'EXECUTED','3:8531f740c64a0d1605225536c1be0860','Update Data','Generating UUIDs for all rows in report_object table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-report_schema_xml','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10172,'EXECUTED','3:cd9efe4d62f2754b057d2d409d6e826a','Update Data','Generating UUIDs for all rows in report_schema_xml table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-role','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10173,'EXECUTED','3:f75bfc36ad13cb9324b9520804a60141','Update Data','Generating UUIDs for all rows in role table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1516-serialized_object','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:13',10174,'EXECUTED','3:c809b71d2444a8a8e2c5e5574d344c82','Update Data','Generating UUIDs for all rows in serialized_object table via built in uuid function.',NULL,'2.0.1'),
 ('20090402-1517','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:25',10183,'MARK_RAN','3:4edd135921eb263d4811cf1c22ef4846','Custom Change','Adding UUIDs to all rows in all columns via a java class. (This will take a long time on large databases)',NULL,'2.0.1'),
 ('20090402-1518','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:26',10184,'MARK_RAN','3:a9564fc8de85d37f4748a3fa1e69281c','Add Not-Null Constraint (x52)','Now that UUID generation is done, set the uuid columns to not \"NOT NULL\"',NULL,'2.0.1'),
 ('20090402-1519-cohort','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:29',10185,'EXECUTED','3:260c435f1cf3e3f01d953d630c7a578b','Create Index','Creating unique index on cohort.uuid column',NULL,'2.0.1'),
 ('20090402-1519-concept','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:33',10186,'EXECUTED','3:9e363ee4b39e7fdfb547e3a51ad187c7','Create Index','Creating unique index on concept.uuid column',NULL,'2.0.1'),
 ('20090402-1519-concept_answer','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:37',10187,'EXECUTED','3:34b049a3fd545928760968beb1e98e00','Create Index','Creating unique index on concept_answer.uuid column',NULL,'2.0.1'),
 ('20090402-1519-concept_class','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:39',10188,'EXECUTED','3:0fc95dccef2343850adb1fe49d60f3c3','Create Index','Creating unique index on concept_class.uuid column',NULL,'2.0.1'),
 ('20090402-1519-concept_datatype','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:42',10189,'EXECUTED','3:0cf065b0f780dc2eeca994628af49a34','Create Index','Creating unique index on concept_datatype.uuid column',NULL,'2.0.1'),
 ('20090402-1519-concept_description','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:46',10190,'EXECUTED','3:16ce0ad6c3e37071bbfcaad744693d0f','Create Index','Creating unique index on concept_description.uuid column',NULL,'2.0.1'),
 ('20090402-1519-concept_map','bwolfe','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10006,'MARK_RAN','3:b8a320c1d44ab94e785c9ae6c41378f3',NULL,NULL,NULL,NULL),
 ('20090402-1519-concept_name','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:48',10191,'EXECUTED','3:0d5866c0d3eadc8df09b1a7c160508ca','Create Index','Creating unique index on concept_name.uuid column',NULL,'2.0.1'),
 ('20090402-1519-concept_name_tag','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:50',10192,'EXECUTED','3:7ba597ec0fb5fbfba615ac97df642072','Create Index','Creating unique index on concept_name_tag.uuid column',NULL,'2.0.1'),
 ('20090402-1519-concept_proposal','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:52',10193,'EXECUTED','3:79f9f4af9669c2b03511832a23db55e0','Create Index','Creating unique index on concept_proposal.uuid column',NULL,'2.0.1'),
 ('20090402-1519-concept_set','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:55',10194,'EXECUTED','3:f5ba4e2d5ddd4ec66f43501b9749cf70','Create Index','Creating unique index on concept_set.uuid column',NULL,'2.0.1'),
 ('20090402-1519-concept_source','bwolfe','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10007,'MARK_RAN','3:c7c47d9c2876bfa53542885e304b21e7',NULL,NULL,NULL,NULL),
 ('20090402-1519-concept_state_conversion','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:58',10195,'EXECUTED','3:cc9d9bb0d5eb9f6583cd538919b42b9a','Create Index','Creating unique index on concept_state_conversion.uuid column',NULL,'2.0.1'),
 ('20090402-1519-drug','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:00',10196,'EXECUTED','3:8cac800e9f857e29698e1c80ab7e6a52','Create Index','Creating unique index on drug.uuid column',NULL,'2.0.1'),
 ('20090402-1519-encounter','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:03',10197,'EXECUTED','3:8fd623411a44ffb0d4e3a4139e916585','Create Index','Creating unique index on encounter.uuid column',NULL,'2.0.1'),
 ('20090402-1519-encounter_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:07',10198,'EXECUTED','3:71e0e1df8c290d8b6e81e281154661e0','Create Index','Creating unique index on encounter_type.uuid column',NULL,'2.0.1'),
 ('20090402-1519-field','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:10',10199,'EXECUTED','3:36d9eba3e0a90061c6bf1c8aa483110e','Create Index','Creating unique index on field.uuid column',NULL,'2.0.1'),
 ('20090402-1519-field_answer','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:14',10200,'EXECUTED','3:81572b572f758cac173b5d14516f600e','Create Index','Creating unique index on field_answer.uuid column',NULL,'2.0.1'),
 ('20090402-1519-field_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:18',10201,'EXECUTED','3:a0c3927dfde900959131aeb1490a5f51','Create Index','Creating unique index on field_type.uuid column',NULL,'2.0.1'),
 ('20090402-1519-form','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:21',10202,'EXECUTED','3:61147c780ce563776a1caed795661aca','Create Index','Creating unique index on form.uuid column',NULL,'2.0.1'),
 ('20090402-1519-form_field','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:24',10203,'EXECUTED','3:bd9def4522865d181e42809f9dd5c116','Create Index','Creating unique index on form_field.uuid column',NULL,'2.0.1'),
 ('20090402-1519-global_property','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:28',10204,'EXECUTED','3:0e6b84ad5fffa3fd49242b5475e8eb66','Create Index','Creating unique index on global_property.uuid column',NULL,'2.0.1'),
 ('20090402-1519-hl7_in_archive','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:31',10205,'EXECUTED','3:d2f8921c170e416560c234aa74964346','Create Index','Creating unique index on hl7_in_archive.uuid column',NULL,'2.0.1'),
 ('20090402-1519-hl7_in_error','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:34',10206,'EXECUTED','3:9ccec0729ea1b4eaa5068726f9045c25','Create Index','Creating unique index on hl7_in_error.uuid column',NULL,'2.0.1'),
 ('20090402-1519-hl7_in_queue','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:37',10207,'EXECUTED','3:af537cb4134c3f2ed0357f3280ceb6fe','Create Index','Creating unique index on hl7_in_queue.uuid column',NULL,'2.0.1'),
 ('20090402-1519-hl7_source','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:40',10208,'EXECUTED','3:a6d1847b6a590319206f65be9d1d3c9e','Create Index','Creating unique index on hl7_source.uuid column',NULL,'2.0.1'),
 ('20090402-1519-location','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:43',10209,'EXECUTED','3:c435bd4b405d4f11d919777718aa055c','Create Index','Creating unique index on location.uuid column',NULL,'2.0.1'),
 ('20090402-1519-location_tag','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:46',10210,'EXECUTED','3:33a8a54cde59b23a9cdb7740a9995e1a','Create Index','Creating unique index on location_tag.uuid column',NULL,'2.0.1'),
 ('20090402-1519-note','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:48',10211,'EXECUTED','3:97279b2ce285e56613a10a77c5af32b2','Create Index','Creating unique index on note.uuid column',NULL,'2.0.1'),
 ('20090402-1519-notification_alert','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:51',10212,'EXECUTED','3:a763255eddf8607f7d86afbb3099d4b5','Create Index','Creating unique index on notification_alert.uuid column',NULL,'2.0.1'),
 ('20090402-1519-notification_template','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:54',10213,'EXECUTED','3:9a69bbb343077bc62acdf6a66498029a','Create Index','Creating unique index on notification_template.uuid column',NULL,'2.0.1'),
 ('20090402-1519-obs','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:29:57',10214,'EXECUTED','3:de9a7a24e527542e6b4a73e2cd31a7f9','Create Index','Creating unique index on obs.uuid column',NULL,'2.0.1'),
 ('20090402-1519-orders','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:04',10216,'EXECUTED','3:848c0a00a32c5eb25041ad058fd38263','Create Index','Creating unique index on orders.uuid column',NULL,'2.0.1'),
 ('20090402-1519-order_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:01',10215,'EXECUTED','3:d938d263e0acf974d43ad81d2fbe05b0','Create Index','Creating unique index on order_type.uuid column',NULL,'2.0.1'),
 ('20090402-1519-patient_identifier','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:08',10217,'EXECUTED','3:43389efa06408c8312d130654309d140','Create Index','Creating unique index on patient_identifier.uuid column',NULL,'2.0.1'),
 ('20090402-1519-patient_identifier_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:12',10218,'EXECUTED','3:3ffe4f31a1c48d2545e8eed4127cc490','Create Index','Creating unique index on patient_identifier_type.uuid column',NULL,'2.0.1'),
 ('20090402-1519-patient_program','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:16',10219,'EXECUTED','3:ce69defda5ba254914f2319f3a7aac02','Create Index','Creating unique index on patient_program.uuid column',NULL,'2.0.1'),
 ('20090402-1519-patient_state','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:19',10220,'EXECUTED','3:a4ca15f62b3c8c43f7f47ef8b9e39cd3','Create Index','Creating unique index on patient_state.uuid column',NULL,'2.0.1'),
 ('20090402-1519-person','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:21',10221,'EXECUTED','3:345a5d4e8dea4d56c1a0784e7b35a801','Create Index','Creating unique index on person.uuid column',NULL,'2.0.1'),
 ('20090402-1519-person_address','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:23',10222,'EXECUTED','3:105ece744a45b624ea8990f152bb8300','Create Index','Creating unique index on person_address.uuid column',NULL,'2.0.1'),
 ('20090402-1519-person_attribute','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:26',10223,'EXECUTED','3:67a8cdda8605c28f76314873d2606457','Create Index','Creating unique index on person_attribute.uuid column',NULL,'2.0.1'),
 ('20090402-1519-person_attribute_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:28',10224,'EXECUTED','3:a234ad0ea13f32fc4529cf556151d611','Create Index','Creating unique index on person_attribute_type.uuid column',NULL,'2.0.1'),
 ('20090402-1519-person_name','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:29',10225,'EXECUTED','3:d18e326ce221b4b1232ce2e355731338','Create Index','Creating unique index on person_name.uuid column',NULL,'2.0.1'),
 ('20090402-1519-privilege','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:31',10226,'EXECUTED','3:47e7f70f34a213d870e2aeed795d5e3d','Create Index','Creating unique index on privilege.uuid column',NULL,'2.0.1'),
 ('20090402-1519-program','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:35',10227,'EXECUTED','3:62f9d9ecd2325d5908237a769e9a8bc7','Create Index','Creating unique index on program.uuid column',NULL,'2.0.1'),
 ('20090402-1519-program_workflow','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:37',10228,'EXECUTED','3:fabb3152f6055dc0071a2e5d6f573d2f','Create Index','Creating unique index on program_workflow.uuid column',NULL,'2.0.1'),
 ('20090402-1519-program_workflow_state','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:40',10229,'EXECUTED','3:4fdf0c20aedcdc87b2c6058a1cc8fce7','Create Index','Creating unique index on program_workflow_state.uuid column',NULL,'2.0.1'),
 ('20090402-1519-relationship','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:44',10230,'EXECUTED','3:c90617ca900b1aef3f29e71f693e8a25','Create Index','Creating unique index on relationship.uuid column',NULL,'2.0.1'),
 ('20090402-1519-relationship_type','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:46',10231,'EXECUTED','3:c9f05aca70b6dad54af121b593587a29','Create Index','Creating unique index on relationship_type.uuid column',NULL,'2.0.1'),
 ('20090402-1519-report_object','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:48',10232,'EXECUTED','3:6069b78580fd0d276f5dae9f3bdf21be','Create Index','Creating unique index on report_object.uuid column',NULL,'2.0.1'),
 ('20090402-1519-report_schema_xml','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:50',10233,'EXECUTED','3:91499d332dda0577fd02b6a6b7b35e99','Create Index','Creating unique index on report_schema_xml.uuid column',NULL,'2.0.1'),
 ('20090402-1519-role','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:54',10234,'EXECUTED','3:c535a800ceb006311bbb7a27e8bab6ea','Create Index','Creating unique index on role.uuid column',NULL,'2.0.1'),
 ('20090402-1519-serialized_object','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:30:57',10235,'EXECUTED','3:e8f2b1c3a7a67aadc8499ebcb522c91a','Create Index','Creating unique index on serialized_object.uuid column',NULL,'2.0.1'),
 ('20090408-1298','Cory McCarthy','liquibase-update-to-latest.xml','2013-11-04 16:28:04',10070,'EXECUTED','3:defbd13a058ba3563e232c2093cd2b37','Modify Column','Changed the datatype for encounter_type to \'text\' instead of just 50 chars',NULL,'2.0.1'),
 ('200904091023','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:04',10069,'EXECUTED','3:48adc23e9c5d820a87f6c8d61dfb6b55','Delete Data (x4)','Remove Manage Tribes and View Tribes privileges from the privilege table and role_privilege table.\n			The privileges will be recreated by the Tribe module if it is installed.',NULL,'2.0.1'),
 ('20090414-0804','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:16',10175,'EXECUTED','3:479b4df8e3c746b5b96eeea422799774','Drop Foreign Key Constraint','Dropping foreign key on concept_set.concept_id table',NULL,'2.0.1'),
 ('20090414-0805','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:16',10176,'MARK_RAN','3:5017417439ff841eb036ceb94f3c5800','Drop Primary Key','Dropping primary key on concept set table',NULL,'2.0.1'),
 ('20090414-0806','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:16',10177,'MARK_RAN','3:6b9cec59fd607569228bf87d4dffa1a5','Add Column','Adding new integer primary key to concept set table',NULL,'2.0.1'),
 ('20090414-0807','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:19',10178,'MARK_RAN','3:57834f6c953f34035237e06a2dbed9c7','Create Index, Add Foreign Key Constraint','Adding index and foreign key to concept_set.concept_id column',NULL,'2.0.1'),
 ('20090414-0808a','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:22',10179,'EXECUTED','3:6c9d9e6b85c1bf04fdbf9fdec316f2ea','Drop Foreign Key Constraint','Dropping foreign key on patient_identifier.patient_id column',NULL,'2.0.1'),
 ('20090414-0808b','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:22',10180,'MARK_RAN','3:12e01363841135ed0dae46d71e7694cf','Drop Primary Key','Dropping non-integer primary key on patient identifier table before adding a new integer primary key',NULL,'2.0.1'),
 ('20090414-0809','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:22',10181,'MARK_RAN','3:864765efa4cae1c8ffb1138d63f77017','Add Column','Adding new integer primary key to patient identifier table',NULL,'2.0.1'),
 ('20090414-0810','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:25',10182,'MARK_RAN','3:4ca46ee358567e35c897a73c065e3367','Create Index, Add Foreign Key Constraint','Adding index and foreign key on patient_identifier.patient_id column',NULL,'2.0.1'),
 ('20090414-0811a','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:01',10236,'EXECUTED','3:f027a0ad38c0f6302def391da78aaaee','Drop Foreign Key Constraint','Dropping foreign key on concept_word.concept_id column',NULL,'2.0.1'),
 ('20090414-0811b','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:01',10238,'MARK_RAN','3:982d502e56854922542286cead4c09ce','Drop Primary Key','Dropping non-integer primary key on concept word table before adding new integer one',NULL,'2.0.1'),
 ('20090414-0812','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:01',10239,'MARK_RAN','3:948e635fe3f63122856ca9b8a174352b','Add Column','Adding integer primary key to concept word table',NULL,'2.0.1'),
 ('20090414-0812b','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:05',10240,'MARK_RAN','3:bd7731e58f3db9b944905597a08eb6cb','Add Foreign Key Constraint','Re-adding foreign key for concept_word.concept_name_id',NULL,'2.0.1'),
 ('200904271042','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10243,'MARK_RAN','3:db63ce704aff4741c52181d1c825ab62','Drop Column','Remove the now unused synonym column',NULL,'2.0.1'),
 ('20090428-0811aa','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:01',10237,'MARK_RAN','3:58d8f3df1fe704714a7b4957a6c0e7f7','Drop Foreign Key Constraint','Removing concept_word.concept_name_id foreign key so that primary key can be changed to concept_word_id',NULL,'2.0.1'),
 ('20090428-0854','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10241,'EXECUTED','3:11086a37155507c0238c9532f66b172b','Add Foreign Key Constraint','Adding foreign key for concept_word.concept_id column',NULL,'2.0.1'),
 ('200905071626','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:09',10072,'MARK_RAN','3:d29884c3ef8fd867c3c2ffbd557c14c2','Create Index','Add an index to the concept_word.concept_id column (This update may fail if it already exists)',NULL,'2.0.1'),
 ('200905150814','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:28:04',10071,'EXECUTED','3:44c729b393232d702553e0768cf94994','Delete Data','Deleting invalid concept words',NULL,'2.0.1'),
 ('200905150821','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10242,'EXECUTED','3:c0b7abc7eb00f243325b4a3fb2afc614','Custom SQL','Deleting duplicate concept word keys',NULL,'2.0.1'),
 ('200906301606','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10246,'EXECUTED','3:de40c56c128997509d1d943ed047c5d2','Modify Column','Change person_attribute_type.sort_weight from an integer to a float',NULL,'2.0.1'),
 ('200907161638-1','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10247,'EXECUTED','3:dfd352bdc4c5e6c88cd040d03c782e31','Modify Column','Change obs.value_numeric from a double(22,0) to a double',NULL,'2.0.1'),
 ('200907161638-2','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10248,'EXECUTED','3:a8dc0bd1593e6c99a02db443bc4cb001','Modify Column','Change concept_numeric columns from a double(22,0) type to a double',NULL,'2.0.1'),
 ('200907161638-3','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10249,'EXECUTED','3:47b8adbcd480660765dd117020a1e085','Modify Column','Change concept_set.sort_weight from a double(22,0) to a double',NULL,'2.0.1'),
 ('200907161638-4','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10250,'EXECUTED','3:3ffccaa291298fea317eb7025c058492','Modify Column','Change concept_set_derived.sort_weight from a double(22,0) to a double',NULL,'2.0.1'),
 ('200907161638-5','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10251,'EXECUTED','3:3b31cf625830c7e37fa638dbf9625000','Modify Column','Change drug table columns from a double(22,0) to a double',NULL,'2.0.1'),
 ('200907161638-6','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10252,'EXECUTED','3:dc733faec1539038854c0b559b45da0e','Modify Column','Change drug_order.dose from a double(22,0) to a double',NULL,'2.0.1'),
 ('200908291938-1','dthomas','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10008,'MARK_RAN','3:b99a6d7349d367c30e8b404979e07b89',NULL,NULL,NULL,NULL),
 ('200908291938-2a','dthomas','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10009,'MARK_RAN','3:7e9e8d9bffcb6e602b155827f72a3856',NULL,NULL,NULL,NULL),
 ('20090831-1039-38-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10256,'MARK_RAN','3:54e254379235d5c8b569a00ac7dc9c3f','Add Column','Adding \"uuid\" column to scheduler_task_config table',NULL,'2.0.1'),
 ('20090831-1040-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10257,'EXECUTED','3:a9b26bdab35405050c052a9a3f763db0','Update Data','Generating UUIDs for all rows in scheduler_task_config table via built in uuid function.',NULL,'2.0.1'),
 ('20090831-1041-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10258,'MARK_RAN','3:25127273b2d501664ce325922b0c7db2','Custom Change','Adding UUIDs to all rows in scheduler_task_config table via a java class for non mysql/oracle/mssql databases.',NULL,'2.0.1'),
 ('20090831-1042-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10259,'EXECUTED','3:76d8a8b5d342fc4111034861537315cf','Add Not-Null Constraint','Now that UUID generation is done for scheduler_task_config, set the uuid column to not \"NOT NULL\"',NULL,'2.0.1'),
 ('20090831-1043-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:09',10260,'EXECUTED','3:5408ed04284c4f5d57f5160ca5393733','Create Index','Creating unique index on scheduler_task_config.uuid column',NULL,'2.0.1'),
 ('20090907-1','Knoll_Frank','liquibase-update-to-latest.xml','2013-11-04 16:31:09',10261,'MARK_RAN','3:d6f3ed289cdbce6229b1414ec626a33c','Rename Column','Rename the concept_source.date_voided column to date_retired',NULL,'2.0.1'),
 ('20090907-2a','Knoll_Frank','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10262,'MARK_RAN','3:b71e307e4e782cc5a851f764aa7fc0d0','Drop Foreign Key Constraint','Remove the concept_source.voided_by foreign key constraint',NULL,'2.0.1'),
 ('20090907-2b','Knoll_Frank','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10263,'MARK_RAN','3:14e07ebc0a1138ee973bbb26b568d16e','Rename Column, Add Foreign Key Constraint','Rename the concept_source.voided_by column to retired_by',NULL,'2.0.1'),
 ('20090907-3','Knoll_Frank','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10264,'MARK_RAN','3:adee9ced82158f9a9f3d64245ad591c6','Rename Column','Rename the concept_source.voided column to retired',NULL,'2.0.1'),
 ('20090907-4','Knoll_Frank','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10265,'MARK_RAN','3:ad9b6ed4ef3ae43556d3e8c9e2ec0f5c','Rename Column','Rename the concept_source.void_reason column to retire_reason',NULL,'2.0.1'),
 ('20091001-1023','rcrichton','liquibase-update-to-latest.xml','2013-11-04 16:31:19',10293,'MARK_RAN','3:2bf99392005da4e95178bd1e2c28a87b','Add Column','add retired column to relationship_type table',NULL,'2.0.1'),
 ('20091001-1024','rcrichton','liquibase-update-to-latest.xml','2013-11-04 16:31:19',10294,'MARK_RAN','3:31b7b10f75047606406cea156bcc255f','Add Column','add retired_by column to relationship_type table',NULL,'2.0.1'),
 ('20091001-1025','rcrichton','liquibase-update-to-latest.xml','2013-11-04 16:31:22',10295,'MARK_RAN','3:c6dd75893e5573baa0c7426ecccaa92d','Add Foreign Key Constraint','Create the foreign key from the relationship.retired_by to users.user_id.',NULL,'2.0.1'),
 ('20091001-1026','rcrichton','liquibase-update-to-latest.xml','2013-11-04 16:31:22',10296,'MARK_RAN','3:47cfbab54a8049948784a165ffe830af','Add Column','add date_retired column to relationship_type table',NULL,'2.0.1'),
 ('20091001-1027','rcrichton','liquibase-update-to-latest.xml','2013-11-04 16:31:22',10297,'MARK_RAN','3:2db32da70ac1e319909d692110b8654b','Add Column','add retire_reason column to relationship_type table',NULL,'2.0.1'),
 ('200910271049-1','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10266,'EXECUTED','3:2e54d97b9f1b9f35b77cee691c23b7a9','Update Data (x5)','Setting core field types to have standard UUIDs',NULL,'2.0.1'),
 ('200910271049-10','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10275,'EXECUTED','3:827070940f217296c11ce332dc8858ff','Update Data (x4)','Setting core roles to have standard UUIDs',NULL,'2.0.1'),
 ('200910271049-2','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10267,'EXECUTED','3:3132d4cbfaab0c0b612c3fe1c55bd0f1','Update Data (x7)','Setting core person attribute types to have standard UUIDs',NULL,'2.0.1'),
 ('200910271049-3','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10268,'EXECUTED','3:f4d1a9004f91b6885a86419bc02f9d0b','Update Data (x4)','Setting core encounter types to have standard UUIDs',NULL,'2.0.1'),
 ('200910271049-4','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10269,'EXECUTED','3:0d4f7503bf8f00cb73338bb34305333a','Update Data (x12)','Setting core concept datatypes to have standard UUIDs',NULL,'2.0.1'),
 ('200910271049-5','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10270,'EXECUTED','3:98d8ac75977e1b099a4e45d96c6b1d1a','Update Data (x4)','Setting core relationship types to have standard UUIDs',NULL,'2.0.1'),
 ('200910271049-6','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10271,'EXECUTED','3:19355a03794869edad3889ac0adbdedf','Update Data (x15)','Setting core concept classes to have standard UUIDs',NULL,'2.0.1'),
 ('200910271049-7','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10272,'EXECUTED','3:fe4c89654d02d74de6d8e4b265a33288','Update Data (x2)','Setting core patient identifier types to have standard UUIDs',NULL,'2.0.1'),
 ('200910271049-8','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10273,'EXECUTED','3:dc4462b5b4b13c2bc306506848127556','Update Data','Setting core location to have standard UUIDs',NULL,'2.0.1'),
 ('200910271049-9','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10274,'EXECUTED','3:de2a0ed2adafb53f025039e9e8c6719e','Update Data','Setting core hl7 source to have standard UUIDs',NULL,'2.0.1'),
 ('200912031842','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10279,'EXECUTED','3:b966745213bedaeeabab8a874084bb95','Drop Foreign Key Constraint, Add Foreign Key Constraint','Changing encounter.provider_id to reference person instead of users',NULL,'2.0.1'),
 ('200912031846-1','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:15',10281,'MARK_RAN','3:23e728a7f214127cb91efd40ebbcc2d1','Add Column, Update Data','Adding person_id column to users table (if needed)',NULL,'2.0.1'),
 ('200912031846-2','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:15',10282,'MARK_RAN','3:8d57907defa7e92e018038d57cfa78b4','Update Data, Add Not-Null Constraint','Populating users.person_id',NULL,'2.0.1'),
 ('200912031846-3','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:18',10283,'EXECUTED','3:48a50742f2904682caa1bc469f5b87e3','Add Foreign Key Constraint, Set Column as Auto-Increment','Restoring foreign key constraint on users.person_id',NULL,'2.0.1'),
 ('200912071501-1','arthurs','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10276,'EXECUTED','3:d1158b8a42127d7b8a4d5ad64cc7c225','Update Data','Change name for patient.searchMaxResults global property to person.searchMaxResults',NULL,'2.0.1'),
 ('200912091819','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:18',10284,'MARK_RAN','3:8c0b2b02a94b9c6c9529e1b29207464b','Add Column, Add Foreign Key Constraint','Adding retired metadata columns to users table',NULL,'2.0.1'),
 ('200912091819-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:31:18',10285,'EXECUTED','3:fd5fd1d2e6884662824bb78c8348fadf','Modify Column','(Fixed)users.retired to BOOLEAN',NULL,'2.0.1'),
 ('200912091820','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:18',10286,'MARK_RAN','3:cba73499d1c4d09b0e4ae3b55ecc7d84','Update Data','Migrating voided metadata to retired metadata for users table',NULL,'2.0.1'),
 ('200912091821','djazayeri','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10012,'MARK_RAN','3:9b38d31ebfe427d1f8d6e8530687f29c',NULL,NULL,NULL,NULL),
 ('200912140038','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:19',10287,'MARK_RAN','3:be3aaa8da16b8a8841509faaeff070b4','Add Column','Adding \"uuid\" column to users table',NULL,'2.0.1'),
 ('200912140039','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:19',10288,'EXECUTED','3:5b2a81ac1efba5495962bfb86e51546d','Update Data','Generating UUIDs for all rows in users table via built in uuid function.',NULL,'2.0.1'),
 ('200912140040','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:19',10289,'MARK_RAN','3:c422b96e5b88eeae4f343d4f988cc4b2','Custom Change','Adding UUIDs to users table via a java class. (This will take a long time on large databases)',NULL,'2.0.1'),
 ('200912141000-drug-add-date-changed','dkayiwa','liquibase-update-to-latest.xml','2013-11-04 16:32:27',10470,'MARK_RAN','3:9c9a75e3a78104e72de078ac217b0972','Add Column','Add date_changed column to drug table',NULL,'2.0.1'),
 ('200912141001-drug-add-changed-by','dkayiwa','liquibase-update-to-latest.xml','2013-11-04 16:32:27',10471,'MARK_RAN','3:196629c722f52df68b5040e5266ac20f','Add Column, Add Foreign Key Constraint','Add changed_by column to drug table',NULL,'2.0.1'),
 ('200912141552','madanmohan','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10277,'MARK_RAN','3:835b6b98a7a437d959255ac666c12759','Add Column, Add Foreign Key Constraint','Add changed_by column to encounter table',NULL,'2.0.1'),
 ('200912141553','madanmohan','liquibase-update-to-latest.xml','2013-11-04 16:31:11',10278,'MARK_RAN','3:7f768aa879beac091501ac9bb47ece4d','Add Column','Add date_changed column to encounter table',NULL,'2.0.1'),
 ('20091215-0208','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:31:22',10298,'EXECUTED','3:1c818a60d8ebc36f4b7911051c1f6764','Custom SQL','Prune concepts rows orphaned in concept_numeric tables',NULL,'2.0.1'),
 ('20091215-0209','jmiranda','liquibase-update-to-latest.xml','2013-11-04 16:31:22',10299,'EXECUTED','3:adeadc55e4dd484b1d63cf123e299371','Custom SQL','Prune concepts rows orphaned in concept_complex tables',NULL,'2.0.1'),
 ('20091215-0210','jmiranda','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10011,'MARK_RAN','3:08e8550629e4d5938494500f61d10961',NULL,NULL,NULL,NULL),
 ('200912151032','n.nehete','liquibase-update-to-latest.xml','2013-11-04 16:31:19',10291,'EXECUTED','3:d7d8fededde8a27384ca1eb3f87f7914','Add Not-Null Constraint','Encounter Type should not be null when saving an Encounter',NULL,'2.0.1'),
 ('200912211118','nribeka','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10010,'MARK_RAN','3:1f976b4eedf537d887451246d49db043',NULL,NULL,NULL,NULL),
 ('201001072007','upul','liquibase-update-to-latest.xml','2013-11-04 16:31:19',10292,'MARK_RAN','3:d5d60060fae8e9c30843b16b23bed9db','Add Column','Add last execution time column to scheduler_task_config table',NULL,'2.0.1'),
 ('20100111-0111-associating-daemon-user-with-person','dkayiwa','liquibase-update-to-latest.xml','2013-11-04 16:32:22',10463,'MARK_RAN','3:bebb5c508bb53e7d5be6fb3aa259bd2f','Custom SQL','Associating daemon user with a person',NULL,'2.0.1'),
 ('20100128-1','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10253,'MARK_RAN','3:eaa1b8e62aa32654480e7a476dc14a4a','Insert Row','Adding \'System Developer\' role again (see ticket #1499)',NULL,'2.0.1'),
 ('20100128-2','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10254,'MARK_RAN','3:3c486c2ea731dfad7905518cac8d6e70','Update Data','Switching users back from \'Administrator\' to \'System Developer\' (see ticket #1499)',NULL,'2.0.1'),
 ('20100128-3','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:07',10255,'MARK_RAN','3:9acf8cae5d210f88006191e79b76532c','Delete Data','Deleting \'Administrator\' role (see ticket #1499)',NULL,'2.0.1'),
 ('20100306-095513a','thilini.hg','liquibase-update-to-latest.xml','2013-11-04 16:31:25',10300,'MARK_RAN','3:b7a60c3c33a05a71dde5a26f35d85851','Drop Foreign Key Constraint','Dropping unused foreign key from notification alert table',NULL,'2.0.1'),
 ('20100306-095513b','thilini.hg','liquibase-update-to-latest.xml','2013-11-04 16:31:25',10301,'MARK_RAN','3:8a6ebb6aefe04b470d5b3878485f9cc3','Drop Column','Dropping unused user_id column from notification alert table',NULL,'2.0.1'),
 ('20100322-0908','syhaas','liquibase-update-to-latest.xml','2013-11-04 16:31:25',10302,'MARK_RAN','3:94a8aae1d463754d7125cd546b4c590c','Add Column, Update Data','Adding sort_weight column to concept_answers table and initially sets the sort_weight to the concept_answer_id',NULL,'2.0.1'),
 ('20100323-192043','ricardosbarbosa','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10319,'EXECUTED','3:c294c84ac7ff884d1e618f4eb74b0c52','Update Data, Delete Data (x2)','Removing the duplicate privilege \'Add Concept Proposal\' in favor of \'Add Concept Proposals\'',NULL,'2.0.1'),
 ('20100330-190413','ricardosbarbosa','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10320,'EXECUTED','3:d706294defdfb73af9b44db7d37069d0','Update Data, Delete Data (x2)','Removing the duplicate privilege \'Edit Concept Proposal\' in favor of \'Edit Concept Proposals\'',NULL,'2.0.1'),
 ('20100412-2217','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:25',10303,'MARK_RAN','3:0c3a3ea15adefa620ab62145f412d0b6','Add Column','Adding \"uuid\" column to notification_alert_recipient table',NULL,'2.0.1'),
 ('20100412-2218','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:25',10304,'EXECUTED','3:6fae383b5548c214d2ad2c76346e32e3','Update Data','Generating UUIDs for all rows in notification_alert_recipient table via built in uuid function.',NULL,'2.0.1'),
 ('20100412-2219','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:25',10305,'MARK_RAN','3:1401fe5f2d0c6bc23afa70b162e15346','Custom Change','Adding UUIDs to notification_alert_recipient table via a java class (if needed).',NULL,'2.0.1'),
 ('20100412-2220','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:25',10306,'EXECUTED','3:bf4474dd5700b570e158ddc8250c470b','Add Not-Null Constraint','Now that UUID generation is done, set the notification_alert_recipient.uuid column to not \"NOT NULL\"',NULL,'2.0.1'),
 ('20100413-1509','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:25',10307,'MARK_RAN','3:7a3ee61077e4dee1ceb4fe127afc835f','Rename Column','Change location_tag.tag to location_tag.name',NULL,'2.0.1'),
 ('20100415-forgotten-from-before','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:19',10290,'EXECUTED','3:d17699fbec80bd035ecb348ae5382754','Add Not-Null Constraint','Adding not null constraint to users.uuid',NULL,'2.0.1'),
 ('20100419-1209','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10386,'MARK_RAN','3:f87b773f9a8e05892fdbe8740042abb5','Create Table, Add Foreign Key Constraint (x7), Create Index','Create the visit table and add the foreign key for visit_type',NULL,'2.0.1'),
 ('20100419-1209-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10387,'EXECUTED','3:cb5970216f918522df3a059e29506c27','Modify Column','(Fixed)Changed visit.voided to BOOLEAN',NULL,'2.0.1'),
 ('20100423-1402','slorenz','liquibase-update-to-latest.xml','2013-11-04 16:31:29',10309,'MARK_RAN','3:3534020f1c68f70b0e9851d47a4874d6','Create Index','Add an index to the encounter.encounter_datetime column to speed up statistical\n			analysis.',NULL,'2.0.1'),
 ('20100423-1406','slorenz','liquibase-update-to-latest.xml','2013-11-04 16:31:32',10310,'MARK_RAN','3:f058162398862f0bdebc12d7eb54551b','Create Index','Add an index to the obs.obs_datetime column to speed up statistical analysis.',NULL,'2.0.1'),
 ('20100426-1111-add-not-null-personid-contraint','dkayiwa','liquibase-update-to-latest.xml','2013-11-04 16:32:22',10464,'EXECUTED','3:a0b90b98be85aabbdebd957744ab805a','Add Not-Null Constraint','Add the not null person id contraint',NULL,'2.0.1'),
 ('20100426-1111-remove-not-null-personid-contraint','dkayiwa','liquibase-update-to-latest.xml','2013-11-04 16:31:32',10311,'EXECUTED','3:5bc2abe108ab2765e36294ff465c63a0','Drop Not-Null Constraint','Drop the not null person id contraint',NULL,'2.0.1'),
 ('20100426-1947','syhaas','liquibase-update-to-latest.xml','2013-11-04 16:31:32',10312,'MARK_RAN','3:09adbdc9cb72dee82e67080b01d6578e','Insert Row','Adding daemon user to users table',NULL,'2.0.1'),
 ('20100512-1400','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:32',10314,'MARK_RAN','3:0fbfb53e2e194543d7b3eaa59834e1e6','Insert Row','Create core order_type for drug orders',NULL,'2.0.1'),
 ('20100513-1947','syhaas','liquibase-update-to-latest.xml','2013-11-04 16:31:32',10313,'EXECUTED','3:068c2bd55d9c731941fe9ef66f0011fb','Delete Data (x2)','Removing scheduler.username and scheduler.password global properties',NULL,'2.0.1'),
 ('20100517-1545','wyclif and djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10315,'EXECUTED','3:39a68e6b1954a0954d0f8d0c660a7aff','Custom Change','Switch boolean concepts/observations to be stored as coded',NULL,'2.0.1'),
 ('20100525-818-1','syhaas','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10321,'MARK_RAN','3:ed9dcb5bd0d7312db3123825f9bb4347','Create Table, Add Foreign Key Constraint (x2)','Create active list type table.',NULL,'2.0.1'),
 ('20100525-818-1-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10322,'EXECUTED','3:4a648a54797fef2222764a7ee0b5e05a','Modify Column','(Fixed)Change active_list_type.retired to BOOLEAN',NULL,'2.0.1'),
 ('20100525-818-2','syhaas','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10323,'MARK_RAN','3:bc5a86f0245f6f822a0d343b2fcf8dc6','Create Table, Add Foreign Key Constraint (x7)','Create active list table',NULL,'2.0.1'),
 ('20100525-818-2-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10324,'EXECUTED','3:0a2879b368319f6d1e16d0d4417f4492','Modify Column','(Fixed)Change active_list_type.retired to BOOLEAN',NULL,'2.0.1'),
 ('20100525-818-3','syhaas','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10325,'MARK_RAN','3:d382e7b9e23cdcc33ccde2d3f0473c41','Create Table, Add Foreign Key Constraint','Create allergen table',NULL,'2.0.1'),
 ('20100525-818-4','syhaas','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10326,'MARK_RAN','3:1d6f1abd297c8da5a49d4885d0d34dfb','Create Table','Create problem table',NULL,'2.0.1'),
 ('20100525-818-5','syhaas','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10327,'MARK_RAN','3:2ac51b2e8813d61428367bad9fadaa33','Insert Row (x2)','Inserting default active list types',NULL,'2.0.1'),
 ('20100526-1025','Harsha.cse','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10316,'EXECUTED','3:66ec6553564d30fd63df7c2de41c674f','Drop Not-Null Constraint (x2)','Drop Not-Null constraint from location column in Encounter and Obs table',NULL,'2.0.1'),
 ('20100603-1625-1-person_address','sapna','liquibase-update-to-latest.xml','2013-11-04 16:31:56',10367,'MARK_RAN','3:6048aa2c393c1349de55a5003199fb81','Add Column','Adding \"date_changed\" column to person_address table',NULL,'2.0.1'),
 ('20100603-1625-2-person_address','sapna','liquibase-update-to-latest.xml','2013-11-04 16:31:56',10368,'MARK_RAN','3:5194e3b45b70b003e33d7ab0495f3015','Add Column, Add Foreign Key Constraint','Adding \"changed_by\" column to person_address table',NULL,'2.0.1');
INSERT INTO `liquibasechangelog` (`ID`,`AUTHOR`,`FILENAME`,`DATEEXECUTED`,`ORDEREXECUTED`,`EXECTYPE`,`MD5SUM`,`DESCRIPTION`,`COMMENTS`,`TAG`,`LIQUIBASE`) VALUES 
 ('20100604-0933a','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10317,'EXECUTED','3:9b51b236846a8940de581e199cd76cb2','Add Default Value','Changing the default value to 2 for \'message_state\' column in \'hl7_in_archive\' table',NULL,'2.0.1'),
 ('20100604-0933b','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10318,'EXECUTED','3:67fc4c12418b500aaf3723e8845429e3','Update Data','Converting 0 and 1 to 2 for \'message_state\' column in \'hl7_in_archive\' table',NULL,'2.0.1'),
 ('20100607-1550a','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10328,'MARK_RAN','3:bfb6250277efd8c81326fe8c3dbdfe35','Add Column','Adding \'concept_name_type\' column to concept_name table',NULL,'2.0.1'),
 ('20100607-1550b','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10329,'MARK_RAN','3:3d43124d8265fbf05f1ef4839f14bece','Add Column','Adding \'locale_preferred\' column to concept_name table',NULL,'2.0.1'),
 ('20100607-1550b-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:31:33',10330,'EXECUTED','3:d0dc8dfe3ac629aecee81ccc11dec9c2','Modify Column','(Fixed)Change concept_name.locale_preferred to BOOLEAN',NULL,'2.0.1'),
 ('20100607-1550c','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:37',10331,'EXECUTED','3:b6573617d37609ae7195fd7a495e2776','Drop Foreign Key Constraint','Dropping foreign key constraint on concept_name_tag_map.concept_name_tag_id',NULL,'2.0.1'),
 ('20100607-1550d','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:37',10333,'EXECUTED','3:f30fd17874ac8294389ee2a44ca7d6ab','Update Data, Delete Data (x2)','Setting the concept name type for short names',NULL,'2.0.1'),
 ('20100607-1550e','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:37',10332,'EXECUTED','3:0788cd1c32391234a8f0c655897fca24','Update Data, Delete Data (x2)','Converting preferred names to FULLY_SPECIFIED names',NULL,'2.0.1'),
 ('20100607-1550f','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:37',10334,'MARK_RAN','3:b57c0f651ed477457fd16e503eaf51a4','Update Data, Delete Data (x2)','Converting concept names with country specific concept name tags to preferred names',NULL,'2.0.1'),
 ('20100607-1550g','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:37',10335,'EXECUTED','3:c3c0a17e0a21d36f38bb2af8f0939da7','Delete Data (x2)','Deleting \'default\' and \'synonym\' concept name tags',NULL,'2.0.1'),
 ('20100607-1550h','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:37',10336,'EXECUTED','3:be7b967ed0e7006373bb616b63726144','Custom Change','Validating and attempting to fix invalid concepts and ConceptNames',NULL,'2.0.1'),
 ('20100607-1550i','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:39',10337,'EXECUTED','3:b6260c13bf055f7917c155596502a24b','Add Foreign Key Constraint','Restoring foreign key constraint on concept_name_tag_map.concept_name_tag_id',NULL,'2.0.1'),
 ('20100621-1443','jkeiper','liquibase-update-to-latest.xml','2013-11-04 16:31:39',10338,'EXECUTED','3:16b4bc3512029cf8d3b3c6bee86ed712','Modify Column','Modify the error_details column of hl7_in_error to hold\n			stacktraces',NULL,'2.0.1'),
 ('201008021047','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:41',10339,'MARK_RAN','3:8612ede2553aab53950fa43d2f8def32','Create Index','Add an index to the person_name.family_name2 to speed up patient and person searches',NULL,'2.0.1'),
 ('201008201345','mseaton','liquibase-update-to-latest.xml','2013-11-04 16:31:41',10340,'EXECUTED','3:5fbbb6215e66847c86483ee7177c3682','Custom Change','Validates Program Workflow States for possible configuration problems and reports warnings',NULL,'2.0.1'),
 ('201008242121','misha680','liquibase-update-to-latest.xml','2013-11-04 16:31:41',10341,'EXECUTED','3:2319aed08c4f6dcd43d4ace5cdf94650','Modify Column','Make person_name.person_id not NULLable',NULL,'2.0.1'),
 ('20100924-1110','mseaton','liquibase-update-to-latest.xml','2013-11-04 16:31:41',10342,'MARK_RAN','3:05ea5f3b806ba47f4a749d3a348c59f7','Add Column, Add Foreign Key Constraint','Add location_id column to patient_program table',NULL,'2.0.1'),
 ('201009281047','misha680','liquibase-update-to-latest.xml','2013-11-04 16:31:41',10343,'MARK_RAN','3:02b5b9a183729968cd4189798ca034bd','Drop Column','Remove the now unused default_charge column',NULL,'2.0.1'),
 ('201010051745','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:41',10344,'EXECUTED','3:04ba6f526a71fc0a2b016fd77eaf9ff5','Update Data','Setting the global property \'patient.identifierRegex\' to an empty string',NULL,'2.0.1'),
 ('201010051746','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:41',10345,'EXECUTED','3:cb12dfc563d82529de170ffedf948f90','Update Data','Setting the global property \'patient.identifierSuffix\' to an empty string',NULL,'2.0.1'),
 ('201010151054','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:42',10346,'MARK_RAN','3:26c8ae0c53225f82d4c2a85c09ad9785','Create Index','Adding index to form.published column',NULL,'2.0.1'),
 ('201010151055','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:44',10347,'MARK_RAN','3:1efabdfd082ff2b0a34f570831f74ce5','Create Index','Adding index to form.retired column',NULL,'2.0.1'),
 ('201010151056','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:45',10348,'MARK_RAN','3:00273104184bb4d2bb7155befc77efc3','Create Index','Adding multi column index on form.published and form.retired columns',NULL,'2.0.1'),
 ('201010261143','crecabarren','liquibase-update-to-latest.xml','2013-11-04 16:31:45',10349,'MARK_RAN','3:c02de7e2726893f80ecd1f3ae778cba5','Rename Column','Rename neighborhood_cell column to address3 and increase the size to 255 characters',NULL,'2.0.1'),
 ('201010261145','crecabarren','liquibase-update-to-latest.xml','2013-11-04 16:31:45',10350,'MARK_RAN','3:2d053c2e9b604403df8a408a6bb4f3f8','Rename Column','Rename township_division column to address4 and increase the size to 255 characters',NULL,'2.0.1'),
 ('201010261147','crecabarren','liquibase-update-to-latest.xml','2013-11-04 16:31:45',10351,'MARK_RAN','3:592eee2241fdb1039ba08be07b54a422','Rename Column','Rename subregion column to address5 and increase the size to 255 characters',NULL,'2.0.1'),
 ('201010261149','crecabarren','liquibase-update-to-latest.xml','2013-11-04 16:31:45',10352,'MARK_RAN','3:059e5bf4092d930304f9f0fc305939d9','Rename Column','Rename region column to address6 and increase the size to 255 characters',NULL,'2.0.1'),
 ('201010261151','crecabarren','liquibase-update-to-latest.xml','2013-11-04 16:31:45',10353,'MARK_RAN','3:8756b20f505f8981a43ece7233ce3e2f','Rename Column','Rename neighborhood_cell column to address3 and increase the size to 255 characters',NULL,'2.0.1'),
 ('201010261153','crecabarren','liquibase-update-to-latest.xml','2013-11-04 16:31:45',10354,'MARK_RAN','3:9805b9a214fca5a3509a82864274678e','Rename Column','Rename township_division column to address4 and increase the size to 255 characters',NULL,'2.0.1'),
 ('201010261156','crecabarren','liquibase-update-to-latest.xml','2013-11-04 16:31:45',10355,'MARK_RAN','3:894f4e47fbdc74be94e6ebc9d6fce91e','Rename Column','Rename subregion column to address5 and increase the size to 255 characters',NULL,'2.0.1'),
 ('201010261159','crecabarren','liquibase-update-to-latest.xml','2013-11-04 16:31:45',10356,'MARK_RAN','3:b1827790c63813e6a73d83e2b2d36504','Rename Column','Rename region column to address6 and increase the size to 255 characters',NULL,'2.0.1'),
 ('20101029-1016','gobi/prasann','liquibase-update-to-latest.xml','2013-11-04 16:31:56',10369,'MARK_RAN','3:714ad65f5d84bdcd4d944a4d5583e4d3','Create Table, Add Unique Constraint','Create table to store concept stop words to avoid in search key indexing',NULL,'2.0.1'),
 ('20101029-1026','gobi/prasann','liquibase-update-to-latest.xml','2013-11-04 16:31:56',10370,'MARK_RAN','3:83534d43a9a9cc1ea3a80f1d5f5570af','Insert Row (x10)','Inserting the initial concept stop words',NULL,'2.0.1'),
 ('201011011600','jkeiper','liquibase-update-to-latest.xml','2013-11-04 16:31:49',10358,'MARK_RAN','3:29b35d66dc4168e03e1844296e309327','Create Index','Adding index to message_state column in HL7 archive table',NULL,'2.0.1'),
 ('201011011605','jkeiper','liquibase-update-to-latest.xml','2013-11-04 16:31:49',10359,'EXECUTED','3:c604bc0967765f50145f76e80a4bbc99','Custom Change','Moving \"deleted\" HL7s from HL7 archive table to queue table',NULL,'2.0.1'),
 ('201011051300','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:55',10366,'MARK_RAN','3:fea4ad8ce44911eeaab8ac8c1cc9122d','Create Index','Adding index on notification_alert.date_to_expire column',NULL,'2.0.1'),
 ('201012081716','nribeka','liquibase-update-to-latest.xml','2013-11-04 16:31:53',10364,'MARK_RAN','3:4a97a93f2632fc0c3b088b24535ee481','Delete Data','Removing concept that are concept derived and the datatype',NULL,'2.0.1'),
 ('201012081717','nribeka','liquibase-update-to-latest.xml','2013-11-04 16:31:53',10365,'MARK_RAN','3:ad3d0a18bda7e4869d264c70b8cd8d1d','Drop Table','Removing concept derived tables',NULL,'2.0.1'),
 ('20101209-10000-encounter-add-visit-id-column','dkayiwa','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10388,'MARK_RAN','3:7045a94731ef25e04724c77fc97494b4','Add Column, Add Foreign Key Constraint','Adding visit_id column to encounter table',NULL,'2.0.1'),
 ('20101209-1721','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:49',10360,'MARK_RAN','3:351460e0f822555b77acff1a89bec267','Add Column','Add \'weight\' column to concept_word table',NULL,'2.0.1'),
 ('20101209-1722','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:53',10361,'MARK_RAN','3:d63107017bdcef0e28d7ad5e4df21ae5','Create Index','Adding index to concept_word.weight column',NULL,'2.0.1'),
 ('20101209-1723','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:53',10362,'MARK_RAN','3:25d45d7d5bbff4b24bcc8ff8d34d70d2','Insert Row','Insert a row into the schedule_task_config table for the ConceptIndexUpdateTask',NULL,'2.0.1'),
 ('20101209-1731','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:53',10363,'MARK_RAN','3:6de3e859f77856fe939d3ae6a73b4752','Update Data','Setting the value of \'start_on_startup\' to trigger off conceptIndexUpdateTask on startup',NULL,'2.0.1'),
 ('201012092009','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:31:46',10357,'EXECUTED','3:15a029c4ffe65710a56d402e608d319a','Modify Column (x10)','Increasing length of address fields in person_address and location to 255',NULL,'2.0.1'),
 ('2011-07-12-1947-add-outcomesConcept-to-program','grwarren','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10399,'MARK_RAN','3:ea2bb0a2ddeade662f956ef113d020ab','Add Column, Add Foreign Key Constraint','Adding the outcomesConcept property to Program',NULL,'2.0.1'),
 ('2011-07-12-2005-add-outcome-to-patientprogram','grwarren','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10400,'MARK_RAN','3:57baf47f9b09b3df649742d69be32015','Add Column, Add Foreign Key Constraint','Adding the outcome property to PatientProgram',NULL,'2.0.1'),
 ('201101121434','gbalaji,gobi','liquibase-update-to-latest.xml','2013-11-04 16:31:56',10379,'MARK_RAN','3:96320c51e6e296e9dc65866a61268e45','Drop Column','Dropping unused date_started column from obs table',NULL,'2.0.1'),
 ('201101221453','suho','liquibase-update-to-latest.xml','2013-11-04 16:31:56',10378,'EXECUTED','3:4088d4906026cc1430fa98e04d294b13','Modify Column','Increasing the serialized_data column of serialized_object to hold mediumtext',NULL,'2.0.1'),
 ('20110124-1030','surangak','liquibase-update-to-latest.xml','2013-11-04 16:31:59',10381,'MARK_RAN','3:e17eee5b8c4bb236a0ea6e6ade5abed7','Add Foreign Key Constraint','Adding correct foreign key for concept_answer.answer_drug',NULL,'2.0.1'),
 ('20110125-1435','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:56',10372,'MARK_RAN','3:dadd9da1dad5f2863f8f6bb24b29d598','Add Column','Adding \'start_date\' column to person_address table',NULL,'2.0.1'),
 ('20110125-1436','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:31:56',10373,'MARK_RAN','3:68cec89409d2419fe9439f4753a23036','Add Column','Adding \'end_date\' column to person_address table',NULL,'2.0.1'),
 ('201101271456-add-enddate-to-relationship','misha680','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10390,'MARK_RAN','3:b593b864d4a870e3b7ba6b61fda57c8d','Add Column','Adding the end_date column to relationship.',NULL,'2.0.1'),
 ('201101271456-add-startdate-to-relationship','misha680','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10389,'MARK_RAN','3:82020a9f33747f58274196619439781e','Add Column','Adding the start_date column to relationship.',NULL,'2.0.1'),
 ('20110201-1625-1','arahulkmit','liquibase-update-to-latest.xml','2013-11-04 16:31:56',10374,'MARK_RAN','3:4f1b23efba67de1917e312942fe7e744','Add Column','Adding \"date_changed\" column to patient_identifier table',NULL,'2.0.1'),
 ('20110201-1625-2','arahulkmit','liquibase-update-to-latest.xml','2013-11-04 16:31:56',10375,'MARK_RAN','3:01467a1db56ef3db87dc537d40ab22eb','Add Column, Add Foreign Key Constraint','Adding \"changed_by\" column to patient_identifier table',NULL,'2.0.1'),
 ('20110201-1626-1','arahulkmit','liquibase-update-to-latest.xml','2013-11-04 16:31:56',10376,'MARK_RAN','3:63397ce933d1c78309648425fba66a17','Add Column','Adding \"date_changed\" column to relationship table',NULL,'2.0.1'),
 ('20110201-1626-2','arahulkmit','liquibase-update-to-latest.xml','2013-11-04 16:31:56',10377,'MARK_RAN','3:21dae026e42d05b2ebc8fe51408c147f','Add Column, Add Foreign Key Constraint','Adding \"changed_by\" column to relationship table',NULL,'2.0.1'),
 ('201102081800','gbalaji,gobi','liquibase-update-to-latest.xml','2013-11-04 16:31:56',10380,'MARK_RAN','3:779ca58f39b4e3a14a313f8fc416c242','Drop Column','Dropping unused date_stopped column from obs table',NULL,'2.0.1'),
 ('20110218-1206','rubailly','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10013,'MARK_RAN','3:8be61726cd3fed87215557efd284434f',NULL,NULL,NULL,NULL),
 ('20110218-1210','rubailly','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10013,'MARK_RAN','3:4f8818ba08f3a9ce2e2ededfdf5b6fcd',NULL,NULL,NULL,NULL),
 ('201102280948','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:31:15',10280,'EXECUTED','3:98e1075808582c97377651d02faf8f46','Drop Foreign Key Constraint','Removing the foreign key from users.user_id to person.person_id if it still exists',NULL,'2.0.1'),
 ('20110301-1030a','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10414,'MARK_RAN','3:5256e8010fb4c375e2a1ef502176cc2f','Rename Table','Renaming the concept_source table to concept_reference_source',NULL,'2.0.1'),
 ('20110301-1030b','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10415,'MARK_RAN','3:6fc5f514cd9c2ee14481a7f0b10a0c7c','Create Table, Add Foreign Key Constraint (x4)','Adding concept_reference_term table',NULL,'2.0.1'),
 ('20110301-1030b-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10416,'EXECUTED','3:3cf3ba141e6571b900e695b49b6c48a9','Modify Column','(Fixed)Change concept_reference_term.retired to BOOLEAN',NULL,'2.0.1'),
 ('20110301-1030c','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10417,'MARK_RAN','3:d8407baf728a1db5ad5db7c138cb59cb','Create Table, Add Foreign Key Constraint (x3)','Adding concept_map_type table',NULL,'2.0.1'),
 ('20110301-1030c-fix','sunbiz','liquibase-update-to-latest.xml','2011-09-19 00:00:00',10014,'MARK_RAN','3:c02f2825633f1a43fc9303ac21ba2c02',NULL,NULL,NULL,NULL),
 ('20110301-1030d','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10418,'MARK_RAN','3:222ef47c65625a17c268a8f68edaa16e','Rename Table','Renaming the concept_map table to concept_reference_map',NULL,'2.0.1'),
 ('20110301-1030e','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:05',10419,'MARK_RAN','3:50be921cf53ce4a357afc0bac8928495','Add Column','Adding concept_reference_term_id column to concept_reference_map table',NULL,'2.0.1'),
 ('20110301-1030f','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:05',10420,'MARK_RAN','3:5faead5506cbcde69490fef985711d66','Custom Change','Inserting core concept map types',NULL,'2.0.1'),
 ('20110301-1030g','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:05',10421,'MARK_RAN','3:affc4d2a4e3143046cfb75b583c7399a','Add Column, Add Foreign Key Constraint','Adding concept_map_type_id column and a foreign key constraint to concept_reference_map table',NULL,'2.0.1'),
 ('20110301-1030h','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:05',10422,'MARK_RAN','3:4bf584dc7b25a180cc82edb56e1b0e5b','Add Column, Add Foreign Key Constraint','Adding changed_by column and a foreign key constraint to concept_reference_map table',NULL,'2.0.1'),
 ('20110301-1030i','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:05',10423,'MARK_RAN','3:f4d0468db79007d0355f6f461603b2f7','Add Column','Adding date_changed column and a foreign key constraint to concept_reference_map table',NULL,'2.0.1'),
 ('20110301-1030j','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:05',10424,'MARK_RAN','3:a7dc8b89e37fe36263072b43670d7f11','Create Table, Add Foreign Key Constraint (x5)','Adding concept_reference_term_map table',NULL,'2.0.1'),
 ('20110301-1030m','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:05',10425,'MARK_RAN','3:b286407bfcdf3853512cb15009c816f1','Custom Change','Creating concept reference terms from existing rows in the concept_reference_map table',NULL,'2.0.1'),
 ('20110301-1030n','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:08',10426,'MARK_RAN','3:01868c1383e5c9c409282b50e67e878c','Add Foreign Key Constraint','Adding foreign key constraint to concept_reference_map.concept_reference_term_id column',NULL,'2.0.1'),
 ('20110301-1030o','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:12',10427,'MARK_RAN','3:eea9343959864edea569d5a2a2358469','Drop Foreign Key Constraint','Dropping foreign key constraint on concept_reference_map.source column',NULL,'2.0.1'),
 ('20110301-1030p','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:12',10428,'MARK_RAN','3:01bf8c07a05f22df2286a4ee27a7acb4','Drop Column','Dropping concept_reference_map.source column',NULL,'2.0.1'),
 ('20110301-1030q','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:12',10429,'MARK_RAN','3:f45caaf1c7daa7f2cb036f46a20aa4b1','Drop Column','Dropping concept_reference_map.source_code column',NULL,'2.0.1'),
 ('20110301-1030r','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:12',10430,'MARK_RAN','3:23fd6bc96ee0a497cf330ed24ec0075b','Drop Column','Dropping concept_reference_map.comment column',NULL,'2.0.1'),
 ('201103011751','abbas','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10382,'EXECUTED','3:4857dcbefa75784da912bca5caba21b5','Create Table, Add Foreign Key Constraint (x3)','Create the person_merge_log table',NULL,'2.0.1'),
 ('20110326-1','Knoll_Frank','liquibase-update-to-latest.xml','2013-11-04 16:32:22',10457,'EXECUTED','3:3376a34edf88bf2868fd75ba2fb0f6c3','Add Column, Add Foreign Key Constraint','Add obs.previous_version column (TRUNK-420)',NULL,'2.0.1'),
 ('20110326-2','Knoll_Frank','liquibase-update-to-latest.xml','2013-11-04 16:32:22',10460,'EXECUTED','3:7c068bfe918b9d87fefa9f8508e92f58','Custom SQL','Fix all the old void_reason content and add in the new previous_version to the matching obs row (POTENTIALLY VERY SLOW FOR LARGE OBS TABLES)',NULL,'2.0.1'),
 ('20110329-2317','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10383,'EXECUTED','3:371be45e2a3616ce17b6f50862ca196d','Delete Data','Removing \'View Encounters\' privilege from Anonymous user',NULL,'2.0.1'),
 ('20110329-2318','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10384,'EXECUTED','3:eb2ece117d8508e843d11eeed7676b21','Delete Data','Removing \'View Observations\' privilege from Anonymous user',NULL,'2.0.1'),
 ('20110425-1600-create-visit-attribute-type-table','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10391,'MARK_RAN','3:3cf419ea9657f9a072881cafb2543d77','Create Table, Add Foreign Key Constraint (x3)','Creating visit_attribute_type table',NULL,'2.0.1'),
 ('20110425-1600-create-visit-attribute-type-table-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10392,'EXECUTED','3:e4b62b99750c9ee4c213a7bc3101f8a6','Modify Column','(Fixed)Change visit_attribute_type.retired to BOOLEAN',NULL,'2.0.1'),
 ('20110425-1700-create-visit-attribute-table','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10394,'MARK_RAN','3:24e1e30a41f9f5d92f337444fb45402a','Create Table, Add Foreign Key Constraint (x5)','Creating visit_attribute table',NULL,'2.0.1'),
 ('20110425-1700-create-visit-attribute-table-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10395,'EXECUTED','3:8ab9102da66058c326c0a5089de053e8','Modify Column','(Fixed)Change visit_attribute.voided to BOOLEAN',NULL,'2.0.1'),
 ('20110426-11701','zabil','liquibase-update-to-latest.xml','2013-11-04 16:32:19',10436,'MARK_RAN','3:56caae006a3af14242e2ea57627004c7','Create Table, Add Foreign Key Constraint (x4)','Create provider table',NULL,'2.0.1'),
 ('20110426-11701-create-provider-table','dkayiwa','liquibase-schema-only.xml','2013-11-04 16:27:20',87,'EXECUTED','3:56caae006a3af14242e2ea57627004c7','Create Table, Add Foreign Key Constraint (x4)','Create provider table',NULL,'2.0.1'),
 ('20110426-11701-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:32:20',10437,'EXECUTED','3:f222ec7d41ce0255c667fd79b70bffd2','Modify Column','(Fixed)Change provider.retired to BOOLEAN',NULL,'2.0.1'),
 ('20110510-11702-create-provider-attribute-type-table','zabil','liquibase-update-to-latest.xml','2013-11-04 16:32:20',10438,'EXECUTED','3:7478ac84804d46a4f2b3daa63efe99be','Create Table, Add Foreign Key Constraint (x3)','Creating provider_attribute_type table',NULL,'2.0.1'),
 ('20110510-11702-create-provider-attribute-type-table-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:32:20',10439,'EXECUTED','3:479636c7572a649889527f670eaff533','Modify Column','(Fixed)Change provider_attribute_type.retired to BOOLEAN',NULL,'2.0.1'),
 ('20110628-1400-create-provider-attribute-table','kishoreyekkanti','liquibase-update-to-latest.xml','2013-11-04 16:32:20',10441,'EXECUTED','3:298aaacafd48547be294f4c9b7c40d35','Create Table, Add Foreign Key Constraint (x5)','Creating provider_attribute table',NULL,'2.0.1'),
 ('20110628-1400-create-provider-attribute-table-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:32:20',10442,'EXECUTED','3:14d85967e968d0bcd7a49ddeb6f3e540','Modify Column','(Fixed)Change provider_attribute.voided to BOOLEAN',NULL,'2.0.1'),
 ('20110705-2300-create-encounter-role-table','kishoreyekkanti','liquibase-update-to-latest.xml','2013-11-04 16:32:20',10443,'MARK_RAN','3:a381ef81f10e4f7443b4d4c8d6231de8','Create Table, Add Foreign Key Constraint (x3)','Creating encounter_role table',NULL,'2.0.1'),
 ('20110705-2300-create-encounter-role-table-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:32:20',10444,'EXECUTED','3:bed2af9d6c3d49eacbdaf2174e682671','Modify Column','(Fixed)Change encounter_role.retired to BOOLEAN',NULL,'2.0.1'),
 ('20110705-2311-create-encounter-role-table','dkayiwa','liquibase-schema-only.xml','2013-11-04 16:27:20',88,'EXECUTED','3:a381ef81f10e4f7443b4d4c8d6231de8','Create Table, Add Foreign Key Constraint (x3)','Creating encounter_role table',NULL,'2.0.1'),
 ('20110708-2105','cta','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10398,'MARK_RAN','3:a20e9bb27a1aca73a646ad81ef2b9deb','Add Unique Constraint','Add unique constraint to the concept_source table',NULL,'2.0.1'),
 ('201107192313-change-length-of-regex-column','jtellez','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10396,'EXECUTED','3:db001544cc0f5a1ff42524a9292b028b','Modify Column','Increasing maximum length of patient identifier type regex format',NULL,'2.0.1'),
 ('20110811-1205-create-encounter-provider-table','sree/vishnu','liquibase-update-to-latest.xml','2013-11-04 16:32:21',10445,'EXECUTED','3:e20ca5412e37df98c58a39552aafb5ad','Create Table, Add Foreign Key Constraint (x3)','Creating encounter_provider table',NULL,'2.0.1'),
 ('20110811-1205-create-encounter-provider-table-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:32:21',10446,'EXECUTED','3:8decefa15168e68297f5f2782991c552','Modify Column','(Fixed)Change encounter_provider.voided to BOOLEAN',NULL,'2.0.1'),
 ('20110817-1544-create-location-attribute-type-table','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10401,'MARK_RAN','3:41fa30c01ec2d1107beccb8126146464','Create Table, Add Foreign Key Constraint (x3)','Creating location_attribute_type table',NULL,'2.0.1'),
 ('20110817-1544-create-location-attribute-type-table-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10402,'EXECUTED','3:53aff6217c6a9a8f1ca414703b1a8720','Modify Column','(Fixed)Change visit_attribute.retired to BOOLEAN',NULL,'2.0.1'),
 ('20110817-1601-create-location-attribute-table','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10404,'MARK_RAN','3:c7cb1b35d68451d10badeb445df599b9','Create Table, Add Foreign Key Constraint (x5)','Creating location_attribute table',NULL,'2.0.1'),
 ('20110817-1601-create-location-attribute-table-fix','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10405,'EXECUTED','3:2450e230f3eda291203485bca6904377','Modify Column','(Fixed)Change visit_attribute.retired to BOOLEAN',NULL,'2.0.1'),
 ('20110819-1455-insert-unknown-encounter-role','raff','liquibase-update-to-latest.xml','2013-11-04 16:32:21',10447,'EXECUTED','3:bfe0b994a3c0a62d0d4c8f7d941991c7','Insert Row','Inserting the unknown encounter role into the encounter_role table',NULL,'2.0.1'),
 ('20110825-1000-creating-providers-for-persons-from-encounter','raff','liquibase-update-to-latest.xml','2013-11-04 16:32:21',10448,'EXECUTED','3:a70d8897d05364a0a4398f2b90542fd4','Custom SQL','Creating providers for persons from the encounter table',NULL,'2.0.1'),
 ('20110825-1000-drop-provider-id-column-from-encounter-table','raff','liquibase-update-to-latest.xml','2013-11-04 16:32:21',10450,'EXECUTED','3:2137e4b5198aa5f12059ee0e8837fb04','Drop Foreign Key Constraint, Drop Column','Dropping the provider_id column from the encounter table',NULL,'2.0.1'),
 ('20110825-1000-migrating-providers-to-encounter-provider','raff','liquibase-update-to-latest.xml','2013-11-04 16:32:21',10449,'EXECUTED','3:e7c39080453e862d5a4013c48c9225fc','Custom SQL','Migrating providers from the encounter table to the encounter_provider table',NULL,'2.0.1'),
 ('2011091-0749','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:23',125,'EXECUTED','3:3534020f1c68f70b0e9851d47a4874d6','Create Index','',NULL,'2.0.1'),
 ('2011091-0750','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:23',126,'EXECUTED','3:f058162398862f0bdebc12d7eb54551b','Create Index','',NULL,'2.0.1'),
 ('20110913-0300','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:32:15',10431,'MARK_RAN','3:7ad8f362e4cc6df6e37135cc37546d0d','Drop Foreign Key Constraint, Add Foreign Key Constraint','Remove ON DELETE CASCADE from relationship table for person_a',NULL,'2.0.1'),
 ('20110913-0300b','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:32:18',10432,'MARK_RAN','3:2486028ce670bdea2a5ced509a335170','Drop Foreign Key Constraint, Add Foreign Key Constraint','Remove ON DELETE CASCADE from relationship table for person_b',NULL,'2.0.1'),
 ('20110914-0104','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',317,'EXECUTED','3:b1811e5e43321192b275d6e2fe2fa564','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110914-0114','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:19',69,'EXECUTED','3:dac2ff60a4f99315d68948e9582af011','Create Table','',NULL,'2.0.1'),
 ('20110914-0117','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',318,'EXECUTED','3:5b7f746286a955da60c9fec8d663a0e3','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110914-0228','sunbiz','liquibase-core-data.xml','2013-11-04 16:27:46',10036,'EXECUTED','3:4abd556e3f3d1f366e24aeabd58a4f32','Custom SQL','Switched the default xslt to use PV1-19 instead of PV1-1',NULL,'2.0.1'),
 ('20110914-0245','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',319,'EXECUTED','3:48cdf2b28fcad687072ac8133e46cba6','Add Unique Constraint','',NULL,'2.0.1'),
 ('20110914-0306','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:19',70,'EXECUTED','3:037f98fda886cde764171990d168e97d','Create Table','',NULL,'2.0.1'),
 ('20110914-0308','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',320,'EXECUTED','3:6309ad633777b0faf1d9fa394699a789','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110914-0310','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',321,'EXECUTED','3:8c53c44af44d75aadf6cedfc9d13ded1','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110914-0312','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:19',71,'EXECUTED','3:2a39901427c9e7b84c8578ff7b3099bb','Create Table','',NULL,'2.0.1'),
 ('20110914-0314','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',322,'EXECUTED','3:9cbe2e14482f88864f94d5e630a88b62','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110914-0315','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',323,'EXECUTED','3:18cd917d56887ad924dad367470a8461','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110914-0317','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:21',98,'EXECUTED','3:cffbf258ca090d095401957df4168175','Add Primary Key','',NULL,'2.0.1'),
 ('20110914-0321','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',324,'EXECUTED','3:67723ac8a4583366b78c9edc413f89eb','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110914-0434','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',326,'EXECUTED','3:081831e316a82683102f298a91116e92','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110914-0435','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',327,'EXECUTED','3:03fa6c6a37a61480c95d5b75e30d4846','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110914-0448','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:19',72,'EXECUTED','3:ffa1ef2b17d77f87dccbdea0c51249de','Create Table','',NULL,'2.0.1'),
 ('20110914-0453','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',325,'EXECUTED','3:ea43c7690888a7fd47aa7ba39f8006e2','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110914-0509','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:22',122,'EXECUTED','3:d29884c3ef8fd867c3c2ffbd557c14c2','Create Index','',NULL,'2.0.1'),
 ('20110914-0943','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:22',123,'EXECUTED','3:c48f2441d83f121db30399d9cd5f7f8b','Create Index','',NULL,'2.0.1'),
 ('20110914-0945','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',328,'EXECUTED','3:ea1fbb819a84a853b4a97f93bd5b8600','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110914-0956','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:22',124,'EXECUTED','3:719aa7e4120c11889d91214196acfd4c','Create Index','',NULL,'2.0.1'),
 ('20110914-0958','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',329,'EXECUTED','3:ad98b3c7ae60001d0e0a7b927177fb72','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0258','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',330,'EXECUTED','3:bd7731e58f3db9b944905597a08eb6cb','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0259','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:37',331,'EXECUTED','3:11086a37155507c0238c9532f66b172b','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0357','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',332,'EXECUTED','3:05d531e66cbc42e1eb2d42c8bcf20bc8','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0547','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',333,'EXECUTED','3:f3b0fc223476060082626b3849ee20ad','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0552','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',334,'EXECUTED','3:46e5067fb13cefd224451b25abbd03ae','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0603','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',335,'EXECUTED','3:ca4f567e4d75ede0553e8b32012e4141','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0610','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',336,'EXECUTED','3:d6c6a22571e304640b2ff1be52c76977','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0634','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',337,'EXECUTED','3:c6dd75893e5573baa0c7426ecccaa92d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0751','sunbiz','liquibase-core-data.xml','2013-11-04 16:27:46',10028,'EXECUTED','3:010949e257976520a6e8c87e419c9435','Insert Row','',NULL,'2.0.1'),
 ('20110915-0803','sunbiz','liquibase-core-data.xml','2013-11-04 16:27:46',10037,'EXECUTED','3:4a09e1959df71d38fa77b249bf032edc','Insert Row','',NULL,'2.0.1'),
 ('20110915-0823','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',338,'EXECUTED','3:beb831615b748a06a8b21dcaeba8c40d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0824','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',339,'EXECUTED','3:90f1a69f5cae1d2b3b3a2fa8cb1bace2','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0825','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:19',74,'EXECUTED','3:17eab4b1c4c36b54d8cf8ca26083105c','Create Table','',NULL,'2.0.1'),
 ('20110915-0836','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',340,'EXECUTED','3:53f76b5f2c20d5940518a1b14ebab33e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0837','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',341,'EXECUTED','3:936ecde7ac26efdd1a4c29260183609c','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0838','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',342,'EXECUTED','3:fc1e68e753194b2f83e014daa0f7cb3e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0839','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',343,'EXECUTED','3:90bfb3d0edfcfc8091a2ffd943a54e88','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0840','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',344,'EXECUTED','3:9af8eca0bc6b58c3816f871d9f6d5af8','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0841','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',345,'EXECUTED','3:2ca812616a13bac6b0463bf26b9a0fe3','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0842','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',346,'EXECUTED','3:4fd619ffdedac0cf141a7dd1b6e92f9b','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0845','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:19',75,'EXECUTED','3:4e799d7e5a15e823116caa01ab7ed808','Create Table','',NULL,'2.0.1'),
 ('20110915-0846','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',347,'EXECUTED','3:a41f6272aa79f3259ba24f0a31c51e72','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-0847','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:19',76,'EXECUTED','3:8c1e49cd3d6402648ee7732ba9948785','Create Table','',NULL,'2.0.1'),
 ('20110915-0848','sunbiz','liquibase-core-data.xml','2013-11-04 16:27:46',10038,'EXECUTED','3:cf7989886ae2624508fdf64b7b656727','Insert Row (x2)','',NULL,'2.0.1'),
 ('20110915-0848','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:19',77,'EXECUTED','3:071de39e44036bd8adb2b24b011b7369','Create Table','',NULL,'2.0.1'),
 ('20110915-0903','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',348,'EXECUTED','3:b6260c13bf055f7917c155596502a24b','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1045','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:23',127,'EXECUTED','3:8612ede2553aab53950fa43d2f8def32','Create Index','',NULL,'2.0.1'),
 ('20110915-1049','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',349,'EXECUTED','3:b71f1caa3d14aa6282ef58e2a002f999','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1051','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:23',128,'EXECUTED','3:26c8ae0c53225f82d4c2a85c09ad9785','Create Index','',NULL,'2.0.1'),
 ('20110915-1052','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:23',129,'EXECUTED','3:1efabdfd082ff2b0a34f570831f74ce5','Create Index','',NULL,'2.0.1'),
 ('20110915-1053','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:24',130,'EXECUTED','3:00273104184bb4d2bb7155befc77efc3','Create Index','',NULL,'2.0.1'),
 ('20110915-1103','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:24',131,'EXECUTED','3:29b35d66dc4168e03e1844296e309327','Create Index','',NULL,'2.0.1'),
 ('20110915-1104','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:24',132,'EXECUTED','3:d63107017bdcef0e28d7ad5e4df21ae5','Create Index','',NULL,'2.0.1'),
 ('20110915-1107','sunbiz','liquibase-core-data.xml','2013-11-04 16:27:46',10039,'EXECUTED','3:18eb4edef88534b45b384e6bc3ccce75','Insert Row','',NULL,'2.0.1'),
 ('20110915-1133','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:25',133,'EXECUTED','3:fea4ad8ce44911eeaab8ac8c1cc9122d','Create Index','',NULL,'2.0.1'),
 ('20110915-1135','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:38',350,'EXECUTED','3:f0bc11508a871044f5a572b7f8103d52','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1148','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',351,'EXECUTED','3:a5ef601dc184a85e988eded2f1f82dcb','Add Unique Constraint','',NULL,'2.0.1'),
 ('20110915-1149','sunbiz','liquibase-core-data.xml','2013-11-04 16:27:46',10040,'EXECUTED','3:83534d43a9a9cc1ea3a80f1d5f5570af','Insert Row (x10)','',NULL,'2.0.1'),
 ('20110915-1202','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',352,'EXECUTED','3:2c58f7f1e2450c60898bffe6933c9b34','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1203','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',353,'EXECUTED','3:5bce62082a32d3624854a198d3fa35b7','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1210','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',354,'EXECUTED','3:e17eee5b8c4bb236a0ea6e6ade5abed7','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1215','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:19',73,'EXECUTED','3:d772a6a8adedbb1c012dac58ffb221c3','Create Table','',NULL,'2.0.1'),
 ('20110915-1222','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:19',78,'EXECUTED','3:25ce4e3219f2b8c85e06d47dfc097382','Create Table','',NULL,'2.0.1'),
 ('20110915-1225','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',355,'EXECUTED','3:2d4f77176fd59955ff719c46ae8b0cfc','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1226','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',356,'EXECUTED','3:66155de3997745548dbca510649cd09d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1227','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',357,'EXECUTED','3:6700b07595d6060269b86903d08bb2a5','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1231','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:19',79,'EXECUTED','3:e9f6104a25d8b37146b27e568b6e3d3f','Create Table','',NULL,'2.0.1'),
 ('20110915-1240','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',358,'EXECUTED','3:5a30b62738cf57a4804310add8f71b6a','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1241','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',359,'EXECUTED','3:a48aa09c19549e43fc538a70380ae61f','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1242','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',360,'EXECUTED','3:e0e23621fabe23f3f04c4d13105d528c','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1243','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',361,'EXECUTED','3:1d15d848cefc39090e90f3ea78f3cedc','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1244','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',362,'EXECUTED','3:6c5b2018afd741a3c7e39c563212df57','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1245','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',363,'EXECUTED','3:9b5b112797deb6eddc9f0fc01254e378','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1246','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',364,'EXECUTED','3:290a8c07c70dd6a5fe85be2d747ff0d8','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1247','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:25',134,'EXECUTED','3:0644f13c7f4bb764d3b17ad160bd8d41','Create Index','',NULL,'2.0.1'),
 ('20110915-1248','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',365,'EXECUTED','3:5b42d27a7c7edfeb021e1dcfed0f33b3','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1258','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:19',80,'EXECUTED','3:07687ca4ba9b942a862a41dd9026bc9d','Create Table','',NULL,'2.0.1'),
 ('20110915-1301','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',366,'EXECUTED','3:ef3a47a3fdd809ef4269e9643add2abd','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1302','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:39',367,'EXECUTED','3:e36c12350ebfbd624bdc6a6599410c85','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1303','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',368,'EXECUTED','3:5917c5e09a3f6077b728a576cd9bacb3','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1307','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:19',81,'EXECUTED','3:957d888738541ed76dda53e222079fa3','Create Table','',NULL,'2.0.1'),
 ('20110915-1311','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:41',392,'EXECUTED','3:e88c86892fafb2f897f72a85c66954c0','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1312','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',369,'EXECUTED','3:fe2641c56b27b429c1c4a150e1b9af18','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1313','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',370,'EXECUTED','3:5c7ab96d3967d1ce4e00ebe23f4c4f6e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1314','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',371,'EXECUTED','3:22902323fcd541f18ca0cb4f38299cb4','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1315','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',372,'EXECUTED','3:dd0d198da3d5d01f93d9acc23e89d51c','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1316','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',373,'EXECUTED','3:f22027f3fc0b1a3a826dc5d810fcd936','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1317','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',374,'EXECUTED','3:68aa00c9f2faa61031d0b4544f4cb31b','Add Unique Constraint','',NULL,'2.0.1'),
 ('20110915-1320','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',375,'EXECUTED','3:5d6a55ee33c33414cccc8b46776a36a4','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1323','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',376,'EXECUTED','3:4c3b84570d45b23d363f6ee76acd966f','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1325','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:19',82,'EXECUTED','3:0813953451c461376a6ab5a13e4654dd','Create Table','',NULL,'2.0.1'),
 ('20110915-1327','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',377,'EXECUTED','3:3c8aaca28033c8a01e4bceb7421f8e8e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1328','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',378,'EXECUTED','3:05b6e994f2a09b23826264d31f275b5e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1329','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',379,'EXECUTED','3:40729ae012b9ed8bd55439b233ec10cc','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1337','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:20',83,'EXECUTED','3:06fd47a34713fad9678463bba9675496','Create Table','',NULL,'2.0.1'),
 ('20110915-1342','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',380,'EXECUTED','3:bb52caf0ec6e80e24d6fc0c7f2c95631','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1343','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',381,'EXECUTED','3:b36c3436facfe7c9371f7780ebb8701d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1344','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:40',382,'EXECUTED','3:010fa7bc125bcb8caa320d38a38a7e3f','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1345','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:41',383,'EXECUTED','3:e3cdd84f2e6632a4dd8c526cf9ff476e','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1346','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:41',384,'EXECUTED','3:7f6420b23addd5b33320e04adbc134a3','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1435','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:20',84,'EXECUTED','3:511f99d7cb13e5fc1112ccb4633e0e45','Create Table','',NULL,'2.0.1'),
 ('20110915-1440','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:41',385,'EXECUTED','3:2cb254be6daeeebb74fc0e1d64728a62','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1441','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:41',386,'EXECUTED','3:8bd11d5102eff3b52b1d925e44627a48','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1442','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:41',387,'EXECUTED','3:4cf7afc33839c19f830e996e8546ea72','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1443','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:41',388,'EXECUTED','3:cf41f73f64c11150062b2e2254a56908','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1450','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:20',85,'EXECUTED','3:f9348bf7337d32ebbf98545857b5c8cc','Create Table','',NULL,'2.0.1'),
 ('20110915-1451','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:41',389,'EXECUTED','3:d98c8bdaacf99764ab3319db03b48542','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1452','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:41',390,'EXECUTED','3:3a2e67fd1f0215b49711e7e8dccd370d','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1453','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:41',391,'EXECUTED','3:6b1b7fb75fedc196cf833f04e216b9b2','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1459','sunbiz','liquibase-core-data.xml','2013-11-04 16:27:46',10041,'EXECUTED','3:5faead5506cbcde69490fef985711d66','Custom Change','Inserting core concept map types',NULL,'2.0.1'),
 ('20110915-1524','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:41',393,'EXECUTED','3:8d609018e78b744ce30e8907ead0bec0','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1528','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:20',86,'EXECUTED','3:e8a5555a214d7bb6f17eb2466f59d12b','Create Table','',NULL,'2.0.1'),
 ('20110915-1530','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:41',394,'EXECUTED','3:ddc26a0bb350b6c744ed6ff813b5c108','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1531','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:41',395,'EXECUTED','3:e9fa5722ba00d9b55d813f0fc8e5f9f9','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1532','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:41',396,'EXECUTED','3:72f0f61a12a3eead113be1fdcabadb6f','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1533','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:42',397,'EXECUTED','3:0430d8eecce280786a66713abd0b3439','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1534','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:42',398,'EXECUTED','3:21b6cde828dbe885059ea714cda4f470','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1536','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:42',399,'EXECUTED','3:01868c1383e5c9c409282b50e67e878c','Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('20110915-1700','sunbiz','liquibase-schema-only.xml','2013-11-04 16:27:42',400,'EXECUTED','3:ba5b74aeacacec55a49d31074b7e5023','Insert Row (x18)','',NULL,'2.0.1'),
 ('201109152336','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:32:19',10434,'MARK_RAN','3:a84f855a1db7201e08900f8c7a3d7c5f','Update Data','Updating logging level global property',NULL,'2.0.1'),
 ('20110919-0638','sunbiz','liquibase-update-to-latest.xml','2011-09-19 00:00:00',10015,'MARK_RAN','3:5e540b763c3a16e9d37aa6423b7f798f',NULL,NULL,NULL,NULL),
 ('20110919-0639-void_empty_attributes','dkayiwa','liquibase-update-to-latest.xml','2013-11-04 16:32:19',10435,'EXECUTED','3:ccdbab987b09073fc146f3a4a5a9aee4','Custom SQL','Void all attributes that have empty string values.',NULL,'2.0.1'),
 ('20110922-0551','sunbiz','liquibase-update-to-latest.xml','2013-11-04 16:31:25',10308,'MARK_RAN','3:ab9b55e5104645690a4e1c5e35124258','Modify Column','Changing global_property.property from varbinary to varchar',NULL,'2.0.1'),
 ('20110926-1200','raff','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10397,'MARK_RAN','3:bf884233110a210b6ffcef826093cf9d','Custom SQL','Change all empty concept_source.hl7_code to NULL',NULL,'2.0.1'),
 ('201109301703','suho','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10406,'MARK_RAN','3:11456d3e6867f3b521fb35e6f51ebe5a','Update Data','Converting general address format (if applicable)',NULL,'2.0.1'),
 ('201109301704','suho','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10407,'MARK_RAN','3:d64afe121c9355f6bbe46258876ce759','Update Data','Converting Spain address format (if applicable)',NULL,'2.0.1'),
 ('201109301705','suho','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10408,'MARK_RAN','3:d3b0c8265ee27456dc0491ff5fe8ca01','Update Data','Converting Rwanda address format (if applicable)',NULL,'2.0.1'),
 ('201109301706','suho','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10409,'MARK_RAN','3:17d3a0900ca751d8ce775a12444c75bf','Update Data','Converting USA address format (if applicable)',NULL,'2.0.1'),
 ('201109301707','suho','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10410,'MARK_RAN','3:afbd6428d0007325426f3c4446de2e38','Update Data','Converting Kenya address format (if applicable)',NULL,'2.0.1'),
 ('201109301708','suho','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10411,'MARK_RAN','3:570c9234597b477e4feffbaac0469495','Update Data','Converting Lesotho address format (if applicable)',NULL,'2.0.1'),
 ('201109301709','suho','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10412,'MARK_RAN','3:20c95ae336f437b4e0c91be5919b7a2b','Update Data','Converting Malawi address format (if applicable)',NULL,'2.0.1'),
 ('201109301710','suho','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10413,'MARK_RAN','3:b06d71b4c220c7feed9c5a6459bea98a','Update Data','Converting Tanzania address format (if applicable)',NULL,'2.0.1'),
 ('201110051353-fix-visit-attribute-type-columns','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:32:00',10393,'MARK_RAN','3:d779b41ab27dca879d593aa606016bf6','Add Column (x2)','Refactoring visit_attribute_type table (devs only)',NULL,'2.0.1'),
 ('201110072042-fix-location-attribute-type-columns','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:32:04',10403,'MARK_RAN','3:2e32ce0f25391341c8855604f4f40654','Add Column (x2)','Refactoring location_attribute_type table (devs only)',NULL,'2.0.1'),
 ('201110072043-fix-provider-attribute-type-columns','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:32:20',10440,'MARK_RAN','3:31aa196adfe1689c1098c5f36d490902','Add Column (x2)','Refactoring provider_attribute_type table (devs only)',NULL,'2.0.1'),
 ('20111008-0938-1','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:32:21',10451,'EXECUTED','3:fe6d462ba1a7bd81f4865e472cc223ce','Add Column','Allow Global Properties to be typed',NULL,'2.0.1'),
 ('20111008-0938-2','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:32:21',10452,'EXECUTED','3:f831d92c11eb6cd6b334d86160db0b95','Add Column','Allow Global Properties to be typed',NULL,'2.0.1'),
 ('20111008-0938-3','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:32:21',10453,'EXECUTED','3:f7bd79dfed90d56053dc376b6b8ee7e3','Add Column','Allow Global Properties to be typed',NULL,'2.0.1'),
 ('20111008-0938-4','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:32:21',10454,'EXECUTED','3:65003bd1bf99ff0aa8e2947978c58053','Add Column','Allow Global Properties to be typed',NULL,'2.0.1'),
 ('201110091820-a','jkeiper','liquibase-update-to-latest.xml','2013-11-04 16:32:21',10455,'MARK_RAN','3:364a0c70d2adbff31babab6f60ed72e7','Add Column','Add xslt column back to the form table',NULL,'2.0.1'),
 ('201110091820-b','jkeiper','liquibase-update-to-latest.xml','2013-11-04 16:32:21',10456,'MARK_RAN','3:0b792bf39452f2e81e502a7a98f9f3df','Add Column','Add template column back to the form table',NULL,'2.0.1'),
 ('201110091820-c','jkeiper','liquibase-update-to-latest.xml','2013-11-04 16:32:22',10458,'MARK_RAN','3:f71680d95ecf870619671fb7f416e457','Rename Table','Rename form_resource table to preserve data; 20111010-1515 reference is for bleeding-edge developers and can be generally ignored',NULL,'2.0.1'),
 ('20111010-1515','jkeiper','liquibase-update-to-latest.xml','2013-11-04 16:32:22',10459,'EXECUTED','3:3ccdc9a3ecf811382a0c12825c0aeeb3','Create Table, Add Foreign Key Constraint, Add Unique Constraint','Creating form_resource table',NULL,'2.0.1'),
 ('20111128-1601','wyclif','liquibase-update-to-latest.xml','2013-11-04 16:32:22',10461,'EXECUTED','3:12fa4687d149a2f17251e546d47369d6','Insert Row','Inserting Auto Close Visits Task into \'schedule_task_config\' table',NULL,'2.0.1'),
 ('20111209-1400-deleting-non-existing-roles-from-role-role-table','raff','liquibase-update-to-latest.xml','2013-11-04 16:32:22',10462,'EXECUTED','3:3d74c1dd987a12d916218d68032d726d','Custom SQL','Deleting non-existing roles from the role_role table',NULL,'2.0.1'),
 ('20111214-1500-setting-super-user-gender','raff','liquibase-update-to-latest.xml','2013-11-04 16:32:22',10465,'EXECUTED','3:2c281abfe7beb51983db13c187c072f3','Custom SQL','Setting super user gender',NULL,'2.0.1'),
 ('20111218-1830','abbas','liquibase-update-to-latest.xml','2013-11-04 16:32:27',10466,'EXECUTED','3:5f096b88988f19d9d3e596c03fba2b90','Add Unique Constraint, Add Column (x6), Add Foreign Key Constraint (x2)','Add unique uuid constraint and attributes inherited from BaseOpenmrsData to the person_merge_log table',NULL,'2.0.1'),
 ('20111219-1404','bwolfe','liquibase-update-to-latest.xml','2013-11-04 16:32:27',10467,'EXECUTED','3:3f8cfa9c088a103788bcf70de3ffaa8b','Update Data','Fix empty descriptions on relationship types',NULL,'2.0.1'),
 ('20111222-1659','djazayeri','liquibase-update-to-latest.xml','2013-11-04 16:32:27',10469,'EXECUTED','3:990b494647720b680efeefbab2c502de','Create Table, Create Index','Create clob_datatype_storage table',NULL,'2.0.1'),
 ('201118012301','lkellett','liquibase-update-to-latest.xml','2013-11-04 16:31:56',10371,'MARK_RAN','3:0d96c10c52335339b1003e6dd933ccc2','Add Column','Adding the discontinued_reason_non_coded column to orders.',NULL,'2.0.1'),
 ('201202020847','abbas','liquibase-update-to-latest.xml','2013-11-04 16:32:27',10468,'EXECUTED','3:35bf2f2481ee34975e57f08d933583be','Modify data type, Add Not-Null Constraint','Change merged_data column type to CLOB in person_merge_log table',NULL,'2.0.1'),
 ('20120330-0954','jkeiper','liquibase-update-to-latest.xml','2013-11-04 16:32:27',10472,'EXECUTED','3:9c6084b4407395205fa39b34630d3522','Modify data type','Increase size of drug name column to 255 characters',NULL,'2.0.1'),
 ('20120503-djmod','dkayiwa and djazayeri','liquibase-update-to-latest.xml','2013-11-05 11:31:12',10482,'EXECUTED','3:d31ac18d3a40e45c0ebb399c5d116951','Create Table, Add Foreign Key Constraint (x2)','Create test_order table',NULL,'2.0.5'),
 ('20120613-0930','wyclif','liquibase-update-to-latest.xml','2013-11-05 11:31:12',10480,'EXECUTED','3:fe6387773a70b574b106b37686a8e8d3','Drop Not-Null Constraint','Dropping not null constraint from provider.identifier column',NULL,'2.0.5'),
 ('20120730-1340','raff','liquibase.xml','2013-11-08 10:34:19',10484,'EXECUTED','3:1124c64210e65099c32f7a2c69008c31','Create Table','Create the hl7query_template table',NULL,'2.0.5'),
 ('20120730-1345','raff','liquibase.xml','2013-11-08 10:34:19',10485,'EXECUTED','3:ea3766fc594e94c2745bc8b1048b593f','Add Foreign Key Constraint','Add creator FK to hl7query_template',NULL,'2.0.5'),
 ('20120730-1350','raff','liquibase.xml','2013-11-08 10:34:19',10486,'EXECUTED','3:ae26eebca9d1acc74cc662f3c7d3e9b6','Add Foreign Key Constraint','Add retired_by FK to hl7query_template',NULL,'2.0.5'),
 ('20120730-1530','raff','liquibase.xml','2013-11-08 10:34:19',10487,'EXECUTED','3:556ce236a9e784324760b9e41cf4f36e','Add Foreign Key Constraint','Add changed_by FK to hl7query_template',NULL,'2.0.5'),
 ('20120801-1703','skathol','liquibase.xml','2013-11-08 10:34:20',10488,'EXECUTED','3:d8e37b39dc4cc24196e43e4e4c3ad9a0','Insert Row','',NULL,'2.0.5'),
 ('20120802-0522','JUDY','liquibase.xml','2013-11-08 10:34:20',10492,'EXECUTED','3:ab54309d5476aa7452517f13969d0460','Insert Row','Add values for Default patient Identifier template',NULL,'2.0.5'),
 ('20120802-1040','raff','liquibase.xml','2013-11-08 10:34:20',10490,'EXECUTED','3:f6142f8fcf0d8afae41dcf2fa0d073c0','Insert Row','',NULL,'2.0.5'),
 ('20120807-1514','wyclif','liquibase.xml','2013-11-08 10:34:20',10495,'EXECUTED','3:5a2dbb41df02130e9821bd7fcbb34619','Insert Row','',NULL,'2.0.5'),
 ('20120807-1530','raff','liquibase.xml','2013-11-08 10:34:20',10494,'EXECUTED','3:5767f72373f51c5929e200970a259847','Insert Row','',NULL,'2.0.5'),
 ('20121007-orders_urgency','djazayeri','liquibase-update-to-latest.xml','2013-11-05 11:31:12',10481,'EXECUTED','3:f8eb2228ea34f43ae21bedf4abc8736b','Add Column','Adding urgency column to orders table',NULL,'2.0.5'),
 ('20121020-TRUNK-3610','lluismf','liquibase-update-to-latest.xml','2013-11-05 11:31:12',10483,'EXECUTED','3:a3159e65647f0ff1b667104012b5f4f0','Update Data (x2)','Rename global property autoCloseVisits.visitType to visits.autoCloseVisitType',NULL,'2.0.5'),
 ('201306141103-TRUNK-3884','susantan','liquibase-update-to-latest.xml','2013-11-25 15:39:43',10502,'EXECUTED','3:9581f8d869e69d911f04e48591a297d0','Add Foreign Key Constraint (x3)','Adding 3 foreign key relationships (creator,created_by,voided_by) to encounter_provider table',NULL,'2.0.5'),
 ('201307331-1740','JUDY','liquibase.xml','2013-11-08 10:34:20',10491,'EXECUTED','3:9438c63c52134bac749d74d6c00911cc','Insert Row','Add values for Default patient name  template to the hl7queryTemplate table',NULL,'2.0.5'),
 ('create-logic-rule-definition','mseaton','liquibase.xml','2013-11-04 16:32:52',10477,'EXECUTED','3:5327271907425ea8182024723912460c','Create Table, Create Index (x3), Add Foreign Key Constraint (x3)','',NULL,'2.0.1'),
 ('create-logic-rule-token-tag','nribeka','liquibase.xml','2013-11-04 16:32:52',10476,'EXECUTED','3:0d0c10ea14371337b4b2a8da0972d768','Create Table, Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('create-logic_token_registration','djazayeri','liquibase.xml','2013-11-04 16:32:53',10478,'EXECUTED','3:fba04de00a55b2d5478aed1653df7007','Create Table, Add Foreign Key Constraint (x2)','',NULL,'2.0.1'),
 ('create-logic_token_registration_tag','djazayeri','liquibase.xml','2013-11-04 16:32:53',10479,'EXECUTED','3:e941337ae6d3dfb33bf3ff92aeb63b89','Create Table, Add Foreign Key Constraint','',NULL,'2.0.1'),
 ('create_logic_rule_token','nribeka','liquibase.xml','2013-11-04 16:32:52',10475,'EXECUTED','3:5c95d01a824456e85a6729745a0e814d','Create Table, Add Foreign Key Constraint (x2)','',NULL,'2.0.1'),
 ('disable-foreign-key-checks','ben','liquibase-core-data.xml','2013-11-04 16:27:45',10017,'EXECUTED','3:cc124077cda1cfb0c70c1ec823551223','Custom SQL','',NULL,'2.0.1'),
 ('drop_logic_rule_token','nribeka','liquibase.xml','2013-11-04 16:32:52',10474,'MARK_RAN','3:4bfc38917a898cfc54c440e045cd655c','Drop Table','',NULL,'2.0.1'),
 ('drop_logic_rule_token_tag','nribeka','liquibase.xml','2013-11-04 16:32:52',10473,'MARK_RAN','3:4ba9ee4a3873ff8c847a3d5fb7275732','Drop Table','',NULL,'2.0.1'),
 ('enable-foreign-key-checks','ben','liquibase-core-data.xml','2013-11-04 16:27:46',10042,'EXECUTED','3:fcfe4902a8f3eda10332567a1a51cb49','Custom SQL','',NULL,'2.0.1');
/*!40000 ALTER TABLE `liquibasechangelog` ENABLE KEYS */;


--
-- Definition of table `liquibasechangeloglock`
--

DROP TABLE IF EXISTS `liquibasechangeloglock`;
CREATE TABLE `liquibasechangeloglock` (
  `ID` int(11) NOT NULL,
  `LOCKED` tinyint(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `liquibasechangeloglock`
--

/*!40000 ALTER TABLE `liquibasechangeloglock` DISABLE KEYS */;
INSERT INTO `liquibasechangeloglock` (`ID`,`LOCKED`,`LOCKGRANTED`,`LOCKEDBY`) VALUES 
 (1,0,NULL,NULL);
/*!40000 ALTER TABLE `liquibasechangeloglock` ENABLE KEYS */;


--
-- Definition of table `location`
--

DROP TABLE IF EXISTS `location`;
CREATE TABLE `location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city_village` varchar(255) DEFAULT NULL,
  `state_province` varchar(255) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `county_district` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `address4` varchar(255) DEFAULT NULL,
  `address5` varchar(255) DEFAULT NULL,
  `address6` varchar(255) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `parent_location` int(11) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `location_uuid_index` (`uuid`),
  KEY `name_of_location` (`name`),
  KEY `location_retired_status` (`retired`),
  KEY `user_who_created_location` (`creator`),
  KEY `user_who_retired_location` (`retired_by`),
  KEY `parent_location` (`parent_location`),
  CONSTRAINT `parent_location` FOREIGN KEY (`parent_location`) REFERENCES `location` (`location_id`),
  CONSTRAINT `user_who_created_location` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_location` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `location`
--

/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` (`location_id`,`name`,`description`,`address1`,`address2`,`city_village`,`state_province`,`postal_code`,`country`,`latitude`,`longitude`,`creator`,`date_created`,`county_district`,`address3`,`address4`,`address5`,`address6`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`parent_location`,`uuid`) VALUES 
 (1,'Unknown Location',NULL,'','','','','','',NULL,NULL,1,'2005-09-22 00:00:00',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'8d6c993e-c2cc-11de-8d13-0010c6dffd0f'),
 (2,'Musha (RWAMAGANA)','FOSAID: 357 TYPE: CS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2013-11-05 13:55:57',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'2cea4d75-1cc6-429b-9cec-b5484223a33a'),
 (3,'Rwamagana','OpenMRS ELID:999',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2013-11-19 12:59:56',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'54d337f0-95a2-47bf-88d0-270747c74238');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;


--
-- Definition of table `location_attribute`
--

DROP TABLE IF EXISTS `location_attribute`;
CREATE TABLE `location_attribute` (
  `location_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_attribute_location_fk` (`location_id`),
  KEY `location_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `location_attribute_creator_fk` (`creator`),
  KEY `location_attribute_changed_by_fk` (`changed_by`),
  KEY `location_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `location_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `location_attribute_type` (`location_attribute_type_id`),
  CONSTRAINT `location_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_attribute_location_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `location_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `location_attribute`
--

/*!40000 ALTER TABLE `location_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_attribute` ENABLE KEYS */;


--
-- Definition of table `location_attribute_type`
--

DROP TABLE IF EXISTS `location_attribute_type`;
CREATE TABLE `location_attribute_type` (
  `location_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`location_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_attribute_type_creator_fk` (`creator`),
  KEY `location_attribute_type_changed_by_fk` (`changed_by`),
  KEY `location_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `location_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `location_attribute_type`
--

/*!40000 ALTER TABLE `location_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_attribute_type` ENABLE KEYS */;


--
-- Definition of table `location_tag`
--

DROP TABLE IF EXISTS `location_tag`;
CREATE TABLE `location_tag` (
  `location_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`location_tag_id`),
  UNIQUE KEY `location_tag_uuid_index` (`uuid`),
  KEY `location_tag_creator` (`creator`),
  KEY `location_tag_retired_by` (`retired_by`),
  CONSTRAINT `location_tag_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_tag_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `location_tag`
--

/*!40000 ALTER TABLE `location_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_tag` ENABLE KEYS */;


--
-- Definition of table `location_tag_map`
--

DROP TABLE IF EXISTS `location_tag_map`;
CREATE TABLE `location_tag_map` (
  `location_id` int(11) NOT NULL,
  `location_tag_id` int(11) NOT NULL,
  PRIMARY KEY (`location_id`,`location_tag_id`),
  KEY `location_tag_map_tag` (`location_tag_id`),
  CONSTRAINT `location_tag_map_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `location_tag_map_tag` FOREIGN KEY (`location_tag_id`) REFERENCES `location_tag` (`location_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `location_tag_map`
--

/*!40000 ALTER TABLE `location_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_tag_map` ENABLE KEYS */;


--
-- Definition of table `logic_rule_definition`
--

DROP TABLE IF EXISTS `logic_rule_definition`;
CREATE TABLE `logic_rule_definition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `rule_content` varchar(2048) NOT NULL,
  `language` varchar(255) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `creator_idx` (`creator`),
  KEY `changed_by_idx` (`changed_by`),
  KEY `retired_by_idx` (`retired_by`),
  CONSTRAINT `changed_by_for_rule_definition` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `creator_for_rule_definition` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `retired_by_for_rule_definition` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `logic_rule_definition`
--

/*!40000 ALTER TABLE `logic_rule_definition` DISABLE KEYS */;
/*!40000 ALTER TABLE `logic_rule_definition` ENABLE KEYS */;


--
-- Definition of table `logic_rule_token`
--

DROP TABLE IF EXISTS `logic_rule_token`;
CREATE TABLE `logic_rule_token` (
  `logic_rule_token_id` int(11) NOT NULL AUTO_INCREMENT,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `token` varchar(512) NOT NULL,
  `class_name` varchar(512) NOT NULL,
  `state` varchar(512) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`logic_rule_token_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `token_creator` (`creator`),
  KEY `token_changed_by` (`changed_by`),
  CONSTRAINT `token_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `person` (`person_id`),
  CONSTRAINT `token_creator` FOREIGN KEY (`creator`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `logic_rule_token`
--

/*!40000 ALTER TABLE `logic_rule_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `logic_rule_token` ENABLE KEYS */;


--
-- Definition of table `logic_rule_token_tag`
--

DROP TABLE IF EXISTS `logic_rule_token_tag`;
CREATE TABLE `logic_rule_token_tag` (
  `logic_rule_token_id` int(11) NOT NULL,
  `tag` varchar(512) NOT NULL,
  KEY `token_tag` (`logic_rule_token_id`),
  CONSTRAINT `token_tag` FOREIGN KEY (`logic_rule_token_id`) REFERENCES `logic_rule_token` (`logic_rule_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `logic_rule_token_tag`
--

/*!40000 ALTER TABLE `logic_rule_token_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `logic_rule_token_tag` ENABLE KEYS */;


--
-- Definition of table `logic_token_registration`
--

DROP TABLE IF EXISTS `logic_token_registration`;
CREATE TABLE `logic_token_registration` (
  `token_registration_id` int(11) NOT NULL AUTO_INCREMENT,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `token` varchar(512) NOT NULL,
  `provider_class_name` varchar(512) NOT NULL,
  `provider_token` varchar(512) NOT NULL,
  `configuration` varchar(2000) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`token_registration_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `token_registration_creator` (`creator`),
  KEY `token_registration_changed_by` (`changed_by`),
  CONSTRAINT `token_registration_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `token_registration_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `logic_token_registration`
--

/*!40000 ALTER TABLE `logic_token_registration` DISABLE KEYS */;
INSERT INTO `logic_token_registration` (`token_registration_id`,`creator`,`date_created`,`changed_by`,`date_changed`,`token`,`provider_class_name`,`provider_token`,`configuration`,`uuid`) VALUES 
 (1,2,'2013-11-04 16:33:31',NULL,NULL,'encounterLocation','org.openmrs.logic.datasource.EncounterDataSource','encounterLocation','encounterLocation','76a1991f-a7ae-44fd-86d0-328dd4046f86'),
 (2,2,'2013-11-04 16:33:31',NULL,NULL,'encounterProvider','org.openmrs.logic.datasource.EncounterDataSource','encounterProvider','encounterProvider','f61472a8-b36c-49fe-8224-dbf2bf0c436b'),
 (3,2,'2013-11-04 16:33:31',NULL,NULL,'encounter','org.openmrs.logic.datasource.EncounterDataSource','encounter','encounter','26122c80-ab86-4953-a4aa-7931dda00d3e'),
 (4,2,'2013-11-04 16:33:32',NULL,NULL,'identifier','org.openmrs.logic.datasource.PatientDataSource','identifier','identifier','2b3cedce-2b8f-4434-ba79-d55e15fc47c8'),
 (5,2,'2013-11-04 16:33:32',NULL,NULL,'family name','org.openmrs.logic.datasource.PersonDataSource','family name','family name','940803cc-2819-4737-bbd6-893753434311'),
 (6,2,'2013-11-04 16:33:32',NULL,NULL,'middle name','org.openmrs.logic.datasource.PersonDataSource','middle name','middle name','943231ee-7169-4a71-acda-811a505e8876'),
 (7,2,'2013-11-04 16:33:32',NULL,NULL,'death date','org.openmrs.logic.datasource.PersonDataSource','death date','death date','23291e74-227e-41c8-bbf7-cb0d4f4281e6'),
 (8,2,'2013-11-04 16:33:32',NULL,NULL,'birthdate','org.openmrs.logic.datasource.PersonDataSource','birthdate','birthdate','9447b9dc-0833-4eac-bb00-6e0239826206'),
 (9,2,'2013-11-04 16:33:33',NULL,NULL,'cause of death','org.openmrs.logic.datasource.PersonDataSource','cause of death','cause of death','2f8e7f15-33b1-4393-9c61-c99980c81b68'),
 (10,2,'2013-11-04 16:33:33',NULL,NULL,'birthdate estimated','org.openmrs.logic.datasource.PersonDataSource','birthdate estimated','birthdate estimated','e58d6815-497f-489e-b3e2-71d98dd4ca2c'),
 (11,2,'2013-11-04 16:33:33',NULL,NULL,'gender','org.openmrs.logic.datasource.PersonDataSource','gender','gender','9eb0648e-4855-4fcb-a168-a99acc84a5cd'),
 (12,2,'2013-11-04 16:33:33',NULL,NULL,'family name2','org.openmrs.logic.datasource.PersonDataSource','family name2','family name2','64a0ea3e-6b14-4ba3-a917-41d11f797dc0'),
 (13,2,'2013-11-04 16:33:33',NULL,NULL,'dead','org.openmrs.logic.datasource.PersonDataSource','dead','dead','161eaecb-6b92-4400-bfbb-e99ae5e8e254'),
 (14,2,'2013-11-04 16:33:33',NULL,NULL,'given name','org.openmrs.logic.datasource.PersonDataSource','given name','given name','4444b6a3-b3f6-47e6-9ba5-5d17c2380b7d'),
 (15,2,'2013-11-04 16:33:33',NULL,NULL,'CURRENT STATE','org.openmrs.logic.datasource.ProgramDataSource','CURRENT STATE','CURRENT STATE','338f4405-23d8-46ee-9549-6a534efb83db'),
 (16,2,'2013-11-04 16:33:33',NULL,NULL,'PROGRAM ENROLLMENT','org.openmrs.logic.datasource.ProgramDataSource','PROGRAM ENROLLMENT','PROGRAM ENROLLMENT','46b24b44-144a-4bd4-bed1-f62d1aebe6a1'),
 (17,2,'2013-11-04 16:33:33',NULL,NULL,'PROGRAM COMPLETION','org.openmrs.logic.datasource.ProgramDataSource','PROGRAM COMPLETION','PROGRAM COMPLETION','d6d1ecfe-9c70-4ea1-8d33-8055af60878b');
/*!40000 ALTER TABLE `logic_token_registration` ENABLE KEYS */;


--
-- Definition of table `logic_token_registration_tag`
--

DROP TABLE IF EXISTS `logic_token_registration_tag`;
CREATE TABLE `logic_token_registration_tag` (
  `token_registration_id` int(11) NOT NULL,
  `tag` varchar(512) NOT NULL,
  KEY `token_registration_tag` (`token_registration_id`),
  CONSTRAINT `token_registration_tag` FOREIGN KEY (`token_registration_id`) REFERENCES `logic_token_registration` (`token_registration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `logic_token_registration_tag`
--

/*!40000 ALTER TABLE `logic_token_registration_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `logic_token_registration_tag` ENABLE KEYS */;


--
-- Definition of table `note`
--

DROP TABLE IF EXISTS `note`;
CREATE TABLE `note` (
  `note_id` int(11) NOT NULL DEFAULT '0',
  `note_type` varchar(50) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `obs_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `text` text NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`note_id`),
  UNIQUE KEY `note_uuid_index` (`uuid`),
  KEY `user_who_changed_note` (`changed_by`),
  KEY `user_who_created_note` (`creator`),
  KEY `encounter_note` (`encounter_id`),
  KEY `obs_note` (`obs_id`),
  KEY `note_hierarchy` (`parent`),
  KEY `patient_note` (`patient_id`),
  CONSTRAINT `encounter_note` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `note_hierarchy` FOREIGN KEY (`parent`) REFERENCES `note` (`note_id`),
  CONSTRAINT `obs_note` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `patient_note` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `user_who_changed_note` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_note` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `note`
--

/*!40000 ALTER TABLE `note` DISABLE KEYS */;
/*!40000 ALTER TABLE `note` ENABLE KEYS */;


--
-- Definition of table `notification_alert`
--

DROP TABLE IF EXISTS `notification_alert`;
CREATE TABLE `notification_alert` (
  `alert_id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(512) NOT NULL,
  `satisfied_by_any` tinyint(1) NOT NULL DEFAULT '0',
  `alert_read` tinyint(1) NOT NULL DEFAULT '0',
  `date_to_expire` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`alert_id`),
  UNIQUE KEY `notification_alert_uuid_index` (`uuid`),
  KEY `alert_date_to_expire_idx` (`date_to_expire`),
  KEY `user_who_changed_alert` (`changed_by`),
  KEY `alert_creator` (`creator`),
  CONSTRAINT `alert_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_alert` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `notification_alert`
--

/*!40000 ALTER TABLE `notification_alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_alert` ENABLE KEYS */;


--
-- Definition of table `notification_alert_recipient`
--

DROP TABLE IF EXISTS `notification_alert_recipient`;
CREATE TABLE `notification_alert_recipient` (
  `alert_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `alert_read` tinyint(1) NOT NULL DEFAULT '0',
  `date_changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`alert_id`,`user_id`),
  KEY `alert_read_by_user` (`user_id`),
  CONSTRAINT `alert_read_by_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `id_of_alert` FOREIGN KEY (`alert_id`) REFERENCES `notification_alert` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `notification_alert_recipient`
--

/*!40000 ALTER TABLE `notification_alert_recipient` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_alert_recipient` ENABLE KEYS */;


--
-- Definition of table `notification_template`
--

DROP TABLE IF EXISTS `notification_template`;
CREATE TABLE `notification_template` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `template` text,
  `subject` varchar(100) DEFAULT NULL,
  `sender` varchar(255) DEFAULT NULL,
  `recipients` varchar(512) DEFAULT NULL,
  `ordinal` int(11) DEFAULT '0',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `notification_template_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `notification_template`
--

/*!40000 ALTER TABLE `notification_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_template` ENABLE KEYS */;


--
-- Definition of table `obs`
--

DROP TABLE IF EXISTS `obs`;
CREATE TABLE `obs` (
  `obs_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `encounter_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `obs_datetime` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `location_id` int(11) DEFAULT NULL,
  `obs_group_id` int(11) DEFAULT NULL,
  `accession_number` varchar(255) DEFAULT NULL,
  `value_group_id` int(11) DEFAULT NULL,
  `value_boolean` tinyint(1) DEFAULT NULL,
  `value_coded` int(11) DEFAULT NULL,
  `value_coded_name_id` int(11) DEFAULT NULL,
  `value_drug` int(11) DEFAULT NULL,
  `value_datetime` datetime DEFAULT NULL,
  `value_numeric` double DEFAULT NULL,
  `value_modifier` varchar(2) DEFAULT NULL,
  `value_text` text,
  `value_complex` varchar(255) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `previous_version` int(11) DEFAULT NULL,
  PRIMARY KEY (`obs_id`),
  UNIQUE KEY `obs_uuid_index` (`uuid`),
  KEY `obs_datetime_idx` (`obs_datetime`),
  KEY `obs_concept` (`concept_id`),
  KEY `obs_enterer` (`creator`),
  KEY `encounter_observations` (`encounter_id`),
  KEY `obs_location` (`location_id`),
  KEY `obs_grouping_id` (`obs_group_id`),
  KEY `obs_order` (`order_id`),
  KEY `person_obs` (`person_id`),
  KEY `answer_concept` (`value_coded`),
  KEY `obs_name_of_coded_value` (`value_coded_name_id`),
  KEY `answer_concept_drug` (`value_drug`),
  KEY `user_who_voided_obs` (`voided_by`),
  KEY `previous_version` (`previous_version`),
  CONSTRAINT `answer_concept` FOREIGN KEY (`value_coded`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `answer_concept_drug` FOREIGN KEY (`value_drug`) REFERENCES `drug` (`drug_id`),
  CONSTRAINT `encounter_observations` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `obs_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `obs_enterer` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `obs_grouping_id` FOREIGN KEY (`obs_group_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `obs_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `obs_name_of_coded_value` FOREIGN KEY (`value_coded_name_id`) REFERENCES `concept_name` (`concept_name_id`),
  CONSTRAINT `obs_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `person_obs` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `previous_version` FOREIGN KEY (`previous_version`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `user_who_voided_obs` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `obs`
--

/*!40000 ALTER TABLE `obs` DISABLE KEYS */;
INSERT INTO `obs` (`obs_id`,`person_id`,`concept_id`,`encounter_id`,`order_id`,`obs_datetime`,`location_id`,`obs_group_id`,`accession_number`,`value_group_id`,`value_boolean`,`value_coded`,`value_coded_name_id`,`value_drug`,`value_datetime`,`value_numeric`,`value_modifier`,`value_text`,`value_complex`,`comments`,`creator`,`date_created`,`voided`,`voided_by`,`date_voided`,`void_reason`,`uuid`,`previous_version`) VALUES 
 (1,23,7,10,NULL,'2013-11-12 20:34:04',3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Reason',NULL,NULL,1,'2013-11-19 12:59:56',0,NULL,NULL,NULL,'de5b3a34-d36c-4a89-9996-f778bea043b1',NULL),
 (2,23,8,10,NULL,'2013-11-12 20:34:04',3,NULL,NULL,NULL,NULL,11,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2013-11-19 12:59:56',0,NULL,NULL,NULL,'3bedb700-931f-4c7e-bbdc-2a3af87631c5',NULL),
 (3,23,6,10,NULL,'2013-11-12 20:34:04',3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Healthcare unit/clinic',NULL,NULL,1,'2013-11-19 12:59:56',0,NULL,NULL,NULL,'4f41fba6-841c-4710-81d5-9f95e1f3e139',NULL),
 (4,23,5,10,NULL,'2013-11-12 00:00:00',3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2013-10-29 00:00:00',NULL,NULL,NULL,NULL,NULL,1,'2013-11-19 12:59:56',0,NULL,NULL,NULL,'52a91d08-39da-45ea-8402-8804ce9f7873',NULL);
/*!40000 ALTER TABLE `obs` ENABLE KEYS */;


--
-- Definition of table `order_type`
--

DROP TABLE IF EXISTS `order_type`;
CREATE TABLE `order_type` (
  `order_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`order_type_id`),
  UNIQUE KEY `order_type_uuid_index` (`uuid`),
  KEY `order_type_retired_status` (`retired`),
  KEY `type_created_by` (`creator`),
  KEY `user_who_retired_order_type` (`retired_by`),
  CONSTRAINT `type_created_by` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_order_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_type`
--

/*!40000 ALTER TABLE `order_type` DISABLE KEYS */;
INSERT INTO `order_type` (`order_type_id`,`name`,`description`,`creator`,`date_created`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (2,'Drug Order','An order for a medication to be given to the patient',1,'2010-05-12 00:00:00',0,NULL,NULL,NULL,'131168f4-15f5-102d-96e4-000c29c2a5d7');
/*!40000 ALTER TABLE `order_type` ENABLE KEYS */;


--
-- Definition of table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_type_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `orderer` int(11) DEFAULT '0',
  `encounter_id` int(11) DEFAULT NULL,
  `instructions` text,
  `start_date` datetime DEFAULT NULL,
  `auto_expire_date` datetime DEFAULT NULL,
  `discontinued` tinyint(1) NOT NULL DEFAULT '0',
  `discontinued_date` datetime DEFAULT NULL,
  `discontinued_by` int(11) DEFAULT NULL,
  `discontinued_reason` int(11) DEFAULT NULL,
  `discontinued_reason_non_coded` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `accession_number` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `urgency` varchar(50) NOT NULL DEFAULT 'ROUTINE',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `orders_uuid_index` (`uuid`),
  KEY `order_creator` (`creator`),
  KEY `user_who_discontinued_order` (`discontinued_by`),
  KEY `discontinued_because` (`discontinued_reason`),
  KEY `orders_in_encounter` (`encounter_id`),
  KEY `type_of_order` (`order_type_id`),
  KEY `orderer_not_drug` (`orderer`),
  KEY `order_for_patient` (`patient_id`),
  KEY `user_who_voided_order` (`voided_by`),
  CONSTRAINT `discontinued_because` FOREIGN KEY (`discontinued_reason`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `orderer_not_drug` FOREIGN KEY (`orderer`) REFERENCES `users` (`user_id`),
  CONSTRAINT `orders_in_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `order_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_for_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `type_of_order` FOREIGN KEY (`order_type_id`) REFERENCES `order_type` (`order_type_id`),
  CONSTRAINT `user_who_discontinued_order` FOREIGN KEY (`discontinued_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_order` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;


--
-- Definition of table `patient`
--

DROP TABLE IF EXISTS `patient`;
CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `tribe` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  KEY `user_who_changed_pat` (`changed_by`),
  KEY `user_who_created_patient` (`creator`),
  KEY `user_who_voided_patient` (`voided_by`),
  CONSTRAINT `person_id_for_patient` FOREIGN KEY (`patient_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `user_who_changed_pat` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_patient` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_patient` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patient`
--

/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` (`patient_id`,`tribe`,`creator`,`date_created`,`changed_by`,`date_changed`,`voided`,`voided_by`,`date_voided`,`void_reason`) VALUES 
 (23,NULL,1,'2013-11-12 14:12:40',1,'2013-11-20 12:43:20',0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;


--
-- Definition of table `patient_identifier`
--

DROP TABLE IF EXISTS `patient_identifier`;
CREATE TABLE `patient_identifier` (
  `patient_identifier_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `identifier_type` int(11) NOT NULL DEFAULT '0',
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `location_id` int(11) DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`patient_identifier_id`),
  UNIQUE KEY `patient_identifier_uuid_index` (`uuid`),
  KEY `identifier_name` (`identifier`),
  KEY `idx_patient_identifier_patient` (`patient_id`),
  KEY `identifier_creator` (`creator`),
  KEY `defines_identifier_type` (`identifier_type`),
  KEY `patient_identifier_ibfk_2` (`location_id`),
  KEY `identifier_voider` (`voided_by`),
  KEY `patient_identifier_changed_by` (`changed_by`),
  CONSTRAINT `defines_identifier_type` FOREIGN KEY (`identifier_type`) REFERENCES `patient_identifier_type` (`patient_identifier_type_id`),
  CONSTRAINT `identifier_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `identifier_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_identifier_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_identifier_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patient_identifier`
--

/*!40000 ALTER TABLE `patient_identifier` DISABLE KEYS */;
INSERT INTO `patient_identifier` (`patient_identifier_id`,`patient_id`,`identifier`,`identifier_type`,`preferred`,`location_id`,`creator`,`date_created`,`date_changed`,`changed_by`,`voided`,`voided_by`,`date_voided`,`void_reason`,`uuid`) VALUES 
 (21,23,'4dbd7470-3c0d-11e3-9287-22000a9aa860',7,1,2,1,'2013-11-12 14:12:40','2013-11-19 12:44:12',1,0,NULL,NULL,NULL,'20f29551-223e-4c5f-bbac-8f6f5899896b');
/*!40000 ALTER TABLE `patient_identifier` ENABLE KEYS */;


--
-- Definition of table `patient_identifier_type`
--

DROP TABLE IF EXISTS `patient_identifier_type`;
CREATE TABLE `patient_identifier_type` (
  `patient_identifier_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `format` varchar(255) DEFAULT NULL,
  `check_digit` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `format_description` varchar(255) DEFAULT NULL,
  `validator` varchar(200) DEFAULT NULL,
  `location_behavior` varchar(50) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`patient_identifier_type_id`),
  UNIQUE KEY `patient_identifier_type_uuid_index` (`uuid`),
  KEY `patient_identifier_type_retired_status` (`retired`),
  KEY `type_creator` (`creator`),
  KEY `user_who_retired_patient_identifier_type` (`retired_by`),
  CONSTRAINT `type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_patient_identifier_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patient_identifier_type`
--

/*!40000 ALTER TABLE `patient_identifier_type` DISABLE KEYS */;
INSERT INTO `patient_identifier_type` (`patient_identifier_type_id`,`name`,`description`,`format`,`check_digit`,`creator`,`date_created`,`required`,`format_description`,`validator`,`location_behavior`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (1,'OpenMRS Identification Number','Unique number used in OpenMRS','',1,1,'2005-09-22 00:00:00',0,NULL,'org.openmrs.patient.impl.LuhnIdentifierValidator',NULL,0,NULL,NULL,NULL,'8d793bee-c2cc-11de-8d13-0010c6dffd0f'),
 (2,'Old Identification Number','Number given out prior to the OpenMRS system (No check digit)','',0,1,'2005-09-22 00:00:00',0,NULL,NULL,NULL,0,NULL,NULL,NULL,'8d79403a-c2cc-11de-8d13-0010c6dffd0f'),
 (3,'NID','NID',NULL,0,1,'2013-11-05 10:33:43',0,NULL,NULL,NULL,0,NULL,NULL,NULL,'141753ab-02f7-4266-b239-2ff72f99ce5f'),
 (7,'ECID','ECID',NULL,0,1,'2013-11-19 12:43:21',0,NULL,NULL,NULL,0,NULL,NULL,NULL,'2ea3941a-8287-4725-985d-9be6d97d29e2');
/*!40000 ALTER TABLE `patient_identifier_type` ENABLE KEYS */;


--
-- Definition of table `patient_program`
--

DROP TABLE IF EXISTS `patient_program`;
CREATE TABLE `patient_program` (
  `patient_program_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `program_id` int(11) NOT NULL DEFAULT '0',
  `date_enrolled` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `outcome_concept_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`patient_program_id`),
  UNIQUE KEY `patient_program_uuid_index` (`uuid`),
  KEY `user_who_changed` (`changed_by`),
  KEY `patient_program_creator` (`creator`),
  KEY `patient_in_program` (`patient_id`),
  KEY `program_for_patient` (`program_id`),
  KEY `user_who_voided_patient_program` (`voided_by`),
  KEY `patient_program_location_id` (`location_id`),
  KEY `patient_program_outcome_concept_id_fk` (`outcome_concept_id`),
  CONSTRAINT `patient_in_program` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `patient_program_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_program_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `patient_program_outcome_concept_id_fk` FOREIGN KEY (`outcome_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `program_for_patient` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  CONSTRAINT `user_who_changed` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_patient_program` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patient_program`
--

/*!40000 ALTER TABLE `patient_program` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_program` ENABLE KEYS */;


--
-- Definition of table `patient_state`
--

DROP TABLE IF EXISTS `patient_state`;
CREATE TABLE `patient_state` (
  `patient_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_program_id` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`patient_state_id`),
  UNIQUE KEY `patient_state_uuid_index` (`uuid`),
  KEY `patient_state_changer` (`changed_by`),
  KEY `patient_state_creator` (`creator`),
  KEY `patient_program_for_state` (`patient_program_id`),
  KEY `state_for_patient` (`state`),
  KEY `patient_state_voider` (`voided_by`),
  CONSTRAINT `patient_program_for_state` FOREIGN KEY (`patient_program_id`) REFERENCES `patient_program` (`patient_program_id`),
  CONSTRAINT `patient_state_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_state_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_state_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `state_for_patient` FOREIGN KEY (`state`) REFERENCES `program_workflow_state` (`program_workflow_state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patient_state`
--

/*!40000 ALTER TABLE `patient_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_state` ENABLE KEYS */;


--
-- Definition of table `patientflags_displaypoint`
--

DROP TABLE IF EXISTS `patientflags_displaypoint`;
CREATE TABLE `patientflags_displaypoint` (
  `displaypoint_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`displaypoint_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patientflags_displaypoint`
--

/*!40000 ALTER TABLE `patientflags_displaypoint` DISABLE KEYS */;
INSERT INTO `patientflags_displaypoint` (`displaypoint_id`,`name`,`description`,`creator`,`date_created`,`changed_by`,`date_changed`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (1,'Patient Dashboard Header',NULL,0,'2013-11-04 16:33:00',NULL,NULL,0,NULL,NULL,NULL,'acc2fe99-4598-11e3-9d2c-f9d02340d97d'),
 (2,'Patient Dashboard Overview',NULL,0,'2013-11-04 16:33:00',NULL,NULL,0,NULL,NULL,NULL,'acc3027c-4598-11e3-9d2c-f9d02340d97d');
/*!40000 ALTER TABLE `patientflags_displaypoint` ENABLE KEYS */;


--
-- Definition of table `patientflags_flag`
--

DROP TABLE IF EXISTS `patientflags_flag`;
CREATE TABLE `patientflags_flag` (
  `flag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `criteria` varchar(5000) NOT NULL,
  `message` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `evaluator` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `priority_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`flag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patientflags_flag`
--

/*!40000 ALTER TABLE `patientflags_flag` DISABLE KEYS */;
/*!40000 ALTER TABLE `patientflags_flag` ENABLE KEYS */;


--
-- Definition of table `patientflags_flag_tag`
--

DROP TABLE IF EXISTS `patientflags_flag_tag`;
CREATE TABLE `patientflags_flag_tag` (
  `flag_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  KEY `flag_id` (`flag_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `patientflags_flag_tag_ibfk_1` FOREIGN KEY (`flag_id`) REFERENCES `patientflags_flag` (`flag_id`),
  CONSTRAINT `patientflags_flag_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `patientflags_tag` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patientflags_flag_tag`
--

/*!40000 ALTER TABLE `patientflags_flag_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `patientflags_flag_tag` ENABLE KEYS */;


--
-- Definition of table `patientflags_priority`
--

DROP TABLE IF EXISTS `patientflags_priority`;
CREATE TABLE `patientflags_priority` (
  `priority_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `style` varchar(255) NOT NULL,
  `rank` int(11) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`priority_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patientflags_priority`
--

/*!40000 ALTER TABLE `patientflags_priority` DISABLE KEYS */;
/*!40000 ALTER TABLE `patientflags_priority` ENABLE KEYS */;


--
-- Definition of table `patientflags_tag`
--

DROP TABLE IF EXISTS `patientflags_tag`;
CREATE TABLE `patientflags_tag` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patientflags_tag`
--

/*!40000 ALTER TABLE `patientflags_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `patientflags_tag` ENABLE KEYS */;


--
-- Definition of table `patientflags_tag_displaypoint`
--

DROP TABLE IF EXISTS `patientflags_tag_displaypoint`;
CREATE TABLE `patientflags_tag_displaypoint` (
  `tag_id` int(11) NOT NULL,
  `displaypoint_id` int(11) NOT NULL,
  KEY `tag_id` (`tag_id`),
  KEY `displaypoint_id` (`displaypoint_id`),
  CONSTRAINT `patientflags_tag_displaypoint_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `patientflags_tag` (`tag_id`),
  CONSTRAINT `patientflags_tag_displaypoint_ibfk_2` FOREIGN KEY (`displaypoint_id`) REFERENCES `patientflags_displaypoint` (`displaypoint_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patientflags_tag_displaypoint`
--

/*!40000 ALTER TABLE `patientflags_tag_displaypoint` DISABLE KEYS */;
/*!40000 ALTER TABLE `patientflags_tag_displaypoint` ENABLE KEYS */;


--
-- Definition of table `patientflags_tag_role`
--

DROP TABLE IF EXISTS `patientflags_tag_role`;
CREATE TABLE `patientflags_tag_role` (
  `tag_id` int(11) NOT NULL,
  `role` varchar(50) NOT NULL,
  KEY `tag_id` (`tag_id`),
  KEY `role` (`role`),
  CONSTRAINT `patientflags_tag_role_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `patientflags_tag` (`tag_id`),
  CONSTRAINT `patientflags_tag_role_ibfk_2` FOREIGN KEY (`role`) REFERENCES `role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patientflags_tag_role`
--

/*!40000 ALTER TABLE `patientflags_tag_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `patientflags_tag_role` ENABLE KEYS */;


--
-- Definition of table `person`
--

DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `person_id` int(11) NOT NULL AUTO_INCREMENT,
  `gender` varchar(50) DEFAULT '',
  `birthdate` date DEFAULT NULL,
  `birthdate_estimated` tinyint(1) NOT NULL DEFAULT '0',
  `dead` tinyint(1) NOT NULL DEFAULT '0',
  `death_date` datetime DEFAULT NULL,
  `cause_of_death` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`person_id`),
  UNIQUE KEY `person_uuid_index` (`uuid`),
  KEY `person_birthdate` (`birthdate`),
  KEY `person_death_date` (`death_date`),
  KEY `person_died_because` (`cause_of_death`),
  KEY `user_who_changed_person` (`changed_by`),
  KEY `user_who_created_person` (`creator`),
  KEY `user_who_voided_person` (`voided_by`),
  CONSTRAINT `person_died_because` FOREIGN KEY (`cause_of_death`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_changed_person` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_person` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_person` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `person`
--

/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` (`person_id`,`gender`,`birthdate`,`birthdate_estimated`,`dead`,`death_date`,`cause_of_death`,`creator`,`date_created`,`changed_by`,`date_changed`,`voided`,`voided_by`,`date_voided`,`void_reason`,`uuid`) VALUES 
 (1,'M',NULL,0,0,NULL,NULL,1,'2005-01-01 00:00:00',1,'2013-11-12 15:33:18',0,NULL,NULL,NULL,'01822713-4598-11e3-9d2c-f9d02340d97d'),
 (18,'M','1973-01-01',1,0,NULL,NULL,1,'2013-11-05 14:05:49',1,'2013-12-06 11:34:07',0,NULL,NULL,NULL,'7a73fa85-a077-4cc3-b5c8-7dc79ef15fe0'),
 (23,'F','1968-01-01',1,0,NULL,NULL,1,'2013-11-12 14:12:40',1,'2013-11-20 12:43:20',0,NULL,NULL,NULL,'ef010cba-ce2b-4187-9503-58fb1a955c47');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;


--
-- Definition of table `person_address`
--

DROP TABLE IF EXISTS `person_address`;
CREATE TABLE `person_address` (
  `person_address_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city_village` varchar(255) DEFAULT NULL,
  `state_province` varchar(255) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `county_district` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `address4` varchar(255) DEFAULT NULL,
  `address5` varchar(255) DEFAULT NULL,
  `address6` varchar(255) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`person_address_id`),
  UNIQUE KEY `person_address_uuid_index` (`uuid`),
  KEY `patient_address_creator` (`creator`),
  KEY `address_for_person` (`person_id`),
  KEY `patient_address_void` (`voided_by`),
  KEY `person_address_changed_by` (`changed_by`),
  KEY `person_address_date_created_index` (`date_created`),
  CONSTRAINT `address_for_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `patient_address_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_address_void` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `person_address_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `person_address`
--

/*!40000 ALTER TABLE `person_address` DISABLE KEYS */;
INSERT INTO `person_address` (`person_address_id`,`person_id`,`preferred`,`address1`,`address2`,`city_village`,`state_province`,`postal_code`,`country`,`latitude`,`longitude`,`start_date`,`end_date`,`creator`,`date_created`,`voided`,`voided_by`,`date_voided`,`void_reason`,`county_district`,`address3`,`address4`,`address5`,`address6`,`date_changed`,`changed_by`,`uuid`) VALUES 
 (1,23,1,'Buhoro',NULL,'Kimisagara','Kigali Province',NULL,'Rwanda',NULL,NULL,NULL,NULL,1,'2013-11-12 14:12:40',0,NULL,NULL,NULL,'Nyarugenge','Kamuhoza',NULL,NULL,NULL,NULL,NULL,'cb1eb70c-e3dc-4073-ac3d-41b51166ebdf'),
 (2,18,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2013-12-06 11:33:57',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2013-12-06 11:34:07',1,'b64bf4b9-c40c-4162-9922-ce65eddf5847');
/*!40000 ALTER TABLE `person_address` ENABLE KEYS */;


--
-- Definition of table `person_attribute`
--

DROP TABLE IF EXISTS `person_attribute`;
CREATE TABLE `person_attribute` (
  `person_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(50) NOT NULL DEFAULT '',
  `person_attribute_type_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`person_attribute_id`),
  UNIQUE KEY `person_attribute_uuid_index` (`uuid`),
  KEY `attribute_changer` (`changed_by`),
  KEY `attribute_creator` (`creator`),
  KEY `defines_attribute_type` (`person_attribute_type_id`),
  KEY `identifies_person` (`person_id`),
  KEY `attribute_voider` (`voided_by`),
  CONSTRAINT `attribute_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `attribute_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `attribute_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `defines_attribute_type` FOREIGN KEY (`person_attribute_type_id`) REFERENCES `person_attribute_type` (`person_attribute_type_id`),
  CONSTRAINT `identifies_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `person_attribute`
--

/*!40000 ALTER TABLE `person_attribute` DISABLE KEYS */;
INSERT INTO `person_attribute` (`person_attribute_id`,`person_id`,`value`,`person_attribute_type_id`,`creator`,`date_created`,`changed_by`,`date_changed`,`voided`,`voided_by`,`date_voided`,`void_reason`,`uuid`) VALUES 
 (1,18,'e8597a14-436f-1031-8b61-8d373bf4f88f',9,1,'2013-11-05 14:05:49',1,'2013-12-06 11:34:07',1,1,'2013-12-06 11:34:07','New value:','877663ec-21b6-4b20-a9ad-57142ff2f51a');
/*!40000 ALTER TABLE `person_attribute` ENABLE KEYS */;


--
-- Definition of table `person_attribute_type`
--

DROP TABLE IF EXISTS `person_attribute_type`;
CREATE TABLE `person_attribute_type` (
  `person_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `format` varchar(50) DEFAULT NULL,
  `foreign_key` int(11) DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `edit_privilege` varchar(50) DEFAULT NULL,
  `sort_weight` double DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`person_attribute_type_id`),
  UNIQUE KEY `person_attribute_type_uuid_index` (`uuid`),
  KEY `attribute_is_searchable` (`searchable`),
  KEY `name_of_attribute` (`name`),
  KEY `person_attribute_type_retired_status` (`retired`),
  KEY `attribute_type_changer` (`changed_by`),
  KEY `attribute_type_creator` (`creator`),
  KEY `user_who_retired_person_attribute_type` (`retired_by`),
  KEY `privilege_which_can_edit` (`edit_privilege`),
  CONSTRAINT `attribute_type_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `attribute_type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `privilege_which_can_edit` FOREIGN KEY (`edit_privilege`) REFERENCES `privilege` (`privilege`),
  CONSTRAINT `user_who_retired_person_attribute_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `person_attribute_type`
--

/*!40000 ALTER TABLE `person_attribute_type` DISABLE KEYS */;
INSERT INTO `person_attribute_type` (`person_attribute_type_id`,`name`,`description`,`format`,`foreign_key`,`searchable`,`creator`,`date_created`,`changed_by`,`date_changed`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`edit_privilege`,`sort_weight`,`uuid`) VALUES 
 (1,'Race','Group of persons related by common descent or heredity','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,6,'8d871386-c2cc-11de-8d13-0010c6dffd0f'),
 (2,'Birthplace','Location of persons birth','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,0,'8d8718c2-c2cc-11de-8d13-0010c6dffd0f'),
 (3,'Citizenship','Country of which this person is a member','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,1,'8d871afc-c2cc-11de-8d13-0010c6dffd0f'),
 (4,'Mother\'s Name','First or last name of this person\'s mother','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,5,'8d871d18-c2cc-11de-8d13-0010c6dffd0f'),
 (5,'Civil Status','Marriage status of this person','org.openmrs.Concept',1054,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,2,'8d871f2a-c2cc-11de-8d13-0010c6dffd0f'),
 (6,'Health District','District/region in which this patient\' home health center resides','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,4,'8d872150-c2cc-11de-8d13-0010c6dffd0f'),
 (7,'Health Center','Specific Location of this person\'s home health center.','org.openmrs.Location',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,3,'8d87236c-c2cc-11de-8d13-0010c6dffd0f'),
 (8,'NID','NID','java.lang.String',NULL,0,1,'2013-11-05 13:59:18',NULL,NULL,0,NULL,NULL,NULL,NULL,7,'53c7b43c-65d3-4b9d-8e53-b6a68749c346'),
 (9,'EPID','EPID',NULL,NULL,0,1,'2013-12-06 11:23:50',1,'2013-12-06 11:25:07',0,NULL,NULL,NULL,NULL,8,'dc39a13c-e9d8-4e75-b20e-0575548f7b65');
/*!40000 ALTER TABLE `person_attribute_type` ENABLE KEYS */;


--
-- Definition of table `person_merge_log`
--

DROP TABLE IF EXISTS `person_merge_log`;
CREATE TABLE `person_merge_log` (
  `person_merge_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `winner_person_id` int(11) NOT NULL,
  `loser_person_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `merged_data` longtext NOT NULL,
  `uuid` char(38) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_merge_log_id`),
  UNIQUE KEY `person_merge_log_unique_uuid` (`uuid`),
  KEY `person_merge_log_winner` (`winner_person_id`),
  KEY `person_merge_log_loser` (`loser_person_id`),
  KEY `person_merge_log_creator` (`creator`),
  KEY `person_merge_log_changed_by_fk` (`changed_by`),
  KEY `person_merge_log_voided_by_fk` (`voided_by`),
  CONSTRAINT `person_merge_log_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `person_merge_log_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `person_merge_log_loser` FOREIGN KEY (`loser_person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `person_merge_log_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `person_merge_log_winner` FOREIGN KEY (`winner_person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `person_merge_log`
--

/*!40000 ALTER TABLE `person_merge_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_merge_log` ENABLE KEYS */;


--
-- Definition of table `person_name`
--

DROP TABLE IF EXISTS `person_name`;
CREATE TABLE `person_name` (
  `person_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `person_id` int(11) NOT NULL,
  `prefix` varchar(50) DEFAULT NULL,
  `given_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `family_name_prefix` varchar(50) DEFAULT NULL,
  `family_name` varchar(50) DEFAULT NULL,
  `family_name2` varchar(50) DEFAULT NULL,
  `family_name_suffix` varchar(50) DEFAULT NULL,
  `degree` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`person_name_id`),
  UNIQUE KEY `person_name_uuid_index` (`uuid`),
  KEY `first_name` (`given_name`),
  KEY `last_name` (`family_name`),
  KEY `middle_name` (`middle_name`),
  KEY `family_name2` (`family_name2`),
  KEY `user_who_made_name` (`creator`),
  KEY `name_for_person` (`person_id`),
  KEY `user_who_voided_name` (`voided_by`),
  CONSTRAINT `name_for_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `user_who_made_name` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_name` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `person_name`
--

/*!40000 ALTER TABLE `person_name` DISABLE KEYS */;
INSERT INTO `person_name` (`person_name_id`,`preferred`,`person_id`,`prefix`,`given_name`,`middle_name`,`family_name_prefix`,`family_name`,`family_name2`,`family_name_suffix`,`degree`,`creator`,`date_created`,`voided`,`voided_by`,`date_voided`,`void_reason`,`changed_by`,`date_changed`,`uuid`) VALUES 
 (1,1,1,NULL,'Super',NULL,NULL,'User',NULL,NULL,NULL,1,'2005-01-01 00:00:00',0,NULL,NULL,NULL,1,'2013-11-12 15:33:18','0194a031-4598-11e3-9d2c-f9d02340d97d'),
 (18,1,18,NULL,'John',NULL,NULL,'Doctor',NULL,NULL,NULL,1,'2013-11-05 14:05:49',0,NULL,NULL,NULL,NULL,NULL,'c4905163-11e0-4bd0-b207-8a23140683c6'),
 (23,1,23,NULL,'Penny',NULL,NULL,'Patient',NULL,NULL,NULL,1,'2013-11-12 14:12:40',0,NULL,NULL,NULL,1,'2013-11-20 12:43:20','3e20292c-4d08-4419-a732-79b99c6a3582');
/*!40000 ALTER TABLE `person_name` ENABLE KEYS */;


--
-- Definition of table `privilege`
--

DROP TABLE IF EXISTS `privilege`;
CREATE TABLE `privilege` (
  `privilege` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(250) NOT NULL DEFAULT '',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`privilege`),
  UNIQUE KEY `privilege_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `privilege`
--

/*!40000 ALTER TABLE `privilege` DISABLE KEYS */;
INSERT INTO `privilege` (`privilege`,`description`,`uuid`) VALUES 
 ('Add Allergies','Add allergies','46a82c14-9a7a-41e3-85c1-244bec4e5648'),
 ('Add Cohorts','Able to add a cohort to the system','019ad0e7-4598-11e3-9d2c-f9d02340d97d'),
 ('Add Concept Proposals','Able to add concept proposals to the system','019ad9a7-4598-11e3-9d2c-f9d02340d97d'),
 ('Add Encounters','Able to add patient encounters','019adf9d-4598-11e3-9d2c-f9d02340d97d'),
 ('Add HL7 Inbound Archive','Able to add an HL7 archive item','6adf1864-2c0e-436c-b7f0-1dd0a8b9dfda'),
 ('Add HL7 Inbound Exception','Able to add an HL7 error item','a44d73c8-08fd-4b38-97fa-3a442613cd59'),
 ('Add HL7 Inbound Queue','Able to add an HL7 Queue item','c3d024f7-90e4-4eec-8b47-525f96582823'),
 ('Add HL7 Source','Able to add an HL7 Source','05b85c12-c85a-4abd-8ef2-a5e203a0de3d'),
 ('Add Observations','Able to add patient observations','019ae574-4598-11e3-9d2c-f9d02340d97d'),
 ('Add Orders','Able to add orders','019aeb15-4598-11e3-9d2c-f9d02340d97d'),
 ('Add Patient Identifiers','Able to add patient identifiers','019af0f5-4598-11e3-9d2c-f9d02340d97d'),
 ('Add Patient Programs','Able to add patients to programs','019af6f9-4598-11e3-9d2c-f9d02340d97d'),
 ('Add Patients','Able to add patients','019afd05-4598-11e3-9d2c-f9d02340d97d'),
 ('Add People','Able to add person objects','019b0287-4598-11e3-9d2c-f9d02340d97d'),
 ('Add Problems','Add problems','e18dae14-f345-49a7-bd8a-11a964fe2d9b'),
 ('Add Relationships','Able to add relationships','019b0685-4598-11e3-9d2c-f9d02340d97d'),
 ('Add Report Objects','Able to add report objects','019b0aa2-4598-11e3-9d2c-f9d02340d97d'),
 ('Add Reports','Able to add reports','019b0ea0-4598-11e3-9d2c-f9d02340d97d'),
 ('Add Users','Able to add users to OpenMRS','019b1299-4598-11e3-9d2c-f9d02340d97d'),
 ('Add Visits','Able to add visits','318d025c-6e1d-4696-9cf5-b9d8594fbcf8'),
 ('Assign System Developer Role','Able to assign System Developer role','4455659b-d488-4176-9c34-556747d9ce24'),
 ('Configure Visits','Able to choose encounter visit handler and enable/disable encounter visits','620c9a60-d1ab-46cc-bb05-a518f447bb6d'),
 ('Create Regimen','Able to create a new regimen','bdc45b54-9c78-422e-a010-8b7b53ac55aa'),
 ('Delete Cohorts','Able to add a cohort to the system','019b168e-4598-11e3-9d2c-f9d02340d97d'),
 ('Delete Concept Proposals','Able to delete concept proposals from the system','019b1a7f-4598-11e3-9d2c-f9d02340d97d'),
 ('Delete Encounters','Able to delete patient encounters','019b1e97-4598-11e3-9d2c-f9d02340d97d'),
 ('Delete HL7 Inbound Archive','Able to delete/retire an HL7 archive item','3d5448da-b6b1-4b76-a4d0-fd9de79f72e9'),
 ('Delete HL7 Inbound Exception','Able to delete an HL7 archive item','93e6a4d8-4547-42ef-bf21-56eba95cae21'),
 ('Delete HL7 Inbound Queue','Able to delete an HL7 Queue item','0d8043c8-a960-4c8e-bc45-3cb8948c5581'),
 ('Delete Observations','Able to delete patient observations','019b2291-4598-11e3-9d2c-f9d02340d97d'),
 ('Delete Orders','Able to delete orders','019b268a-4598-11e3-9d2c-f9d02340d97d'),
 ('Delete Patient Identifiers','Able to delete patient identifiers','019b2a52-4598-11e3-9d2c-f9d02340d97d'),
 ('Delete Patient Programs','Able to delete patients from programs','019b2e59-4598-11e3-9d2c-f9d02340d97d'),
 ('Delete Patients','Able to delete patients','019b3284-4598-11e3-9d2c-f9d02340d97d'),
 ('Delete People','Able to delete objects','019b369c-4598-11e3-9d2c-f9d02340d97d'),
 ('Delete Regimen','Able to delete a regimen','0c48f898-c5c1-4ba4-b423-6790e504b839'),
 ('Delete Relationships','Able to delete relationships','019b3add-4598-11e3-9d2c-f9d02340d97d'),
 ('Delete Report Objects','Able to delete report objects','019b414b-4598-11e3-9d2c-f9d02340d97d'),
 ('Delete Reports','Able to delete reports','019b4591-4598-11e3-9d2c-f9d02340d97d'),
 ('Delete Users','Able to delete users in OpenMRS','019b497d-4598-11e3-9d2c-f9d02340d97d'),
 ('Delete Visits','Able to delete visits','46b0a061-0ae1-4115-9911-d05d03802c64'),
 ('Edit Allergies','Able to edit allergies','d799b12c-dd6d-432d-8c0c-d1140d33d9ac'),
 ('Edit Appointments','Able to edit a appointment','46198016-f283-4298-a7ff-2454bd5a8130'),
 ('Edit Cohorts','Able to add a cohort to the system','019b4d49-4598-11e3-9d2c-f9d02340d97d'),
 ('Edit Concept Proposals','Able to edit concept proposals in the system','019b510d-4598-11e3-9d2c-f9d02340d97d'),
 ('Edit Encounters','Able to edit patient encounters','019b54ec-4598-11e3-9d2c-f9d02340d97d'),
 ('Edit Observations','Able to edit patient observations','019b58cf-4598-11e3-9d2c-f9d02340d97d'),
 ('Edit Orders','Able to edit orders','019b5ca5-4598-11e3-9d2c-f9d02340d97d'),
 ('Edit Patient Identifiers','Able to edit patient identifiers','019b61fa-4598-11e3-9d2c-f9d02340d97d'),
 ('Edit Patient Programs','Able to edit patients in programs','019b664d-4598-11e3-9d2c-f9d02340d97d'),
 ('Edit Patients','Able to edit patients','019b6a5c-4598-11e3-9d2c-f9d02340d97d'),
 ('Edit People','Able to edit person objects','019b6e5f-4598-11e3-9d2c-f9d02340d97d'),
 ('Edit Problems','Able to edit problems','58cc0f6d-d385-49bf-8df6-1a50dce5db53'),
 ('Edit Relationships','Able to edit relationships','019b7234-4598-11e3-9d2c-f9d02340d97d'),
 ('Edit Report Objects','Able to edit report objects','019b7649-4598-11e3-9d2c-f9d02340d97d'),
 ('Edit Reports','Able to edit reports','019b7a3e-4598-11e3-9d2c-f9d02340d97d'),
 ('Edit User Passwords','Able to change the passwords of users in OpenMRS','019b7e25-4598-11e3-9d2c-f9d02340d97d'),
 ('Edit Users','Able to edit users in OpenMRS','019b8204-4598-11e3-9d2c-f9d02340d97d'),
 ('Edit Visits','Able to edit visits','e3ebf704-3e69-4154-9285-57dd6ed7e589'),
 ('Export Collective Patient Data','Able to export collective patient data','e68dd4e2-33f6-4c60-a295-e922e42c75b7'),
 ('Export Individual Patient Data','Able to export individual patient data','eeda334b-cc7e-4561-b727-a33da28fff18'),
 ('Form Entry','Allows user to access Form Entry pages/functions','019b85b1-4598-11e3-9d2c-f9d02340d97d'),
 ('Generate Batch of Identifiers','Allows user to generate a batch of identifiers to a file for offline use','46602a2d-4313-495e-a5bc-af90ff39ca65'),
 ('Get HL7 Templates','Ability to edit HL7 templates','df1e7b36-eba3-4649-b628-c0671dc75b76'),
 ('List Groovy Scripts','Allows user to view Groovy scripts which are saved.','fc87a0cc-c930-471b-a82a-c0522f94bdbc'),
 ('Manage Address Templates','Able to add/edit/delete address templates','012cd506-6d63-4e68-b678-7f68f452c901'),
 ('Manage Alerts','Able to add/edit/delete user alerts','019b8968-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Auto Generation Options','Allows user add, edit, and remove auto-generation options','f579c7e6-042f-497b-af3f-48a1e9bec825'),
 ('Manage Cohort Definitions','Add/Edit/Remove Cohort Definitions','ab61089b-6cc8-4a51-ad44-81b8c91d0a53'),
 ('Manage Concept Classes','Able to add/edit/retire concept classes','019b8eab-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Concept Datatypes','Able to add/edit/retire concept datatypes','019b929c-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Concept Map Types','Able to add/edit/retire concept map types','81047031-e722-4328-9a76-46aeae513a84'),
 ('Manage Concept Name tags','Able to add/edit/delete concept name tags','39b07191-5007-46eb-897d-13439801eedd'),
 ('Manage Concept Reference Terms','Able to add/edit/retire reference terms','ef72e9a8-0a1d-41c3-a57e-a808e679f137'),
 ('Manage Concept Sources','Able to add/edit/delete concept sources','019b969e-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Concept Stop Words','Able to view/add/remove the concept stop words','e094d970-b985-4e1a-8408-b80fb497e5e6'),
 ('Manage Concepts','Able to add/edit/delete concept entries','019b9a9c-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Data Set Definitions','Add/Edit/Remove Data Set Definitions','c3baad28-4d8a-4445-9845-caa1a8ac906e'),
 ('Manage Dimension Definitions','Add/Edit/Remove Dimension Definitions','3738f4ac-e156-451b-9a38-01353249e3e3'),
 ('Manage Encounter Roles','Able to add/edit/retire encounter roles','9e86cfe1-017f-4365-a2fe-2947e2483208'),
 ('Manage Encounter Types','Able to add/edit/delete encounter types','019b9eb0-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Field Types','Able to add/edit/retire field types','019ba2b7-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Flags','Allows user add, edit, and remove flags','7c0f87d1-9a33-4fad-be4e-a1c72735eac8'),
 ('Manage FormEntry XSN','Allows user to upload and edit the xsns stored on the server','019ba69a-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Forms','Able to add/edit/delete forms','019baa7d-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Global Properties','Able to add/edit global properties','019bae7b-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Hierarchy','Allows user to access Form Entry pages/functions','b83ccd55-f9e4-4ab5-bcc1-eed6ba02aca6'),
 ('Manage HL7 Messages','Able to add/edit/delete HL7 messages','e7cd8b40-4d17-4164-aaf9-ca945bdc7fd0'),
 ('Manage HL7 Templates','Ability to Add HL7 templates','a2df4321-5fd6-47bc-85e3-341ab056d1ac'),
 ('Manage Identifier Sources','Allows user add, edit, and remove identifier sources','7e28df71-de91-40e6-81be-9deb7436a5fd'),
 ('Manage Identifier Types','Able to add/edit/delete patient identifier types','019bb2b7-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Implementation Id','Able to view/add/edit the implementation id for the system','2612dcb9-7f0f-4255-8b84-b806bbbf0ca2'),
 ('Manage Indicator Definitions','Add/Edit/Remove Indicator Definitions','082df942-4ec1-4c9f-ad49-0e77849cb3e1'),
 ('Manage Location Attribute Types','Able to add/edit/retire location attribute types','9a73f876-6b75-4c35-99e8-653d48f59377'),
 ('Manage Location Tags','Able to add/edit/delete location tags','75babe1e-54c8-4c5a-991b-656cd6d199b2'),
 ('Manage Locations','Able to add/edit/delete locations','019bb66d-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Locations/Sponsors','Able to add/edit/delete location/sponsors','6ac17ebe-cf26-495c-b32d-c7ef2ecd2803'),
 ('Manage Modules','Able to add/remove modules to the system','019bba24-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage MOH-TRAC Portal Configurations','Allows user to edit MoH-TRAC Portal configurations','9123c08f-ba09-4a84-a1ee-ef6f21484da8'),
 ('Manage Order Types','Able to add/edit/retire order types','019bbe10-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Person Attribute Types','Able to add/edit/delete person attribute types','019bc20e-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Privileges','Able to add/edit/delete privileges','019bc5e8-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Programs','Able to add/view/delete patient programs','019bc9e6-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Providers','Able to edit Provider','5e6f0108-c505-4dac-aa37-c17f9eb8015a'),
 ('Manage Relationship Types','Able to add/edit/retire relationship types','019bcddb-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Relationships','Able to add/edit/delete relationships','019bd201-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Report Definitions','Add/Edit/Remove Report Definitions','2a651070-39ce-4705-a558-ef105249c2bc'),
 ('Manage Report Designs','Add/Edit/Remove Report Designs','c89a90a0-2937-41d6-86f3-d13e5d4ac069'),
 ('Manage Reports','Base privilege for add/edit/delete reporting definitions. This gives access to the administrative menus, but you need to grant additional privileges to manage each specific type of reporting definition','5de7cc70-69b0-44fb-80c1-bdbb218aaa66'),
 ('Manage Roles','Able to add/edit/delete user roles','019bd5e8-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Rule Definitions','Allows creation and editing of user-defined rules','56138e30-077f-4a4e-ae9c-249bc4c9e068'),
 ('Manage Scheduled Report Tasks','Manage Task Scheduling in Reporting Module','03927c44-ca9e-4679-9bae-306ca7cfae5e'),
 ('Manage Scheduler','Able to add/edit/remove scheduled tasks','019bdb4b-4598-11e3-9d2c-f9d02340d97d'),
 ('Manage Services and Providers','Manage Services and Providers','713937c5-91ff-461d-ab2c-6dda306eef37'),
 ('Manage Sponsors','Able to add/edit/delete sponsors','fff87f37-9cf7-4187-b5fe-7f8a444dd45c'),
 ('Manage Tokens','Allows registering and removal of tokens','f78ca5d2-562a-47a0-9297-a1a45ce30bde'),
 ('Manage Usage Statistics','Able to manage and configure usage statistics','3f338ee9-cd36-4dbf-85f1-27e955f3e187'),
 ('Manage Visit Attribute Types','Able to add/edit/retire visit attribute types','cffe80a9-2a1b-4cba-884f-8da88f0572ed'),
 ('Manage Visit Types','Able to add/edit/delete visit types','bbd2904f-f695-4642-a6b9-42af5220f111'),
 ('Patient Dashboard - View Appointments Section','Able to view the \'Appointments\' tab on the patient dashboard','d2092484-2cbf-46b0-8466-1f83c1e2f1f7'),
 ('Patient Dashboard - View Demographics Section','Able to view the \'Demographics\' tab on the patient dashboard','019bdf4d-4598-11e3-9d2c-f9d02340d97d'),
 ('Patient Dashboard - View Encounters Section','Able to view the \'Encounters\' tab on the patient dashboard','019be2e0-4598-11e3-9d2c-f9d02340d97d'),
 ('Patient Dashboard - View Forms Section','Allows user to view the Forms tab on the patient dashboard','019be680-4598-11e3-9d2c-f9d02340d97d'),
 ('Patient Dashboard - View Graphs Section','Able to view the \'Graphs\' tab on the patient dashboard','019bea3b-4598-11e3-9d2c-f9d02340d97d'),
 ('Patient Dashboard - View Overview Section','Able to view the \'Overview\' tab on the patient dashboard','019bedff-4598-11e3-9d2c-f9d02340d97d'),
 ('Patient Dashboard - View Patient Summary','Able to view the \'Summary\' tab on the patient dashboard','019bf1ad-4598-11e3-9d2c-f9d02340d97d'),
 ('Patient Dashboard - View Regimen Section','Able to view the \'Regimen\' tab on the patient dashboard','019bf53b-4598-11e3-9d2c-f9d02340d97d'),
 ('Patient Dashboard - View Visits Section','Able to view the \'Visits\' tab on the patient dashboard','0e3f49a5-a234-4ab7-8a88-3d689637e6d7'),
 ('Purge Field Types','Able to purge field types','019bf8f6-4598-11e3-9d2c-f9d02340d97d'),
 ('Remove Allergies','Remove allergies','59515cbd-d4c0-40a5-8bff-598a05dc8303'),
 ('Remove Problems','Remove problems','78058a3c-806d-4501-a7b5-6bc4887677ee'),
 ('Run Groovy Scripts','Allows user to execute Groovy scripts.','5035851b-935e-4db3-aeec-5d4d6f5c6980'),
 ('Search Appointments','Able to search/find an appointment','b7d8fe35-cdf6-40e9-b154-1a6c49cb0129'),
 ('Test Flags','Allows the user to test a flag, or set of flags, against a Patient set','d64652b1-0f9f-4869-ad9a-b239c03c364d'),
 ('Update HL7 Inbound Archive','Able to update an HL7 archive item','94860425-621c-418e-96d5-b2ce5b1960a2'),
 ('Update HL7 Inbound Exception','Able to update an HL7 archive item','164d529b-1888-46c7-99b0-cf0aba735f5f'),
 ('Update HL7 Inbound Queue','Able to update an HL7 Queue item','9b5aa5d5-8b9d-40f5-9c2a-2433bacb4030'),
 ('Update HL7 Source','Able to update an HL7 Source','87d77450-56e0-4b54-a4f8-452b6b1d5ab1'),
 ('Upload Batch of Identifiers','Allows user to upload a batch of identifiers','6c3ff519-41d8-457e-9e05-5fcf69a4d725'),
 ('Upload XSN','Allows user to upload/overwrite the XSNs defined for forms','019bfc84-4598-11e3-9d2c-f9d02340d97d'),
 ('View Administration Functions','Able to view the \'Administration\' link in the navigation bar','019c0017-4598-11e3-9d2c-f9d02340d97d'),
 ('View Allergies','Able to view allergies in OpenMRS','019c03c9-4598-11e3-9d2c-f9d02340d97d'),
 ('View Appointments','Able to view appointments','e6f0aaad-61a8-4619-9e03-0a6233fcd044'),
 ('View Concept Classes','Able to view concept classes','019c1e7d-4598-11e3-9d2c-f9d02340d97d'),
 ('View Concept Datatypes','Able to view concept datatypes','019c21ec-4598-11e3-9d2c-f9d02340d97d'),
 ('View Concept Map Types','Able to view concept map types','9133e876-b5f4-4671-9c1f-180d9f6c22fa'),
 ('View Concept Proposals','Able to view concept proposals to the system','019c2525-4598-11e3-9d2c-f9d02340d97d'),
 ('View Concept Reference Terms','Able to view concept reference terms','6a52619e-c42e-42e0-938b-92a5dc867809'),
 ('View Concept Sources','Able to view concept sources','019c29d6-4598-11e3-9d2c-f9d02340d97d'),
 ('View Concepts','Able to view concept entries','019c2d40-4598-11e3-9d2c-f9d02340d97d'),
 ('View Data Entry Statistics','Able to view data entry statistics from the admin screen','019c30ab-4598-11e3-9d2c-f9d02340d97d'),
 ('View Database Changes','Able to view database changes from the admin screen','433d03c1-cadc-413b-b8a3-0267c6f416a7'),
 ('View Encounter Roles','Able to view encounter roles','10d18fa6-2266-4ced-b606-57fe7f42ee8d'),
 ('View Encounter Types','Able to view encounter types','019c3435-4598-11e3-9d2c-f9d02340d97d'),
 ('View Encounters','Able to view patient encounters','019c37bf-4598-11e3-9d2c-f9d02340d97d'),
 ('View Field Types','Able to view field types','019c3b40-4598-11e3-9d2c-f9d02340d97d'),
 ('View Forms','Able to view forms','019c3ebc-4598-11e3-9d2c-f9d02340d97d'),
 ('View Global Properties','Able to view global properties on the administration screen','019c424f-4598-11e3-9d2c-f9d02340d97d'),
 ('View HL7 Inbound Archive','Able to view an HL7 archive item','e67efeea-e79d-4921-8ddc-ac752ebd81b0'),
 ('View HL7 Inbound Exception','Able to view an HL7 archive item','cb081bb2-77f2-4c5d-a323-80188c50cdf0'),
 ('View HL7 Inbound Queue','Able to view an HL7 Queue item','d625b269-7bec-403c-8ab2-4e2b66b9b56b'),
 ('View HL7 Source','Able to view an HL7 Source','1b1df17d-6ae5-45b4-a214-04793426891f'),
 ('View Identifier Types','Able to view patient identifier types','019c4617-4598-11e3-9d2c-f9d02340d97d'),
 ('View lab results','Able to view patients lab results','7b1b596b-45c9-4b1c-a05d-fbf9895befc5'),
 ('View Location Attribute Types','Able to view location attribute types','0e130509-ef68-486a-9a35-9d3692c0a964'),
 ('View Locations','Able to view locations','019c4a6e-4598-11e3-9d2c-f9d02340d97d'),
 ('View MOH-TRAC Portal','Allows user to access MOH-TRAC Activities page','9b4291af-3d55-4336-bdea-b1d7fe9fd8d8'),
 ('View Navigation Menu','Ability to see the navigation menu','019c4e5f-4598-11e3-9d2c-f9d02340d97d'),
 ('View Observations','Able to view patient observations','019c5277-4598-11e3-9d2c-f9d02340d97d'),
 ('View Order Types','Able to view order types','019c562e-4598-11e3-9d2c-f9d02340d97d'),
 ('View Orders','Able to view orders','019c59d7-4598-11e3-9d2c-f9d02340d97d'),
 ('View Patient Cohorts','Able to view patient cohorts','019c5d9b-4598-11e3-9d2c-f9d02340d97d'),
 ('View Patient Identifiers','Able to view patient identifiers','019c6120-4598-11e3-9d2c-f9d02340d97d'),
 ('View Patient Names','Able to view patient names','ac14c92a-0d46-4c62-b944-4ae6b8e99551'),
 ('View Patient Programs','Able to see which programs that patients are in','019c64e8-4598-11e3-9d2c-f9d02340d97d'),
 ('View Patients','Able to view patients','019c6860-4598-11e3-9d2c-f9d02340d97d'),
 ('View People','Able to view person objects','019c6c31-4598-11e3-9d2c-f9d02340d97d'),
 ('View Person Attribute Types','Able to view person attribute types','019c6fd2-4598-11e3-9d2c-f9d02340d97d'),
 ('View Privileges','Able to view user privileges','019c7364-4598-11e3-9d2c-f9d02340d97d'),
 ('View Problems','Able to view problems in OpenMRS','019c79e0-4598-11e3-9d2c-f9d02340d97d'),
 ('View Programs','Able to view patient programs','019c7d89-4598-11e3-9d2c-f9d02340d97d'),
 ('View Provider Appointments','Able to view appointments by provider','01292817-1f2a-4cc9-b0ec-419bb80ee816'),
 ('View Providers','Able to view Provider','52452917-2050-47f6-99a8-077205e83b5d'),
 ('View Regimens','Able to view list of regimens','93a82111-87e0-4dca-80e8-6bc37c315500'),
 ('View Relationship Types','Able to view relationship types','019c80be-4598-11e3-9d2c-f9d02340d97d'),
 ('View Relationships','Able to view relationships','019c8456-4598-11e3-9d2c-f9d02340d97d'),
 ('View Report Objects','Able to view report objects','019c87f1-4598-11e3-9d2c-f9d02340d97d'),
 ('View Reports','Able to view reports','019c8bba-4598-11e3-9d2c-f9d02340d97d'),
 ('View Roles','Able to view user roles','019c8f70-4598-11e3-9d2c-f9d02340d97d'),
 ('View Rule Definitions','Allows viewing of user-defined rules. (This privilege is not necessary to run rules under normal usage.)','8b2c2487-693e-4345-a8a3-cbae654ab4c2'),
 ('View TRAC Portal Administration Page','Allows user to access TRAC Portal Administration\n			page','f6b7c248-8d8c-4f16-af6c-6941f6ce4258'),
 ('View TRAC Portal modules functionalities','Allows user to access TRAC modules functionalities\n			page','7024ce9c-7be1-4650-bad8-083a2bbc62aa'),
 ('View TRAC Portal patients listing and export','Allows user to access TRAC patient listing and export','2584375c-74d8-42f9-a70c-af86cd59f3cf'),
 ('View TRAC Portal Users performance','Allows user to view all users performance','eb483d55-7f9c-4fdc-9c99-0f8e79353f3d'),
 ('View Unpublished Forms','Able to view and fill out unpublished forms','019c9315-4598-11e3-9d2c-f9d02340d97d'),
 ('View Usage Statistics','Able to view usage statistics','6ebaa47e-6ff2-4314-aea8-136881da847b'),
 ('View Users','Able to view users in OpenMRS','019c9688-4598-11e3-9d2c-f9d02340d97d'),
 ('View Visit Attribute Types','Able to view visit attribute types','3c101903-2663-406c-9ec3-54b12842a316'),
 ('View Visit Types','Able to view visit types','11fcafae-ef38-4c3c-afa9-e9c9499d0331'),
 ('View Visits','Able to view visits','f194c8bb-ea1c-4b99-8974-32b517d011e0');
/*!40000 ALTER TABLE `privilege` ENABLE KEYS */;


--
-- Definition of table `processingqueue`
--

DROP TABLE IF EXISTS `processingqueue`;
CREATE TABLE `processingqueue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `method` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `processingqueue`
--

/*!40000 ALTER TABLE `processingqueue` DISABLE KEYS */;
INSERT INTO `processingqueue` (`id`,`method`) VALUES 
 (2,'POST'),
 (3,'POST'),
 (4,'POST');
/*!40000 ALTER TABLE `processingqueue` ENABLE KEYS */;


--
-- Definition of table `program`
--

DROP TABLE IF EXISTS `program`;
CREATE TABLE `program` (
  `program_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `outcomes_concept_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`program_id`),
  UNIQUE KEY `program_uuid_index` (`uuid`),
  KEY `user_who_changed_program` (`changed_by`),
  KEY `program_concept` (`concept_id`),
  KEY `program_creator` (`creator`),
  KEY `program_outcomes_concept_id_fk` (`outcomes_concept_id`),
  CONSTRAINT `program_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `program_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `program_outcomes_concept_id_fk` FOREIGN KEY (`outcomes_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_changed_program` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `program`
--

/*!40000 ALTER TABLE `program` DISABLE KEYS */;
/*!40000 ALTER TABLE `program` ENABLE KEYS */;


--
-- Definition of table `program_workflow`
--

DROP TABLE IF EXISTS `program_workflow`;
CREATE TABLE `program_workflow` (
  `program_workflow_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`program_workflow_id`),
  UNIQUE KEY `program_workflow_uuid_index` (`uuid`),
  KEY `workflow_changed_by` (`changed_by`),
  KEY `workflow_concept` (`concept_id`),
  KEY `workflow_creator` (`creator`),
  KEY `program_for_workflow` (`program_id`),
  CONSTRAINT `program_for_workflow` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  CONSTRAINT `workflow_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `workflow_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `workflow_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `program_workflow`
--

/*!40000 ALTER TABLE `program_workflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_workflow` ENABLE KEYS */;


--
-- Definition of table `program_workflow_state`
--

DROP TABLE IF EXISTS `program_workflow_state`;
CREATE TABLE `program_workflow_state` (
  `program_workflow_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_workflow_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `initial` tinyint(1) NOT NULL DEFAULT '0',
  `terminal` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`program_workflow_state_id`),
  UNIQUE KEY `program_workflow_state_uuid_index` (`uuid`),
  KEY `state_changed_by` (`changed_by`),
  KEY `state_concept` (`concept_id`),
  KEY `state_creator` (`creator`),
  KEY `workflow_for_state` (`program_workflow_id`),
  CONSTRAINT `state_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `state_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `state_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `workflow_for_state` FOREIGN KEY (`program_workflow_id`) REFERENCES `program_workflow` (`program_workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `program_workflow_state`
--

/*!40000 ALTER TABLE `program_workflow_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_workflow_state` ENABLE KEYS */;


--
-- Definition of table `provider`
--

DROP TABLE IF EXISTS `provider`;
CREATE TABLE `provider` (
  `provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`provider_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_changed_by_fk` (`changed_by`),
  KEY `provider_person_id_fk` (`person_id`),
  KEY `provider_retired_by_fk` (`retired_by`),
  KEY `provider_creator_fk` (`creator`),
  CONSTRAINT `provider_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_person_id_fk` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `provider_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `provider`
--

/*!40000 ALTER TABLE `provider` DISABLE KEYS */;
INSERT INTO `provider` (`provider_id`,`person_id`,`name`,`identifier`,`creator`,`date_created`,`changed_by`,`date_changed`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (1,18,NULL,'e8597a14-436f-1031-8b61-8d373bf4f88f',1,'2013-11-05 14:08:59',NULL,NULL,0,NULL,NULL,NULL,'83db7d6d-2d33-4bbc-a677-9dbfe53634df');
/*!40000 ALTER TABLE `provider` ENABLE KEYS */;


--
-- Definition of table `provider_attribute`
--

DROP TABLE IF EXISTS `provider_attribute`;
CREATE TABLE `provider_attribute` (
  `provider_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`provider_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_attribute_provider_fk` (`provider_id`),
  KEY `provider_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `provider_attribute_creator_fk` (`creator`),
  KEY `provider_attribute_changed_by_fk` (`changed_by`),
  KEY `provider_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `provider_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `provider_attribute_type` (`provider_attribute_type_id`),
  CONSTRAINT `provider_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_attribute_provider_fk` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`),
  CONSTRAINT `provider_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `provider_attribute`
--

/*!40000 ALTER TABLE `provider_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_attribute` ENABLE KEYS */;


--
-- Definition of table `provider_attribute_type`
--

DROP TABLE IF EXISTS `provider_attribute_type`;
CREATE TABLE `provider_attribute_type` (
  `provider_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`provider_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_attribute_type_creator_fk` (`creator`),
  KEY `provider_attribute_type_changed_by_fk` (`changed_by`),
  KEY `provider_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `provider_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `provider_attribute_type`
--

/*!40000 ALTER TABLE `provider_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_attribute_type` ENABLE KEYS */;


--
-- Definition of table `regenstriefhl7adapter_facility`
--

DROP TABLE IF EXISTS `regenstriefhl7adapter_facility`;
CREATE TABLE `regenstriefhl7adapter_facility` (
  `facility_id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(50) DEFAULT NULL,
  `fac` varchar(50) DEFAULT NULL,
  `pv139` varchar(50) DEFAULT NULL,
  `pv132` varchar(50) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`facility_id`),
  KEY `matching_id` (`location_id`),
  CONSTRAINT `location_matching_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `regenstriefhl7adapter_facility`
--

/*!40000 ALTER TABLE `regenstriefhl7adapter_facility` DISABLE KEYS */;
/*!40000 ALTER TABLE `regenstriefhl7adapter_facility` ENABLE KEYS */;


--
-- Definition of table `regenstriefhl7adapter_hl7_message_model`
--

DROP TABLE IF EXISTS `regenstriefhl7adapter_hl7_message_model`;
CREATE TABLE `regenstriefhl7adapter_hl7_message_model` (
  `hl7_message_model_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_message` longtext,
  `is_pipe_delimited` tinyint(1) NOT NULL DEFAULT '0',
  `message_type` int(11) NOT NULL,
  `message_sender` int(11) NOT NULL,
  `date_received` longtext,
  PRIMARY KEY (`hl7_message_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `regenstriefhl7adapter_hl7_message_model`
--

/*!40000 ALTER TABLE `regenstriefhl7adapter_hl7_message_model` DISABLE KEYS */;
/*!40000 ALTER TABLE `regenstriefhl7adapter_hl7_message_model` ENABLE KEYS */;


--
-- Definition of table `regimencategory`
--

DROP TABLE IF EXISTS `regimencategory`;
CREATE TABLE `regimencategory` (
  `regimen_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `regimen_category_name` varchar(55) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `voided` tinyint(4) DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` date DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`regimen_category_id`),
  KEY `creator` (`creator`),
  KEY `voided_by` (`voided_by`),
  CONSTRAINT `regimencategory_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `regimencategory_ibfk_2` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `regimencategory`
--

/*!40000 ALTER TABLE `regimencategory` DISABLE KEYS */;
INSERT INTO `regimencategory` (`regimen_category_id`,`regimen_category_name`,`description`,`creator`,`date_created`,`voided`,`voided_by`,`date_voided`,`void_reason`) VALUES 
 (1,'adultRegimen',NULL,1,NULL,0,NULL,NULL,NULL),
 (2,'pediatricRegimen',NULL,1,NULL,0,NULL,NULL,NULL),
 (3,'pediatricRegimenSecondLine',NULL,1,NULL,0,NULL,NULL,NULL),
 (4,'adultRegimensSecondLine',NULL,1,NULL,0,NULL,NULL,NULL),
 (5,'prophylaxiePostExpositions',NULL,1,NULL,0,NULL,NULL,NULL),
 (6,'pmtctCompositions',NULL,1,NULL,0,NULL,NULL,NULL),
 (7,'PediatricSirop',NULL,1,NULL,0,NULL,NULL,NULL),
 (8,'adultRegimensThirdLine',NULL,1,NULL,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `regimencategory` ENABLE KEYS */;


--
-- Definition of table `regimencomposition`
--

DROP TABLE IF EXISTS `regimencomposition`;
CREATE TABLE `regimencomposition` (
  `regimen_id` int(11) NOT NULL AUTO_INCREMENT,
  `regimen_category` varchar(45) DEFAULT NULL,
  `regimen_name` varchar(45) DEFAULT NULL,
  `drug_concept_id1` int(11) DEFAULT NULL,
  `drug_concept_id2` int(11) DEFAULT NULL,
  `drug_concept_id3` int(11) DEFAULT NULL,
  `drug_concept_id4` int(11) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `voided` tinyint(4) DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` date DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`regimen_id`),
  KEY `creator` (`creator`),
  KEY `voided_by` (`voided_by`),
  CONSTRAINT `regimencomposition_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `regimencomposition_ibfk_2` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `regimencomposition`
--

/*!40000 ALTER TABLE `regimencomposition` DISABLE KEYS */;
/*!40000 ALTER TABLE `regimencomposition` ENABLE KEYS */;


--
-- Definition of table `relationship`
--

DROP TABLE IF EXISTS `relationship`;
CREATE TABLE `relationship` (
  `relationship_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_a` int(11) NOT NULL,
  `relationship` int(11) NOT NULL DEFAULT '0',
  `person_b` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`relationship_id`),
  UNIQUE KEY `relationship_uuid_index` (`uuid`),
  KEY `relation_creator` (`creator`),
  KEY `person_a_is_person` (`person_a`),
  KEY `person_b_is_person` (`person_b`),
  KEY `relationship_type_id` (`relationship`),
  KEY `relation_voider` (`voided_by`),
  KEY `relationship_changed_by` (`changed_by`),
  CONSTRAINT `person_a_is_person` FOREIGN KEY (`person_a`) REFERENCES `person` (`person_id`),
  CONSTRAINT `person_b_is_person` FOREIGN KEY (`person_b`) REFERENCES `person` (`person_id`),
  CONSTRAINT `relationship_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `relationship_type_id` FOREIGN KEY (`relationship`) REFERENCES `relationship_type` (`relationship_type_id`),
  CONSTRAINT `relation_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `relation_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `relationship`
--

/*!40000 ALTER TABLE `relationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `relationship` ENABLE KEYS */;


--
-- Definition of table `relationship_type`
--

DROP TABLE IF EXISTS `relationship_type`;
CREATE TABLE `relationship_type` (
  `relationship_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `a_is_to_b` varchar(50) NOT NULL,
  `b_is_to_a` varchar(50) NOT NULL,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `weight` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`relationship_type_id`),
  UNIQUE KEY `relationship_type_uuid_index` (`uuid`),
  KEY `user_who_created_rel` (`creator`),
  KEY `user_who_retired_relationship_type` (`retired_by`),
  CONSTRAINT `user_who_created_rel` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_relationship_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `relationship_type`
--

/*!40000 ALTER TABLE `relationship_type` DISABLE KEYS */;
INSERT INTO `relationship_type` (`relationship_type_id`,`a_is_to_b`,`b_is_to_a`,`preferred`,`weight`,`description`,`creator`,`date_created`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (1,'Doctor','Patient',0,0,'Relationship from a primary care provider to the patient',1,'2007-05-04 00:00:00',0,NULL,NULL,NULL,'8d919b58-c2cc-11de-8d13-0010c6dffd0f'),
 (2,'Sibling','Sibling',0,0,'Relationship between brother/sister, brother/brother, and sister/sister',1,'2007-05-04 00:00:00',0,NULL,NULL,NULL,'8d91a01c-c2cc-11de-8d13-0010c6dffd0f'),
 (3,'Parent','Child',0,0,'Relationship from a mother/father to the child',1,'2007-05-04 00:00:00',0,NULL,NULL,NULL,'8d91a210-c2cc-11de-8d13-0010c6dffd0f'),
 (4,'Aunt/Uncle','Niece/Nephew',0,0,'Relationship from a parent\'s sibling to a child of that parent',1,'2007-05-04 00:00:00',0,NULL,NULL,NULL,'8d91a3dc-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `relationship_type` ENABLE KEYS */;


--
-- Definition of table `report_object`
--

DROP TABLE IF EXISTS `report_object`;
CREATE TABLE `report_object` (
  `report_object_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `report_object_type` varchar(255) NOT NULL,
  `report_object_sub_type` varchar(255) NOT NULL,
  `xml_data` text,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`report_object_id`),
  UNIQUE KEY `report_object_uuid_index` (`uuid`),
  KEY `user_who_changed_report_object` (`changed_by`),
  KEY `report_object_creator` (`creator`),
  KEY `user_who_voided_report_object` (`voided_by`),
  CONSTRAINT `report_object_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_report_object` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_report_object` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `report_object`
--

/*!40000 ALTER TABLE `report_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_object` ENABLE KEYS */;


--
-- Definition of table `report_schema_xml`
--

DROP TABLE IF EXISTS `report_schema_xml`;
CREATE TABLE `report_schema_xml` (
  `report_schema_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `xml_data` text NOT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`report_schema_id`),
  UNIQUE KEY `report_schema_xml_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `report_schema_xml`
--

/*!40000 ALTER TABLE `report_schema_xml` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_schema_xml` ENABLE KEYS */;


--
-- Definition of table `reporting_report_design`
--

DROP TABLE IF EXISTS `reporting_report_design`;
CREATE TABLE `reporting_report_design` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `report_definition_id` int(11) NOT NULL DEFAULT '0',
  `renderer_type` varchar(255) NOT NULL,
  `properties` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `report_definition_id for reporting_report_design` (`report_definition_id`),
  KEY `creator for reporting_report_design` (`creator`),
  KEY `changed_by for reporting_report_design` (`changed_by`),
  KEY `retired_by for reporting_report_design` (`retired_by`),
  CONSTRAINT `changed_by for reporting_report_design` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `creator for reporting_report_design` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `report_definition_id for reporting_report_design` FOREIGN KEY (`report_definition_id`) REFERENCES `serialized_object` (`serialized_object_id`),
  CONSTRAINT `retired_by for reporting_report_design` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reporting_report_design`
--

/*!40000 ALTER TABLE `reporting_report_design` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporting_report_design` ENABLE KEYS */;


--
-- Definition of table `reporting_report_design_resource`
--

DROP TABLE IF EXISTS `reporting_report_design_resource`;
CREATE TABLE `reporting_report_design_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `report_design_id` int(11) NOT NULL DEFAULT '0',
  `content_type` varchar(50) DEFAULT NULL,
  `extension` varchar(20) DEFAULT NULL,
  `contents` longblob,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `report_design_id for reporting_report_design_resource` (`report_design_id`),
  KEY `creator for reporting_report_design_resource` (`creator`),
  KEY `changed_by for reporting_report_design_resource` (`changed_by`),
  KEY `retired_by for reporting_report_design_resource` (`retired_by`),
  CONSTRAINT `changed_by for reporting_report_design_resource` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `creator for reporting_report_design_resource` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `report_design_id for reporting_report_design_resource` FOREIGN KEY (`report_design_id`) REFERENCES `reporting_report_design` (`id`),
  CONSTRAINT `retired_by for reporting_report_design_resource` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reporting_report_design_resource`
--

/*!40000 ALTER TABLE `reporting_report_design_resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporting_report_design_resource` ENABLE KEYS */;


--
-- Definition of table `reporting_report_processor`
--

DROP TABLE IF EXISTS `reporting_report_processor`;
CREATE TABLE `reporting_report_processor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `processor_type` varchar(255) NOT NULL,
  `configuration` mediumtext,
  `run_on_success` tinyint(1) NOT NULL DEFAULT '1',
  `run_on_error` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `report_design_id` int(11) DEFAULT NULL,
  `processor_mode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator for reporting_report_processor` (`creator`),
  KEY `changed_by for reporting_report_processor` (`changed_by`),
  KEY `retired_by for reporting_report_processor` (`retired_by`),
  KEY `reporting_report_processor_report_design` (`report_design_id`),
  CONSTRAINT `changed_by for reporting_report_processor` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `creator for reporting_report_processor` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `reporting_report_processor_report_design` FOREIGN KEY (`report_design_id`) REFERENCES `reporting_report_design` (`id`),
  CONSTRAINT `retired_by for reporting_report_processor` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reporting_report_processor`
--

/*!40000 ALTER TABLE `reporting_report_processor` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporting_report_processor` ENABLE KEYS */;


--
-- Definition of table `reporting_report_request`
--

DROP TABLE IF EXISTS `reporting_report_request`;
CREATE TABLE `reporting_report_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `base_cohort_uuid` char(38) DEFAULT NULL,
  `base_cohort_parameters` text,
  `report_definition_uuid` char(38) NOT NULL,
  `report_definition_parameters` text,
  `renderer_type` varchar(255) NOT NULL,
  `renderer_argument` varchar(255) DEFAULT NULL,
  `requested_by` int(11) NOT NULL DEFAULT '0',
  `request_datetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `priority` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `evaluation_start_datetime` datetime DEFAULT NULL,
  `evaluation_complete_datetime` datetime DEFAULT NULL,
  `render_complete_datetime` datetime DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `schedule` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `requested_by for reporting_report_request` (`requested_by`),
  CONSTRAINT `requested_by for reporting_report_request` FOREIGN KEY (`requested_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reporting_report_request`
--

/*!40000 ALTER TABLE `reporting_report_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporting_report_request` ENABLE KEYS */;


--
-- Definition of table `rheashradapter_get_encounter_log`
--

DROP TABLE IF EXISTS `rheashradapter_get_encounter_log`;
CREATE TABLE `rheashradapter_get_encounter_log` (
  `get_request_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(40) DEFAULT NULL,
  `encounter_unique_id` varchar(40) DEFAULT NULL,
  `enterprise_location_id` varchar(40) DEFAULT NULL,
  `date_start` varchar(40) DEFAULT NULL,
  `date_end` varchar(40) DEFAULT NULL,
  `log_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `result` varchar(200) DEFAULT NULL,
  `error` varchar(255) DEFAULT NULL,
  `error_details` longtext,
  PRIMARY KEY (`get_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rheashradapter_get_encounter_log`
--

/*!40000 ALTER TABLE `rheashradapter_get_encounter_log` DISABLE KEYS */;
INSERT INTO `rheashradapter_get_encounter_log` (`get_request_id`,`patient_id`,`encounter_unique_id`,`enterprise_location_id`,`date_start`,`date_end`,`log_time`,`result`,`error`,`error_details`) VALUES 
 (8,'4dbd7470-3c0d-11e3-9287-22000a9aa860',NULL,NULL,'2010-10-01 12:12:12.0','2013-12-12 12:12:12.0','2013-11-19 13:22:11','Results retrived',NULL,NULL),
 (9,'4dbd7470-3c0d-11e3-9287-22000a9aa860','f4c478ed-cfaf-4ad6-ac82-6e4280957aa1',NULL,NULL,NULL,'2013-11-19 13:26:07','Results retrived',NULL,NULL),
 (10,'4dbd7470-3c0d-11e3-9287-22000a9aa860',NULL,NULL,NULL,NULL,'2013-11-25 15:41:08','Results retrived',NULL,NULL),
 (11,'4dbd7470-3c0d-11e3-9287-22000a9aa860',NULL,NULL,'2010-10-01 12:12:12.0','2013-12-01 12:12:12.0','2013-11-25 15:41:13','Results retrived',NULL,NULL),
 (12,'4dbd7470-3c0d-11e3-9287-22000a9aa860','4de39307-3645-4f82-9801-d31eb61be325',NULL,NULL,NULL,'2013-11-25 15:41:17','No results','Error : failed to resolve patient','Failed to retrieve a unique patient with the given ID'),
 (13,'4dbd7470-3c0d-11e3-9287-22000a9aa860','4de39307-3645-4f82-9801-d31eb61be325',NULL,NULL,NULL,'2013-11-25 15:41:22','No results','Error : failed to resolve patient','Failed to retrieve a unique patient with the given ID'),
 (14,'4dbd7470-3c0d-11e3-9287-22000a9aa860',NULL,NULL,'2010-10-01 12:12:12.0','2013-12-01 12:12:12.0','2013-11-25 15:41:29','Results retrived',NULL,NULL);
/*!40000 ALTER TABLE `rheashradapter_get_encounter_log` ENABLE KEYS */;


--
-- Definition of table `rheashradapter_matching_encounters`
--

DROP TABLE IF EXISTS `rheashradapter_matching_encounters`;
CREATE TABLE `rheashradapter_matching_encounters` (
  `matching_encounters_id` int(11) NOT NULL AUTO_INCREMENT,
  `get_request_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`matching_encounters_id`),
  KEY `matching_id` (`get_request_id`),
  CONSTRAINT `matching_id` FOREIGN KEY (`get_request_id`) REFERENCES `rheashradapter_get_encounter_log` (`get_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rheashradapter_matching_encounters`
--

/*!40000 ALTER TABLE `rheashradapter_matching_encounters` DISABLE KEYS */;
INSERT INTO `rheashradapter_matching_encounters` (`matching_encounters_id`,`get_request_id`,`encounter_id`) VALUES 
 (2,8,10),
 (3,9,10),
 (4,10,10),
 (5,11,10),
 (6,14,10);
/*!40000 ALTER TABLE `rheashradapter_matching_encounters` ENABLE KEYS */;


--
-- Definition of table `rheashradapter_patient_merge_log`
--

DROP TABLE IF EXISTS `rheashradapter_patient_merge_log`;
CREATE TABLE `rheashradapter_patient_merge_log` (
  `patient_merge_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `retired_patient` varchar(40) DEFAULT NULL,
  `surviving_patient` varchar(40) DEFAULT NULL,
  `winner` int(11) NOT NULL,
  `looser` int(11) NOT NULL,
  `merged_data` longtext,
  `created_date` datetime NOT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `restored_date` datetime DEFAULT NULL,
  `restored_user_id` int(11) DEFAULT NULL,
  `flag` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`patient_merge_log_id`),
  KEY `surviving_person` (`winner`),
  KEY `retired_person` (`looser`),
  KEY `created_user_rhea` (`created_user_id`),
  KEY `retired_user_rhea` (`restored_user_id`),
  CONSTRAINT `created_user_rhea` FOREIGN KEY (`created_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `retired_person` FOREIGN KEY (`looser`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `retired_user_rhea` FOREIGN KEY (`restored_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `surviving_person` FOREIGN KEY (`winner`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rheashradapter_patient_merge_log`
--

/*!40000 ALTER TABLE `rheashradapter_patient_merge_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `rheashradapter_patient_merge_log` ENABLE KEYS */;


--
-- Definition of table `rheashradapter_post_encounter_log`
--

DROP TABLE IF EXISTS `rheashradapter_post_encounter_log`;
CREATE TABLE `rheashradapter_post_encounter_log` (
  `post_request_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(40) DEFAULT NULL,
  `hl7_data` mediumtext,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `valid` smallint(6) NOT NULL DEFAULT '0',
  `result` varchar(200) DEFAULT NULL,
  `error` longtext,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`post_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rheashradapter_post_encounter_log`
--

/*!40000 ALTER TABLE `rheashradapter_post_encounter_log` DISABLE KEYS */;
INSERT INTO `rheashradapter_post_encounter_log` (`post_request_id`,`patient_id`,`hl7_data`,`date_created`,`valid`,`result`,`error`,`user_id`) VALUES 
 (2,'4dbd7470-3c0d-11e3-9287-22000a9aa860','<?xml version=\"1.0\"?>\n<ORU_R01 xmlns=\"urn:hl7-org:v2xml\">\n    <MSH>\n        <MSH.1>|</MSH.1>\n        <MSH.2>^~\\&amp;amp;</MSH.2>\n        <MSH.4>\n            <HD.1>999</HD.1>\n        </MSH.4>\n        <MSH.6>\n            <HD.1>Shared Health Record</HD.1>\n        </MSH.6>\n        <MSH.7>\n            <TS.1>20131112203404</TS.1>\n        </MSH.7>\n        <MSH.9>\n            <MSG.1>ORU</MSG.1>\n            <MSG.2>R01</MSG.2>\n            <MSG.3>ORU_R01</MSG.3>\n        </MSH.9>\n        <MSH.10>7a7a949c-6f56-4a2b-abdd-92da47f57ed0</MSH.10>\n        <MSH.11>\n            <PT.1>D</PT.1>\n            <PT.2>C</PT.2>\n        </MSH.11>\n        <MSH.12>\n            <VID.1>2.5</VID.1>\n            <VID.2>\n                <CE.1>RWA</CE.1>\n            </VID.2>\n        </MSH.12>\n        <MSH.21>\n            <EI.1>CLSM_V0.83</EI.1>\n        </MSH.21>\n    </MSH>\n    <ORU_R01.PATIENT_RESULT>\n        <ORU_R01.PATIENT>\n            <PID>\n                <PID.3>\n                    <CX.1>4dbd7470-3c0d-11e3-9287-22000a9aa860</CX.1>\n                    <CX.5>ECID</CX.5>\n                </PID.3>\n                <PID.5>\n                    <XPN.1>\n                        <FN.1>Yates</FN.1>\n                    </XPN.1>\n                    <XPN.2>Bryan</XPN.2>\n                </PID.5>\n            </PID>\n            <ORU_R01.VISIT>\n                <PV1>\n                    <PV1.2>0</PV1.2>\n                    <PV1.3>\n                        <PL.1>103</PL.1>\n                        <PL.4>\n                            <HD.1>Rwamagana</HD.1>\n                        </PL.4>\n                    </PV1.3>\n                    <PV1.4>ANC Referral</PV1.4>\n                    <PV1.7>\n                        <XCN.1>3525410</XCN.1>\n                        <XCN.2>\n                            <FN.1>Doctor</FN.1>\n                        </XCN.2>\n                        <XCN.3>John</XCN.3>\n                        <XCN.13>EPID</XCN.13>\n                    </PV1.7>\n                    <PV1.44>\n                        <TS.1>201311120834</TS.1>\n                    </PV1.44>\n                </PV1>\n            </ORU_R01.VISIT>\n        </ORU_R01.PATIENT>\n        <ORU_R01.ORDER_OBSERVATION>\n            <ORC>\n                <ORC.1>RE</ORC.1>\n                <ORC.9>\n                    <TS.1>201311122034</TS.1>\n                </ORC.9>\n                <ORC.12>\n                    <XCN.1>3</XCN.1>\n                </ORC.12>\n                <ORC.16>\n                    <CE.1>Identifier</CE.1>\n                    <CE.2>Text</CE.2>\n                    <CE.3>Name of Coding System</CE.3>\n                </ORC.16>\n            </ORC>\n            <OBR>\n                <OBR.1>0</OBR.1>\n                <OBR.3>\n                    <EI.1>37</EI.1>\n                </OBR.3>\n                <OBR.4>\n                    <CE.2>ANC Referral</CE.2>\n                </OBR.4>\n                <OBR.7>\n                    <TS.1>201311120000</TS.1>\n                </OBR.7>\n                <OBR.20>103</OBR.20>\n                <OBR.21>Rwamagana</OBR.21>\n            </OBR>\n        </ORU_R01.ORDER_OBSERVATION>\n        <ORU_R01.ORDER_OBSERVATION>\n            <OBR>\n                <OBR.1>1</OBR.1>\n                <OBR.18>0</OBR.18>\n                <OBR.29>\n                    <EIP.2>\n                        <EI.3>37</EI.3>\n                    </EIP.2>\n                </OBR.29>\n            </OBR>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>0</OBX.1>\n                    <OBX.2>ST</OBX.2>\n                    <OBX.3>\n                        <CE.1>57133-1</CE.1>\n                        <CE.2>Refer patient to</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>Healthcare unit/clinic</OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>1</OBX.1>\n                    <OBX.2>CE</OBX.2>\n                    <OBX.3>\n                        <CE.1>8517</CE.1>\n                        <CE.2>Referral Urgency</CE.2>\n                        <CE.3>RWCS</CE.3>\n                    </OBX.3>\n                    <OBX.5>\n                        <CE.1>8512</CE.1>\n                        <CE.2>Immediate Referral</CE.2>\n                        <CE.3>RWCS</CE.3>\n                    </OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>2</OBX.1>\n                    <OBX.2>ST</OBX.2>\n                    <OBX.3>\n                        <CE.1>42349-1</CE.1>\n                        <CE.2>REASON FOR REFERRAL TO ANOTHER SITE</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>Reason</OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112203404</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n            <ORU_R01.OBSERVATION>\n                <OBX>\n                    <OBX.1>3</OBX.1>\n                    <OBX.2>TS</OBX.2>\n                    <OBX.3>\n                        <CE.1>57202-4</CE.1>\n                        <CE.2>DATE OF REFERRAL REQUEST</CE.2>\n                        <CE.3>LOINC</CE.3>\n                    </OBX.3>\n                    <OBX.5>\n                        <TS.1>20131029000000</TS.1>\n                    </OBX.5>\n                    <OBX.14>\n                        <TS.1>20131112</TS.1>\n                    </OBX.14>\n                </OBX>\n            </ORU_R01.OBSERVATION>\n        </ORU_R01.ORDER_OBSERVATION>\n    </ORU_R01.PATIENT_RESULT>\n</ORU_R01>','2013-11-19 13:15:23',1,'201',NULL,1);
/*!40000 ALTER TABLE `rheashradapter_post_encounter_log` ENABLE KEYS */;


--
-- Definition of table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`role`),
  UNIQUE KEY `role_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role`
--

/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` (`role`,`description`,`uuid`) VALUES 
 ('Anonymous','Privileges for non-authenticated users.','774b2af3-6437-4e5a-a310-547554c7c65c'),
 ('Authenticated','Privileges gained once authentication has been established.','f7fd42ef-880e-40c5-972d-e4ae7c990de2'),
 ('Provider','All users with the \'Provider\' role will appear as options in the default Infopath','8d94f280-c2cc-11de-8d13-0010c6dffd0f'),
 ('System Developer','Developers of the OpenMRS .. have additional access to change fundamental structure of the database model.','8d94f852-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;


--
-- Definition of table `role_privilege`
--

DROP TABLE IF EXISTS `role_privilege`;
CREATE TABLE `role_privilege` (
  `role` varchar(50) NOT NULL DEFAULT '',
  `privilege` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`privilege`,`role`),
  KEY `role_privilege_to_role` (`role`),
  CONSTRAINT `privilege_definitons` FOREIGN KEY (`privilege`) REFERENCES `privilege` (`privilege`),
  CONSTRAINT `role_privilege_to_role` FOREIGN KEY (`role`) REFERENCES `role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role_privilege`
--

/*!40000 ALTER TABLE `role_privilege` DISABLE KEYS */;
INSERT INTO `role_privilege` (`role`,`privilege`) VALUES 
 ('Authenticated','View Concept Classes'),
 ('Authenticated','View Concept Datatypes'),
 ('Authenticated','View Encounter Types'),
 ('Authenticated','View Field Types'),
 ('Authenticated','View Global Properties'),
 ('Authenticated','View Identifier Types'),
 ('Authenticated','View Locations'),
 ('Authenticated','View Order Types'),
 ('Authenticated','View Person Attribute Types'),
 ('Authenticated','View Privileges'),
 ('Authenticated','View Relationship Types'),
 ('Authenticated','View Relationships'),
 ('Authenticated','View Roles');
/*!40000 ALTER TABLE `role_privilege` ENABLE KEYS */;


--
-- Definition of table `role_role`
--

DROP TABLE IF EXISTS `role_role`;
CREATE TABLE `role_role` (
  `parent_role` varchar(50) NOT NULL DEFAULT '',
  `child_role` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`parent_role`,`child_role`),
  KEY `inherited_role` (`child_role`),
  CONSTRAINT `inherited_role` FOREIGN KEY (`child_role`) REFERENCES `role` (`role`),
  CONSTRAINT `parent_role` FOREIGN KEY (`parent_role`) REFERENCES `role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role_role`
--

/*!40000 ALTER TABLE `role_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_role` ENABLE KEYS */;


--
-- Definition of table `scheduler_task_config`
--

DROP TABLE IF EXISTS `scheduler_task_config`;
CREATE TABLE `scheduler_task_config` (
  `task_config_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `schedulable_class` text,
  `start_time` datetime DEFAULT NULL,
  `start_time_pattern` varchar(50) DEFAULT NULL,
  `repeat_interval` int(11) NOT NULL DEFAULT '0',
  `start_on_startup` tinyint(1) NOT NULL DEFAULT '0',
  `started` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(11) DEFAULT '0',
  `date_created` datetime DEFAULT '2005-01-01 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `last_execution_time` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`task_config_id`),
  UNIQUE KEY `scheduler_task_config_uuid_index` (`uuid`),
  KEY `scheduler_changer` (`changed_by`),
  KEY `scheduler_creator` (`created_by`),
  CONSTRAINT `scheduler_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `scheduler_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `scheduler_task_config`
--

/*!40000 ALTER TABLE `scheduler_task_config` DISABLE KEYS */;
INSERT INTO `scheduler_task_config` (`task_config_id`,`name`,`description`,`schedulable_class`,`start_time`,`start_time_pattern`,`repeat_interval`,`start_on_startup`,`started`,`created_by`,`date_created`,`changed_by`,`date_changed`,`last_execution_time`,`uuid`) VALUES 
 (1,'Update Concept Index','Iterates through the concept dictionary, re-creating the concept index (which are used for searcing). This task is started when using the \'Update Concept Index Storage\' page and no range is given.  This task stops itself when one iteration has completed.','org.openmrs.scheduler.tasks.ConceptIndexUpdateTask',NULL,NULL,0,0,0,1,'2005-01-01 00:00:00',2,'2013-11-04 16:33:32',NULL,'7c75911e-0310-11e0-8222-18a905e044dc'),
 (2,'Auto Close Visits Task','Stops all active visits that match the visit type(s) specified by the value of the global property \'visits.autoCloseVisitType\'','org.openmrs.scheduler.tasks.AutoCloseVisitsTask','2011-11-28 23:59:59','MM/dd/yyyy HH:mm:ss',86400,0,0,1,'2013-11-04 16:32:22',NULL,NULL,NULL,'8c17b376-1a2b-11e1-a51a-00248140a5eb'),
 (3,'Initialize Logic Rule Providers',NULL,'org.openmrs.logic.task.InitializeLogicRuleProvidersTask','2013-12-06 11:23:02',NULL,1999999999,0,1,2,'2013-11-04 16:33:00',2,'2013-12-06 11:22:32','2013-11-25 15:40:25','35778d6d-c8fb-48e6-a9d9-17892eac1a8f'),
 (6,'Process Usage Statistics Data','Deletes or aggregates old usage statistics data','org.openmrs.module.usagestatistics.tasks.AggregatorTask','2013-11-05 00:00:00',NULL,3600,1,1,2,'2013-11-05 11:32:23',2,'2013-11-05 13:00:00','2013-11-05 13:00:00','ff4ba970-6b73-4f5f-a548-975035acd9d4'),
 (7,'Send Usage Statistics Reports','Sends usage statistics reports','org.openmrs.module.usagestatistics.tasks.SendReportsTask','2013-11-05 00:00:00',NULL,86400,1,1,2,'2013-11-05 11:32:23',2,'2013-11-05 12:06:48',NULL,'1a02d757-ba83-4098-b3a8-e7938f8c8839');
/*!40000 ALTER TABLE `scheduler_task_config` ENABLE KEYS */;


--
-- Definition of table `scheduler_task_config_property`
--

DROP TABLE IF EXISTS `scheduler_task_config_property`;
CREATE TABLE `scheduler_task_config_property` (
  `task_config_property_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` text,
  `task_config_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`task_config_property_id`),
  KEY `task_config_for_property` (`task_config_id`),
  CONSTRAINT `task_config_for_property` FOREIGN KEY (`task_config_id`) REFERENCES `scheduler_task_config` (`task_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `scheduler_task_config_property`
--

/*!40000 ALTER TABLE `scheduler_task_config_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_task_config_property` ENABLE KEYS */;


--
-- Definition of table `serialized_object`
--

DROP TABLE IF EXISTS `serialized_object`;
CREATE TABLE `serialized_object` (
  `serialized_object_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `subtype` varchar(255) NOT NULL,
  `serialization_class` varchar(255) NOT NULL,
  `serialized_data` mediumtext NOT NULL,
  `date_created` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(1000) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`serialized_object_id`),
  UNIQUE KEY `serialized_object_uuid_index` (`uuid`),
  KEY `serialized_object_creator` (`creator`),
  KEY `serialized_object_changed_by` (`changed_by`),
  KEY `serialized_object_retired_by` (`retired_by`),
  CONSTRAINT `serialized_object_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `serialized_object_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `serialized_object_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `serialized_object`
--

/*!40000 ALTER TABLE `serialized_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `serialized_object` ENABLE KEYS */;


--
-- Definition of table `test_order`
--

DROP TABLE IF EXISTS `test_order`;
CREATE TABLE `test_order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `specimen_source` int(11) DEFAULT NULL,
  `laterality` varchar(20) DEFAULT NULL,
  `clinical_history` text,
  PRIMARY KEY (`order_id`),
  KEY `test_order_specimen_source_fk` (`specimen_source`),
  CONSTRAINT `test_order_order_id_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `test_order_specimen_source_fk` FOREIGN KEY (`specimen_source`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `test_order`
--

/*!40000 ALTER TABLE `test_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_order` ENABLE KEYS */;


--
-- Definition of table `trac_sample_test`
--

DROP TABLE IF EXISTS `trac_sample_test`;
CREATE TABLE `trac_sample_test` (
  `sample_test_id` int(11) NOT NULL AUTO_INCREMENT,
  `sample_code` varchar(25) DEFAULT NULL,
  `test_obs_id` int(11) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `voided` tinyint(4) NOT NULL,
  `date_voided` date DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`sample_test_id`),
  UNIQUE KEY `sample_code` (`sample_code`),
  KEY `test_obs_id` (`test_obs_id`),
  KEY `creator` (`creator`),
  KEY `voided_by` (`voided_by`),
  CONSTRAINT `trac_sample_test_ibfk_1` FOREIGN KEY (`test_obs_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `trac_sample_test_ibfk_2` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `trac_sample_test_ibfk_3` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trac_sample_test`
--

/*!40000 ALTER TABLE `trac_sample_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `trac_sample_test` ENABLE KEYS */;


--
-- Definition of table `trac_sponsor`
--

DROP TABLE IF EXISTS `trac_sponsor`;
CREATE TABLE `trac_sponsor` (
  `sponsor_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `voided` tinyint(4) NOT NULL,
  `date_voided` date DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`sponsor_id`),
  KEY `creator` (`creator`),
  KEY `voided_by` (`voided_by`),
  CONSTRAINT `trac_sponsor_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `trac_sponsor_ibfk_2` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trac_sponsor`
--

/*!40000 ALTER TABLE `trac_sponsor` DISABLE KEYS */;
/*!40000 ALTER TABLE `trac_sponsor` ENABLE KEYS */;


--
-- Definition of table `trac_sponsor_location`
--

DROP TABLE IF EXISTS `trac_sponsor_location`;
CREATE TABLE `trac_sponsor_location` (
  `sponsor_location_id` int(11) NOT NULL AUTO_INCREMENT,
  `sponsor_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sponsered_since` date NOT NULL,
  `date_created` date DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `voided` tinyint(4) NOT NULL,
  `date_voided` date DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`sponsor_location_id`),
  KEY `creator` (`creator`),
  KEY `voided_by` (`voided_by`),
  KEY `location_id` (`location_id`),
  KEY `sponsor_id` (`sponsor_id`),
  CONSTRAINT `trac_sponsor_location_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `trac_sponsor_location_ibfk_2` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `trac_sponsor_location_ibfk_3` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `trac_sponsor_location_ibfk_4` FOREIGN KEY (`sponsor_id`) REFERENCES `trac_sponsor` (`sponsor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trac_sponsor_location`
--

/*!40000 ALTER TABLE `trac_sponsor_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `trac_sponsor_location` ENABLE KEYS */;


--
-- Definition of table `user_property`
--

DROP TABLE IF EXISTS `user_property`;
CREATE TABLE `user_property` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `property` varchar(100) NOT NULL DEFAULT '',
  `property_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`,`property`),
  CONSTRAINT `user_property_to_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_property`
--

/*!40000 ALTER TABLE `user_property` DISABLE KEYS */;
INSERT INTO `user_property` (`user_id`,`property`,`property_value`) VALUES 
 (1,'defaultLocation',''),
 (1,'loginAttempts','0'),
 (1,'notification',''),
 (1,'notificationAddress',''),
 (1,'showRetired','false'),
 (1,'showVerbose','false');
/*!40000 ALTER TABLE `user_property` ENABLE KEYS */;


--
-- Definition of table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `role` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`role`,`user_id`),
  KEY `user_role_to_users` (`user_id`),
  CONSTRAINT `role_definitions` FOREIGN KEY (`role`) REFERENCES `role` (`role`),
  CONSTRAINT `user_role_to_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_role`
--

/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` (`user_id`,`role`) VALUES 
 (1,'Provider'),
 (1,'System Developer');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;


--
-- Definition of table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `system_id` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `salt` varchar(128) DEFAULT NULL,
  `secret_question` varchar(255) DEFAULT NULL,
  `secret_answer` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `person_id` int(11) NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_who_changed_user` (`changed_by`),
  KEY `user_creator` (`creator`),
  KEY `user_who_retired_this_user` (`retired_by`),
  KEY `person_id_for_user` (`person_id`),
  CONSTRAINT `person_id_for_user` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `user_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_this_user` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`user_id`,`system_id`,`username`,`password`,`salt`,`secret_question`,`secret_answer`,`creator`,`date_created`,`changed_by`,`date_changed`,`person_id`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`) VALUES 
 (1,'admin',NULL,'3f6309c867c191684689d074d418d1404a5245e8bf2b3d7e0246d40efc848860cdaa6f2e493de7f95157c0438c1ed6a7b2e672f048797ee59dad1e08833e0098','9e3784ff8d58647bf114ae18dbad972461aa3bbdba59ee3485996b922971125ca407f38dc67103d962ff8c2949095c37bff6041bebdfd2588bd52ec33a5117f7',NULL,'',1,'2005-01-01 00:00:00',1,'2013-11-12 15:33:18',1,0,NULL,NULL,NULL,'70033a4e-4598-11e3-9d2c-f9d02340d97d'),
 (2,'daemon','daemon',NULL,NULL,NULL,NULL,1,'2010-04-26 13:25:00',NULL,NULL,1,0,NULL,NULL,NULL,'A4F30A1B-5EB9-11DF-A648-37A07F9C90FB');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `visit`
--

DROP TABLE IF EXISTS `visit`;
CREATE TABLE `visit` (
  `visit_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `visit_type_id` int(11) NOT NULL,
  `date_started` datetime NOT NULL,
  `date_stopped` datetime DEFAULT NULL,
  `indication_concept_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`visit_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_patient_index` (`patient_id`),
  KEY `visit_type_fk` (`visit_type_id`),
  KEY `visit_location_fk` (`location_id`),
  KEY `visit_creator_fk` (`creator`),
  KEY `visit_voided_by_fk` (`voided_by`),
  KEY `visit_changed_by_fk` (`changed_by`),
  KEY `visit_indication_concept_fk` (`indication_concept_id`),
  CONSTRAINT `visit_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_indication_concept_fk` FOREIGN KEY (`indication_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `visit_location_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `visit_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `visit_type_fk` FOREIGN KEY (`visit_type_id`) REFERENCES `visit_type` (`visit_type_id`),
  CONSTRAINT `visit_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `visit`
--

/*!40000 ALTER TABLE `visit` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit` ENABLE KEYS */;


--
-- Definition of table `visit_attribute`
--

DROP TABLE IF EXISTS `visit_attribute`;
CREATE TABLE `visit_attribute` (
  `visit_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`visit_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_attribute_visit_fk` (`visit_id`),
  KEY `visit_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `visit_attribute_creator_fk` (`creator`),
  KEY `visit_attribute_changed_by_fk` (`changed_by`),
  KEY `visit_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `visit_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `visit_attribute_type` (`visit_attribute_type_id`),
  CONSTRAINT `visit_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_attribute_visit_fk` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`),
  CONSTRAINT `visit_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `visit_attribute`
--

/*!40000 ALTER TABLE `visit_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_attribute` ENABLE KEYS */;


--
-- Definition of table `visit_attribute_type`
--

DROP TABLE IF EXISTS `visit_attribute_type`;
CREATE TABLE `visit_attribute_type` (
  `visit_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`visit_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_attribute_type_creator_fk` (`creator`),
  KEY `visit_attribute_type_changed_by_fk` (`changed_by`),
  KEY `visit_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `visit_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `visit_attribute_type`
--

/*!40000 ALTER TABLE `visit_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_attribute_type` ENABLE KEYS */;


--
-- Definition of table `visit_type`
--

DROP TABLE IF EXISTS `visit_type`;
CREATE TABLE `visit_type` (
  `visit_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`visit_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_type_creator` (`creator`),
  KEY `visit_type_changed_by` (`changed_by`),
  KEY `visit_type_retired_by` (`retired_by`),
  CONSTRAINT `visit_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_type_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `visit_type`
--

/*!40000 ALTER TABLE `visit_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_type` ENABLE KEYS */;


--
-- Definition of table `xforms_medical_history_field`
--

DROP TABLE IF EXISTS `xforms_medical_history_field`;
CREATE TABLE `xforms_medical_history_field` (
  `field_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `tabIndex` int(11) DEFAULT NULL,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `xforms_medical_history_field`
--

/*!40000 ALTER TABLE `xforms_medical_history_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `xforms_medical_history_field` ENABLE KEYS */;


--
-- Definition of table `xforms_person_repeat_attribute`
--

DROP TABLE IF EXISTS `xforms_person_repeat_attribute`;
CREATE TABLE `xforms_person_repeat_attribute` (
  `person_repeat_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(50) NOT NULL DEFAULT '',
  `person_attribute_type_id` int(11) NOT NULL DEFAULT '0',
  `value_id` int(11) NOT NULL DEFAULT '0',
  `value_id_type` int(11) NOT NULL DEFAULT '0',
  `value_display_order` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_repeat_attribute_id`),
  KEY `repeat_identifies_person` (`person_id`),
  KEY `repeat_defines_attribute_type` (`person_attribute_type_id`),
  KEY `repeat_attribute_creator` (`creator`),
  KEY `repeat_attribute_changer` (`changed_by`),
  KEY `repeat_attribute_voider` (`voided_by`),
  CONSTRAINT `repeat_attribute_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `repeat_attribute_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `repeat_attribute_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `repeat_defines_attribute_type` FOREIGN KEY (`person_attribute_type_id`) REFERENCES `person_attribute_type` (`person_attribute_type_id`),
  CONSTRAINT `repeat_identifies_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `xforms_person_repeat_attribute`
--

/*!40000 ALTER TABLE `xforms_person_repeat_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `xforms_person_repeat_attribute` ENABLE KEYS */;


--
-- Definition of table `xforms_xform`
--

DROP TABLE IF EXISTS `xforms_xform`;
CREATE TABLE `xforms_xform` (
  `form_id` int(11) NOT NULL,
  `xform_xml` longtext,
  `layout_xml` longtext,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `locale_xml` longtext,
  `javascript_src` longtext,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`form_id`),
  KEY `user_who_created_xform` (`creator`),
  KEY `form_with_which_xform_is_related` (`form_id`),
  KEY `user_who_last_changed_xform` (`changed_by`),
  CONSTRAINT `user_who_created_xform` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_last_changed_xform` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `xforms_xform`
--

/*!40000 ALTER TABLE `xforms_xform` DISABLE KEYS */;
/*!40000 ALTER TABLE `xforms_xform` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
