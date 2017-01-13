-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 13, 2017 at 06:23 PM
-- Server version: 5.5.52-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `lastminuteshowings`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE IF NOT EXISTS `admin_users` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(150) NOT NULL,
  `salt` varchar(150) NOT NULL,
  `user_type` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '1=admin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE IF NOT EXISTS `country` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `iso3_code` char(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `name`, `iso3_code`) VALUES
(1, 'United States', 'USA');

-- --------------------------------------------------------

--
-- Table structure for table `email_templates`
--

CREATE TABLE IF NOT EXISTS `email_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dis_name` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `from_name` varchar(255) DEFAULT NULL,
  `from_email_id` varchar(255) NOT NULL,
  `from_email_title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `email_templates`
--

INSERT INTO `email_templates` (`id`, `name`, `dis_name`, `subject`, `from_name`, `from_email_id`, `from_email_title`, `content`, `created_at`, `updated_at`) VALUES
(1, 'save_showing_email', 'Save showing email notification', 'Showing Confirmation for {{insert_showing_date}}', 'lastminuteshowings.com', 'support@lastminuteshowings.com', '{{email_titile}}', 'Hello {{agent_first_name}}, <br/><br/>\r\n\r\nYour showing has been posted.  Potential Showing Agents can now view your post.  You will receive a notification once your showing has been selected.  Please check details by logging into your LMS account. {{link_to_lms_login}}.  <br/><br/>\r\n\r\n<b>Showing Details:</b><br/><br/>\r\nDate of Showing: {{date_of_showing}}\r\n<br/><br/>\r\nStart Time: {{start_time}}\r\n<br/><br/>\r\nEnd Time: {{end_time}}\r\n<br/><br/>\r\nShowing Agent Fee: ${{additional_fee}}<br/><br/>\r\n<br/><br/>\r\n{{house_details}}\r\n\r\n<br/><br/>\r\n\r\nThank You,<br/>\r\n{{logo_url}} <br/>\r\n{{site_url}} <br/>\r\n{{from_email}}', '2016-11-02 00:00:00', '0000-00-00 00:00:00'),
(2, 'showing_selected_notification', 'Showing selected notification', 'Your showing for {{insert_showing_date}} has been selected', 'lastminuteshowings.com', 'support@lastminuteshowings.com', '{{email_titile}}', 'Hello {{posting_agent_first_name}},<br/><br/>\r\nCongratulations!  Your posting has been selected.  Please login into your LMS account to accept or decline Showing Agent.  {{link_to_lms_login}}.  \r\n<br/><br/>\r\n\r\n<b>Showing Agent Details:</b><br/><br/>\r\nName: {{showing_agent_first_name}}<br/><br/>\r\nPhone Number: {{showing_agent_phone_number}}<br/><br/>\r\nEmail: {{showing_agent_email}}\r\n<br/><br/>\r\n\r\n<b>Showing Details:</b><br/><br/>\r\nDate of Showing: {{date_of_showing}}\r\n<br/><br/>\r\nStart Time: {{start_time}}\r\n<br/><br/>\r\nEnd Time: {{end_time}}\r\n<br/><br/>\r\nShowing Agent Fee: ${{additional_fee}}<br/><br/>\r\n<br/>\r\n\r\n{{house_details}}\r\n\r\n<br/><br/>\r\n\r\nThank You,<br/>\r\n{{logo_url}} <br/>\r\n{{site_url}} <br/>\r\n{{from_email}}\r\n\r\n', '2016-11-02 00:00:00', '2016-11-02 00:00:00'),
(3, 'welcome_email', 'Welcome Email', 'sxsdc', '{{user_name}}', '{{email_id}}', '{{email_titile}}', 'Hello {{user_name}},\r\n\r\nHow are yourrrrr', '2016-11-02 00:00:00', '2016-11-02 00:00:00'),
(4, 'send_showing_edit_notification', 'Send showing edit notification', 'Your showing for {{Insert_showing_date}} has been updated.', 'lastminuteshowings.com', 'support@lastminuteshowings.com', '', 'Hello {{agent_first_name}}, <br/><br/>\r\nShowing for {{insert_showing_date}} has been updated by the Posting Agent.  Please check details by logging into your LMS {{link_to_lms_login}}.  <br/><br/>\r\n\r\n<b>Showing Details:</b><br/><br/>\r\nDate of Showing: {{date_of_showing}}\r\n<br/><br/>\r\nStart Time: {{start_time}}\r\n<br/><br/>\r\nEnd Time: {{end_time}}\r\n<br/><br/>\r\nShowing Agent Fee: ${{additional_fee}}<br/><br/>\r\n<br/><br/>\r\nThank You,<br/>\r\n{{logo_url}} <br/>\r\n{{site_url}} <br/>\r\n{{from_email}}', '2016-11-03 00:00:00', '0000-00-00 00:00:00'),
(5, 'send_showing_declined_notification', 'Send showing declined notification', 'Your showing for {{Insert_showing_date}} has been Declined.', 'lastminuteshowings.com', 'support@lastminuteshowings.com', '', 'Hello {{agent_first_name}}, <br/><br/>\r\nWe are sorry to inform you that the showing for {{insert_showing_date}} has been declined by the Posting Agent.  Please check details by logging into your LMS {{link_to_lms_login}}.  <br/> <br/>\r\n\r\n<b>Showing Details:</b><br/><br/>\r\nDate of Showing: {{date_of_showing}}\r\n<br/><br/>\r\nStart Time: {{start_time}}\r\n<br/><br/>\r\nEnd Time: {{end_time}}\r\n<br/><br/>\r\nShowing Agent Fee: ${{additional_fee}}<br/><br/>\r\n<br/>\r\n\r\nThank You,<br/>\r\n{{logo_url}} <br/>\r\n{{site_url}} <br/>\r\n{{from_email}}', '2016-11-03 00:00:00', '0000-00-00 00:00:00'),
(6, 'send_showing_approved_notification', 'Send showing approved notification', 'Your showing for {{insert_showing_date}}   has been Accepted.', 'lastminuteshowings.com', 'support@lastminuteshowings.com', '', 'Hello {{agent_first_name}}, <br/><br/>\r\nYour selected showing for {{insert_showing_date}}  has been accepted by the Posting Agent.It is your\r\nresponsibility to schedule showing and contact Customer. Upon completion, you must log into your LMS\r\naccount to finish the Completed Showing process. {{link_to_lms_login}}.  <br/> <br/>\r\n\r\n<b>Showing Details:</b><br/><br/>\r\nDate of Showing: {{date_of_showing}}\r\n<br/><br/>\r\nStart Time: {{start_time}}\r\n<br/><br/>\r\nEnd Time: {{end_time}}\r\n<br/><br/>\r\nShowing Agent Fee: ${{additional_fee}}<br/><br/>\r\n<br/>\r\n\r\n\r\n{{house_details}}\r\n\r\n<br/><br/>\r\n\r\n<b>Customer Details:</b><br/><br/>\r\nCustomer Name: {{customer_name}}\r\n<br/><br/>\r\nCustomer Email: {{custome_email}}\r\n<br/><br/>\r\nCustomer Phone Number: {{customer_phone}}\r\n<br/><br/><br/>\r\n\r\n<b>Posting Agent Details:</b><br/><br/>\r\nName: {{posting_agent_name}}\r\n<br/><br/>\r\nPhone Number: {{posting_agent_phone}}\r\n<br/><br/>\r\nEmail: {{posting_agent_email}}\r\n<br/><br/><br/>\r\n\r\nThank You,<br/>\r\n{{logo_url}} <br/>\r\n{{site_url}} <br/>\r\n{{from_email}}', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, 'send_showing_accept_notification', 'Send showing accept notification', 'Your showing for {{insert_showing_date}} has been submitted.', 'lastminuteshowings.com', 'support@lastminuteshowings.com', '', 'Hello {{agent_first_name}}, <br/><br/>\r\nYour selected showing for {{insert_showing_date}}  has been submitted by the Posting Agent.You will be notified via email if you''ve been selected.Please check details by logging into your LMS {{link_to_lms_login}}.  <br/> <br/> \r\n\r\n\r\n\r\nThank You,<br/><br/>\r\n{{logo_url}} <br/>\r\n{{site_url}} <br/>\r\n{{from_email}}', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(8, 'cron_email_for_showingagent', 'Cron email for complete feedback', 'Complete Feedback For {{insert_showing_date}} ', 'lastminuteshowings.com', 'support@lastminuteshowings.com', '', 'Hello  {{agent_first_name}}, <br/><br/>\nThis is a friendly reminder to Complete Feedback for your showing on <Insert Showing Date> Please log into your LMS account to finish this process. {{link_to_lms_login}}.  <br/> <br/>\n\n<b>Showing Details:</b><br/><br/>\nDate of Showing: {{date_of_showing}}\n<br/><br/>\nStart Time: {{start_time}}\n<br/><br/>\nEnd Time: {{end_time}}\n<br/><br/>\n\nShowing Agent Fee: ${{additional_fee}}<br/><br/>\n\n\n{{house_details}}\n\n<br/><br/>\nThank You,<br/>\n{{logo_url}} <br/>\n{{site_url}} <br/>\n{{from_email}}', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(9, 'cron_email_for_your_posting', 'Cron email for your posting', 'Your Posting For {{insert_showing_date}} ', 'lastminuteshowings.com', 'support@lastminuteshowings.com', '', 'Hello  {{agent_first_name}}, <br/><br/>\r\nThis message is to inform you that you have not received any Showing Offers for {{insert_showing_date}} .  <br/> <br/>\r\n\r\n<b>Showing Details:</b><br/><br/>\r\nDate of Showing: {{date_of_showing}}\r\n<br/><br/>\r\nStart Time: {{start_time}}\r\n<br/><br/>\r\nEnd Time: {{end_time}}\r\n<br/><br/>\r\n\r\nShowing Agent Fee: ${{additional_fee}}<br/><br/>\r\n\r\n\r\n{{house_details}}\r\n\r\n<br/><br/>\r\nThank You,<br/>\r\n{{logo_url}} <br/>\r\n{{site_url}} <br/>\r\n{{from_email}}', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(60) NOT NULL,
  `token` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('raj@test.com', 'e9b501a148db54039b13e519b30ea980e4b95757dd03bf64350192be12e96d89', '2015-07-29 08:55:41'),
('rajanikantb@mindfiresolutions.com', '6602ca5a1c9cc970e5f3734fe5ba5f8511bff9e7fd7a9b6828e22f73ee67eb63', '2015-07-30 00:16:25'),
('yogesh.yadav@webnyxa.com', '275678fa2ea90fc0fcb22b87300b5cf5ab12af72d6ad4a2c66b305fcc0ffe62b', '2016-10-24 23:14:18');

-- --------------------------------------------------------

--
-- Table structure for table `posting_agent_info`
--

CREATE TABLE IF NOT EXISTS `posting_agent_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT 'showing agent id',
  `auth_net_card_payment_id` varchar(45) NOT NULL COMMENT 'authorize.net credit card payment profile id',
  `card_full_name` varchar(45) NOT NULL COMMENT 'name on the credit card',
  `card_number` varchar(4) NOT NULL COMMENT 'credit card number',
  `expiry_month` tinyint(4) NOT NULL COMMENT 'From 1 - 12 i.e. 1 for January, 2 for February and 12 for December',
  `expiry_year` year(4) NOT NULL COMMENT 'yyyy format',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `posting_agent_info`
--

INSERT INTO `posting_agent_info` (`id`, `user_id`, `auth_net_card_payment_id`, `card_full_name`, `card_number`, `expiry_month`, `expiry_year`) VALUES
(1, 7, '0', 'Kurt Frank', '2222', 12, 2035),
(2, 11, '1500221589', 'Deepak Panwar', '0002', 12, 2020),
(3, 13, '1500211523', 'Deeapk Yahoo', '1111', 11, 2036),
(4, 14, '1500220477', 'yogesh Kumar y', '0012', 11, 2020),
(5, 15, '1500272618', 'Mohd Nadeem', '1111', 12, 2020),
(6, 12, '1500561110', 'mark', '1111', 12, 2022);

-- --------------------------------------------------------

--
-- Table structure for table `rejected_showings`
--

CREATE TABLE IF NOT EXISTS `rejected_showings` (
  `id` int(200) NOT NULL AUTO_INCREMENT,
  `showing_id` int(200) DEFAULT NULL,
  `posting_agent_id` int(200) DEFAULT NULL,
  `showing_agent_id` int(200) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `rejected_showings`
--

INSERT INTO `rejected_showings` (`id`, `showing_id`, `posting_agent_id`, `showing_agent_id`, `date`) VALUES
(1, 54444, 14, 15, '2016-08-19 01:21:27'),
(2, 57, 14, 15, '2016-08-19 07:47:44'),
(4, 59, 13, 15, '2016-08-23 23:46:11'),
(5, 60, 14, 13, '2016-08-23 23:55:23'),
(6, 76, 14, 15, '2016-11-24 06:57:07');

-- --------------------------------------------------------

--
-- Table structure for table `showings`
--

CREATE TABLE IF NOT EXISTS `showings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT 'posting agent id',
  `post_date` date NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `expiration_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `customer_name` varchar(255) NOT NULL,
  `customer_email` varchar(45) NOT NULL,
  `customer_phone_number` varchar(20) NOT NULL,
  `comments` text NOT NULL,
  `additional_fee` decimal(7,2) NOT NULL DEFAULT '0.00',
  `house_count` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'value will be from 1 to 10',
  `showing_progress` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1=accepted by showing agent, 2=approved by posting agent, 3=rejected by posting agent, 4=completed, 5=block payment, 6=payment done',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=inactive, 1=active, 2=cancelled, 3=expired',
  `showing_user_id` int(11) unsigned NOT NULL COMMENT 'showing agent id',
  `search_criteria` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0=search by name or everyone, 1=agent rating(1+), 2=agent rating(2+), 3=agent rating(3+), 4=agent rating(4+), 5=agent rating(5)',
  `email_notify_sa` timestamp NULL DEFAULT NULL,
  `email_notify_pa` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `showing_user_id` (`showing_user_id`),
  KEY `user_id_2` (`user_id`),
  KEY `showing_user_id_2` (`showing_user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=81 ;

--
-- Dumping data for table `showings`
--

INSERT INTO `showings` (`id`, `user_id`, `post_date`, `start_time`, `end_time`, `expiration_time`, `customer_name`, `customer_email`, `customer_phone_number`, `comments`, `additional_fee`, `house_count`, `showing_progress`, `status`, `showing_user_id`, `search_criteria`, `email_notify_sa`, `email_notify_pa`, `created_at`, `updated_at`) VALUES
(1, 7, '2016-08-17', '2016-08-17 09:00:00', '2016-08-17 10:00:00', '2016-08-17 10:00:00', 'craig fallon', 'craig@craig.com', '303-654-6599', 'THIS IS A TEST ', 20.00, 1, 4, 0, 0, 0, NULL, NULL, '2016-07-29 04:30:14', '2016-08-11 05:09:31'),
(2, 10, '2016-08-20', '2016-08-20 22:00:00', '2016-08-20 23:00:00', '2016-08-20 23:00:00', 'Steve Smith ', 'steve@steve.com', '303-789-7899', 'These guys are picky', 40.00, 1, 0, 0, 0, 0, NULL, NULL, '2016-08-01 10:20:13', '2016-08-08 08:04:38'),
(3, 11, '2016-08-31', '2016-08-31 10:00:00', '2016-08-31 11:00:00', '2016-08-31 11:00:00', 'Mark', 'mark@mark.com', '1212112121', '21111', 5.00, 1, 6, 0, 0, 0, NULL, NULL, '2016-08-01 13:40:12', '2016-08-19 14:04:11'),
(42, 11, '2016-08-07', '2016-08-07 15:00:00', '2016-08-07 16:00:00', '2016-09-01 16:00:00', 'aug25', 'aug25@gmail.com', '2323232312', '', 900.00, 1, 1, 0, 12, 0, NULL, NULL, '2016-08-06 13:14:32', '2016-08-08 14:38:24'),
(43, 13, '2016-10-15', '2016-10-15 03:00:00', '2016-10-15 04:00:00', '2016-10-15 04:00:00', 'oct15', 'oct15@gmail.com', '(223)423-1510', '', 500.00, 1, 4, 0, 8, 0, NULL, NULL, '2016-08-06 13:36:08', '2016-12-09 05:36:15'),
(45, 13, '2016-08-29', '2016-08-29 08:00:00', '2016-08-29 10:00:00', '2016-08-29 10:00:00', 'aug29', 'aug29@gmail.com', '9898989898', '', 100.00, 1, 0, 0, 0, 0, NULL, NULL, '2016-08-08 13:07:07', '2016-08-24 04:45:58'),
(46, 15, '2016-08-09', '2016-08-08 20:30:00', '2016-08-09 16:30:00', '2016-08-09 16:30:00', 'Yogesh', 'yogi@gmail.com', '1234567895', '', 0.00, 1, 0, 0, 0, 0, NULL, NULL, '2016-08-08 23:25:24', '2016-08-08 23:25:24'),
(53, 14, '2016-08-19', '2016-08-18 19:30:00', '2016-08-19 16:30:00', '2016-08-19 16:30:00', 'anshu', 'anshu@gmail.com', '1254789652', 'Test', 100.00, 2, 6, 0, 15, 0, NULL, NULL, '2016-08-11 04:01:21', '2016-08-20 04:43:25'),
(54, 14, '2016-11-23', '2016-11-22 20:30:00', '2016-11-23 17:30:00', '2016-11-23 17:30:00', 'Rajat', 'rajat@gmail.com', '9506601510', 'Hello this is test', 0.00, 1, 5, 0, 15, 0, NULL, '2016-11-22 18:30:00', '2016-08-19 00:22:12', '2016-11-23 09:22:14'),
(56, 14, '2016-11-17', '2016-11-16 19:30:00', '2016-11-17 17:30:00', '2016-11-17 17:30:00', 'modiii', 'modi@gmail.com', '9548787415', 'modi testiiii', 47.00, 1, 6, 0, 15, 0, '2016-11-22 18:30:00', '2016-11-14 18:30:00', '2016-08-19 04:20:14', '2016-12-08 10:04:52'),
(57, 14, '2016-08-26', '2016-08-25 20:30:00', '2016-08-26 16:30:00', '2016-08-26 16:30:00', 'sonia', 'sonia@gmail.com', '132157898797', 'Sonia ji', 0.00, 1, 0, 0, 0, 0, NULL, NULL, '2016-08-19 07:45:37', '2016-08-19 13:17:44'),
(58, 14, '2016-08-23', '2016-08-23 01:30:00', '2016-08-23 15:30:00', '2016-08-23 15:30:00', 'Jetali', 'jetali@gmail.com', '12547854125', 'Hello jetali ji', 0.00, 1, 2, 0, 13, 0, '2016-11-22 18:30:00', NULL, '2016-08-23 02:21:21', '2016-11-23 05:44:44'),
(59, 13, '2016-08-24', '2016-08-23 22:30:00', '2016-08-24 10:30:00', '2016-08-24 10:30:00', 'Lalu', 'lalu@gmail.com', '1234567895', 'Hello Lalu this is test', 0.00, 1, 0, 0, 0, 0, NULL, NULL, '2016-08-23 23:06:24', '2016-08-24 05:16:11'),
(60, 14, '2016-08-24', '2016-08-23 23:30:00', '2016-08-24 11:30:00', '2016-08-24 11:30:00', 'Nitish', 'nitishkumar@gmail.com', '12345678954', 'Hello nitish this is test ', 0.00, 1, 0, 0, 0, 0, NULL, NULL, '2016-08-23 23:53:47', '2016-08-24 05:25:23'),
(62, 14, '2016-10-26', '2016-10-25 18:30:00', '2016-10-26 17:30:00', '2016-10-26 17:30:00', 'yogitest', 'test@gmail.com', '3434343', 'shdsds', 1.00, 1, 0, 0, 0, 0, NULL, NULL, '2016-10-26 00:03:09', '2016-10-26 00:03:09'),
(70, 13, '2016-10-28', '2016-10-27 19:30:00', '2016-10-28 17:30:00', '2016-10-28 17:30:00', 'rgddf', 'dsd@gmail.com', '2342342342', 'sdasdasdas', 0.00, 1, 0, 0, 0, 0, NULL, NULL, '2016-10-27 05:37:00', '2016-10-27 05:37:00'),
(71, 13, '2016-10-28', '2016-10-27 19:30:00', '2016-10-28 17:30:00', '2016-10-28 17:30:00', 'rgddf', 'dsd@gmail.com', '2342342342', 'sdasdasdas', 0.00, 1, 0, 0, 0, 0, NULL, NULL, '2016-10-27 05:37:53', '2016-10-27 05:37:53'),
(72, 13, '2016-10-29', '2016-10-28 19:30:00', '2016-10-29 17:30:00', '2016-10-29 17:30:00', 'yogesh28', 'dfsd@gmail.com', '(231)231-2312', 'Its yogesh test', 0.00, 1, 0, 0, 0, 0, NULL, NULL, '2016-10-28 00:09:00', '2016-10-28 04:43:24'),
(73, 14, '2016-11-24', '2016-11-23 18:30:00', '2016-11-24 17:30:00', '2016-11-24 17:30:00', 'Rajnath Singh', 'rajnath@gmail.com', '(334)534-5345', '', 0.00, 1, 6, 0, 15, 0, NULL, NULL, '2016-11-24 00:30:54', '2016-11-24 06:43:06'),
(74, 13, '2016-11-24', '2016-11-23 19:30:00', '2016-11-24 17:30:00', '2016-11-24 17:30:00', 'Kiran', 'kiran@gmail.com', '(232)323-1231', '', 0.00, 1, 6, 0, 15, 0, NULL, NULL, '2016-11-24 01:51:04', '2016-11-24 07:38:35'),
(75, 14, '2016-11-24', '2016-11-23 21:30:00', '2016-11-24 09:30:00', '2016-11-24 09:30:00', 'Gulam ali', 'gulam@gmail.com', '(322)323-2112', '', 0.00, 1, 6, 0, 13, 0, NULL, NULL, '2016-11-24 02:18:19', '2016-12-01 08:00:03'),
(76, 14, '2016-11-25', '2016-11-24 19:30:00', '2016-11-25 16:30:00', '2016-11-25 16:30:00', 'ram', 'ram@gmail.com', '(343)423-4234', '44', 0.00, 1, 1, 0, 13, 0, NULL, NULL, '2016-11-24 06:55:38', '2016-11-25 06:27:04'),
(77, 14, '2016-12-01', '2016-12-01 09:30:00', '2016-12-01 17:30:00', '2016-12-01 17:30:00', 'Dectest', 'Dectest@gmail.com', '(342)342-3423', '', 0.00, 1, 3, 0, 0, 0, NULL, NULL, '2016-12-01 01:42:46', '2017-01-05 05:09:49'),
(78, 14, '2017-01-05', '2017-01-04 18:30:00', '2017-01-05 03:30:00', '2017-01-05 03:30:00', 'Yogesh', 'yogesh@webnyxa.com', '(436)889-5607', '', 10.00, 1, 0, 0, 0, 0, NULL, NULL, '2017-01-04 01:53:31', '2017-01-04 01:53:31'),
(79, 14, '2017-01-05', '2017-01-04 18:30:00', '2017-01-05 03:30:00', '2017-01-05 03:30:00', 'Yogesh', 'yogesh@webnyxa.com', '(436)889-5607', '', 10.00, 1, 0, 0, 0, 0, NULL, NULL, '2017-01-04 01:53:51', '2017-01-04 01:53:51'),
(80, 14, '2017-01-04', '2017-01-04 09:30:00', '2017-01-04 17:30:00', '2017-01-04 17:30:00', 'Yogesh', 'yogesh.yadav@webnyxa.com', '(983)278-6387', '', 1.00, 1, 0, 0, 0, 0, NULL, NULL, '2017-01-04 01:56:48', '2017-01-04 01:56:48');

-- --------------------------------------------------------

--
-- Table structure for table `showing_agent_info`
--

CREATE TABLE IF NOT EXISTS `showing_agent_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT 'posting agent id',
  `auth_net_bank_account_id` varchar(45) NOT NULL COMMENT 'authorize.net bank account id',
  `bank_name` varchar(45) NOT NULL,
  `account_name` varchar(45) NOT NULL,
  `routing_number` varchar(45) NOT NULL COMMENT 'Routing/SWIFT/IBAN Number',
  `account_number` varchar(45) NOT NULL,
  `account_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0=savings, 1=checking 2= business checking',
  `mobile_pin_number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `showing_agent_info`
--

INSERT INTO `showing_agent_info` (`id`, `user_id`, `auth_net_bank_account_id`, `bank_name`, `account_name`, `routing_number`, `account_number`, `account_type`, `mobile_pin_number`) VALUES
(1, 8, '0', 'test', '14141414141414', '123456789', '14141414141414', 0, NULL),
(2, 9, '0', 'SBI', 'Yogesh', '123456789', '893197954585', 0, NULL),
(3, 10, '0', 'US Bank', 'Kurt Frank', '102000076', '5178067632', 1, NULL),
(4, 12, '1500556779', 'HDFC', 'Mark Rozer', '121212121', '4111111111111111', 0, NULL),
(5, 13, '1500211524', 'HDFC', 'Deepak Yahoo11', '222222223', '370000000000002', 0, NULL),
(6, 14, '1500220478', 'SBI', 'Yogesh Kumar Yadava', '026009140', '313579264089', 0, NULL),
(7, 15, '1500272616', 'SBI', 'Nandeem Khann', '123456789', '893197954585', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `showing_houses`
--

CREATE TABLE IF NOT EXISTS `showing_houses` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `showing_id` int(11) unsigned NOT NULL,
  `address` varchar(255) NOT NULL,
  `unit_number` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `zip` varchar(100) DEFAULT NULL,
  `list_price` double(10,4) NOT NULL,
  `MLS_number` varchar(45) NOT NULL,
  `lat_long` varchar(255) NOT NULL COMMENT 'latitude and longitude of houses',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=170 ;

--
-- Dumping data for table `showing_houses`
--

INSERT INTO `showing_houses` (`id`, `showing_id`, `address`, `unit_number`, `city`, `state`, `zip`, `list_price`, `MLS_number`, `lat_long`) VALUES
(1, 1, '12345 Main St., englewood co 80111', NULL, NULL, NULL, NULL, 20.0000, '25648', '{"lat":39.5792143,"lng":-104.8697094}'),
(2, 2, '9602 East Caley Circle, englewood, co 80111', NULL, NULL, NULL, NULL, 20.0000, '123546', '{"lat":39.601118,"lng":-104.8773609}'),
(31, 3, ' 100 MAIN ST,    PO BOX 1022,   SEATTLE WA 98104,   USA', '1245', 'Alabama', '1', '201301', 20.0000, '11', '{"lat":43.0964478,"lng":-78.3908559}'),
(37, 42, '119 Broken Way, Secert Bay, AK, 99826', '1211', 'AK', '4', '99826', 20.0000, '212', '{"lat":35.20105,"lng":-91.8318334}'),
(48, 53, 'H22', '123', 'Arizona', '3', '123456', 20.0000, '12', '{"lat":32.7794886,"lng":-92.952296}'),
(50, 53, 'H44noida', '123', 'colambia', '4', '987654', 20.0000, '125', ''),
(53, 54, 'H99 ', '123', 'Arizona', '3', '123456', 20.0000, '123', '{"lat":32.7794886,"lng":-92.952296}'),
(56, 57, 'K77 gandhi nagar ', '456', 'Alasaka', '2', '123456', 20.0000, '12', '{"lat":64.2008413,"lng":-149.4936733}'),
(57, 58, 'J55 JEtali nagar', '235', 'Idaho', '12', '123456', 20.0000, '4', '{"lat":45.9019541,"lng":-115.7237432}'),
(58, 59, 'Lalu H77 New Kondali', '123456789', 'Alabama', '1', '1234456', 20.0000, '4534534', '{"lat":32.3182314,"lng":-86.902298}'),
(59, 60, 'N55 Nitish nagar', '12344', 'Alabama', '1', '123456', 20.0000, '1234', '{"lat":32.3182314,"lng":-86.902298}'),
(60, 61, '', '', '', '1', '', 20.0000, '', '{"lat":32.3182314,"lng":-86.902298}'),
(61, 62, '6755 Earl Dr, Colorado Springs, CO 80918, United States', '6755', '6755', '6', '80918', 20.0000, '11', '{"lat":38.92903,"lng":-104.796094}'),
(62, 63, 'sfsdfdf', 'dsd', '112', '6', '44335', 20.0000, '4343', '{"lat":39.5500507,"lng":-105.7820674}'),
(76, 43, 'My Street 1215, Houston, Texas, 77057, USA', '1515', 'Houston', '43', '77057', 20.0000, '1515', '{"lat":30.0844683,"lng":-95.195061}'),
(77, 65, '', '', '', '6', '', 20.0000, '', '{"lat":39.5500507,"lng":-105.7820674}'),
(78, 65, '', '', '', '6', '', 20.0000, '', '{"lat":39.5500507,"lng":-105.7820674}'),
(79, 66, '\r\n\r\nColorado School of Mines\r\n1500 Illinois St.\r\nGolden, CO 80401', '1500', 'Golden', '6', '80401', 20.0000, '3432', '{"lat":39.755543,"lng":-105.2210997}'),
(80, 67, '\r\n\r\nColorado School of Mines\r\n1500 Illinois St.\r\nGolden, CO 80401', '1500', 'Golden', '6', '80401', 20.0000, '34', '{"lat":39.755543,"lng":-105.2210997}'),
(81, 68, '\r\n\r\nColorado School of Mines\r\n1500 Illinois St.\r\nGolden, CO 80401', '1500', 'Golden', '6', '80401', 20.0000, '34', '{"lat":39.755543,"lng":-105.2210997}'),
(82, 69, '\r\n\r\nColorado School of Mines\r\n1500 Illinois St.\r\nGolden, CO 80401', '1500', 'Golden', '6', '80401', 20.0000, '34', '{"lat":39.755543,"lng":-105.2210997}'),
(83, 70, '\r\n\r\nColorado School of Mines\r\n1500 Illinois St.\r\nGolden, CO 80401', '1500', 'Golden', '6', '80401', 20.0000, '123', '{"lat":39.755543,"lng":-105.2210997}'),
(84, 71, '\r\n\r\nColorado School of Mines\r\n1500 Illinois St.\r\nGolden, CO 80401', '1500', 'Golden', '6', '80401', 20.0000, '123', '{"lat":39.755543,"lng":-105.2210997}'),
(96, 72, 'Colorado School of Mines\r\n1500 Illinois St.\r\nGolden, CO 80401', '1500', 'Golden', '6', '80401', 20.0000, '123', '{"lat":39.755543,"lng":-105.2210997}'),
(98, 77, '13001 E. 17th Pl.\r\nAurora, CO 80045', '13001', 'Aurora', '6', '80045', 20.0000, '123', '{"lat":39.7451768,"lng":-104.8377087}'),
(100, 79, '13001 E. 17th Pl.\r\nAurora, CO 80045', '13001', 'Aurora', '6', '80045', 20.0000, '123', '{"lat":39.7451768,"lng":-104.8377087}'),
(101, 80, '13001 E. 17th Pl.\r\nAurora, CO 80045', '13001', 'Aurora', '6', '80045', 20.0000, '123', '{"lat":39.7451768,"lng":-104.8377087}'),
(102, 82, '13001 E. 17th Pl.\r\nAurora, CO 80045', '13001', 'Aurora', '6', '80045', 20.0000, '123', '{"lat":39.7451768,"lng":-104.8377087}'),
(103, 83, '13001 E. 17th Pl.\r\nAurora, CO 80045', '13001', 'Aurora', '6', '80045', 20.0000, '123', '{"lat":39.7451768,"lng":-104.8377087}'),
(104, 84, '13001 E. 17th Pl.\r\nAurora, CO 80045', '13001', 'Aurora', '6', '80045', 20.0000, '123', '{"lat":39.7451768,"lng":-104.8377087}'),
(105, 85, '13001 E. 17th Pl.\r\nAurora, CO 80045', '13001', 'Aurora', '6', '80045', 20.0000, '123', '{"lat":39.7451768,"lng":-104.8377087}'),
(106, 86, '13001 E. 17th Pl.\r\nAurora, CO 80045', '13001', 'Aurora', '6', '80045', 20.0000, '123', '{"lat":39.7451768,"lng":-104.8377087}'),
(107, 87, '13001 E. 17th Pl.\r\nAurora, CO 80045', '13001', 'Aurora', '6', '80045', 20.0000, '123', '{"lat":39.7451768,"lng":-104.8377087}'),
(110, 90, '13001 E. 17th Pl.\r\nAurora, CO 80045', '13001', 'Aurora', '6', '80045', 20.0000, '123', '{"lat":39.7451768,"lng":-104.8377087}'),
(111, 91, '13001 E. 17th Pl.\r\nAurora, CO 80045', '13001', 'Aurora', '6', '80045', 20.0000, '123', '{"lat":39.7451768,"lng":-104.8377087}'),
(112, 92, '13001 E. 17th Pl.\r\nAurora, CO 80045', '13001', 'Aurora', '6', '80045', 20.0000, '123', '{"lat":39.7451768,"lng":-104.8377087}'),
(114, 74, '1201 Larimer St.\r\nSte. 5005\r\nDenver, CO 80204	', '1201', 'Denver', '6', '80204', 20.0000, '1234', '{"lat":39.7463895,"lng":-105.0023325}'),
(115, 75, '1201 Larimer St.\r\nSte. 5005\r\nDenver, CO 80204	', '1201', 'Denver', '6', '80204', 20.0000, '1234', '{"lat":39.7463895,"lng":-105.0023325}'),
(117, 77, '1201 Larimer St.\r\nSte. 5005\r\nDenver, CO 80204	', '1201', 'Denver', '6', '80204', 20.0000, '1234', '{"lat":39.7463895,"lng":-105.0023325}'),
(119, 79, '1201 Larimer St.\r\nSte. 5005\r\nDenver, CO 80204	', '1201', 'Denver', '6', '80204', 20.0000, '34234234', '{"lat":39.7463895,"lng":-105.0023325}'),
(120, 80, '1201 Larimer St.\r\nSte. 5005\r\nDenver, CO 80204	', '1201', 'Denver', '6', '80204', 20.0000, '34234234', '{"lat":39.7463895,"lng":-105.0023325}'),
(121, 81, '1201 Larimer St.\r\nSte. 5005\r\nDenver, CO 80204	', '1201', 'Denver', '6', '80204', 20.0000, '34234234', '{"lat":39.7463895,"lng":-105.0023325}'),
(122, 82, '1201 Larimer St.\r\nSte. 5005\r\nDenver, CO 80204	', '1201', 'Denver', '6', '80204', 20.0000, '34234234', '{"lat":39.7463895,"lng":-105.0023325}'),
(123, 83, '1201 Larimer St.\r\nSte. 5005\r\nDenver, CO 80204	', '1201', 'Denver', '6', '80204', 20.0000, '34234234', '{"lat":39.7463895,"lng":-105.0023325}'),
(124, 84, '1201 Larimer St.\r\nSte. 5005\r\nDenver, CO 80204	', '1201', 'Denver', '6', '80204', 20.0000, '34234234', '{"lat":39.7463895,"lng":-105.0023325}'),
(128, 85, 'Individual''s Name\r\nDepartment or Program\r\nUniversity of Colorado at Boulder \r\n123 UCB \r\nBoulder, Colorado 80309', '123', 'Colorado', '8', '80309', 20.0000, '123', '{"lat":40.0149856,"lng":-105.2705456}'),
(129, 86, 'H44', '233', 'sds', '6', '23423', 20.0000, '1232321', '{"lat":39.5500507,"lng":-105.7820674}'),
(130, 87, 'sd44', '23', '3', '6', '23232', 20.0000, '32', '{"lat":39.5500507,"lng":-105.7820674}'),
(154, 56, 'H666622', '123', 'Arizona', '3', '12345', 20.0000, '123', '{"lat":32.7794886,"lng":-92.952296}'),
(156, 90, 'H44', '123', 'Colorado', '6', '23434', 20.0000, '1234', '{"lat":39.651989,"lng":-106.622379}'),
(157, 91, 'H44', '123', 'Colorado', '6', '23434', 20.0000, '1234', '{"lat":39.651989,"lng":-106.622379}'),
(158, 92, 'H44', '123', 'Colorado', '6', '23434', 20.0000, '1234', '{"lat":39.651989,"lng":-106.622379}'),
(159, 93, 'H44', '123', 'Colorado', '6', '23434', 20.0000, '1234', '{"lat":39.651989,"lng":-106.622379}'),
(160, 73, 'Office of Admissions\nCampus Box 167\nPO Box 173364\nDenver, CO 80217-3364', '167', 'Denver', '6', '80217', 20.0000, '3364', '{"lat":39.790486,"lng":-104.9000469}'),
(161, 74, 'Office of Admissions\r\nCampus Box 167\r\nPO Box 173364\r\nDenver, CO 80217-3364', '167', 'Denver', '6', '173364', 20.0000, '80217', '{"lat":39.790486,"lng":-104.9000469}'),
(162, 75, 'Office of Admissions\r\nCampus Box 167\r\nPO Box 173364\r\nDenver, CO 80217-3364', '167', 'Denver', '6', '80217', 20.0000, '3364', '{"lat":39.790486,"lng":-104.9000469}'),
(164, 77, '	Office of Admissions\r\nCampus Box 167\r\nPO Box 173364\r\nDenver, CO 80217-3364', '167', 'Denver', '6', '80217', 20.0000, '3364', '{"lat":39.790486,"lng":-104.9000469}'),
(166, 79, 'Address New Delhi', '2', 'California', '5', '9806235', 20.0000, '982782', '""'),
(167, 80, 'New Delhi', '1', 'Nd', '6', '98776', 20.0000, '87678', '""'),
(168, 78, '13001 E. 17th Pl.\r\nAurora, CO 80045', '13001', 'Aurora', '6', '80045', 20.0000, '123', '{"lat":39.7451768,"lng":-104.8377087}'),
(169, 76, '1201 Larimer St.\r\nSte. 5005\r\nDenver, CO 80204	', '1201', 'Denver', '6', '80204', 20.0000, '1234', '{"lat":39.7463895,"lng":-105.0023325}');

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

CREATE TABLE IF NOT EXISTS `state` (
  `id` tinyint(4) unsigned NOT NULL AUTO_INCREMENT,
  `country_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `state_country_id` (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=51 ;

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`id`, `country_id`, `name`) VALUES
(1, 1, 'Alabama'),
(2, 1, 'Alaska'),
(3, 1, 'Arizona'),
(4, 1, 'Arkansas'),
(5, 1, 'California'),
(6, 1, 'Colorado'),
(7, 1, 'Connecticut'),
(8, 1, 'Delaware'),
(9, 1, 'Florida'),
(10, 1, 'Georgia'),
(11, 1, 'Hawaii'),
(12, 1, 'Idaho'),
(13, 1, 'Illinois'),
(14, 1, 'Indiana'),
(15, 1, 'Iowa'),
(16, 1, 'Kansas'),
(17, 1, 'Kentucky'),
(18, 1, 'Louisiana'),
(19, 1, 'Maine'),
(20, 1, 'Maryland'),
(21, 1, 'Massachusetts'),
(22, 1, 'Michigan'),
(23, 1, 'Minnesota'),
(24, 1, 'Mississippi'),
(25, 1, 'Missouri'),
(26, 1, 'Montana'),
(27, 1, 'Nebraska'),
(28, 1, 'Nevada'),
(29, 1, 'New Hampshire'),
(30, 1, 'New Jersey'),
(31, 1, 'New Mexico'),
(32, 1, 'New York'),
(33, 1, 'North Carolina'),
(34, 1, 'North Dakota'),
(35, 1, 'Ohio'),
(36, 1, 'Oklahoma'),
(37, 1, 'Oregon'),
(38, 1, 'Pennsylvania'),
(39, 1, 'Rhode Island'),
(40, 1, 'South Carolina'),
(41, 1, 'South Dakota'),
(42, 1, 'Tennessee'),
(43, 1, 'Texas'),
(44, 1, 'Utah'),
(45, 1, 'Vermont'),
(46, 1, 'Virginia'),
(47, 1, 'Washington'),
(48, 1, 'West Virginia'),
(49, 1, 'Wisconsin'),
(50, 1, 'Wyoming');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `auth_net_customer_id` varchar(45) NOT NULL DEFAULT '''''' COMMENT 'Authrize.Net customer id',
  `country_id` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'For now, default is 1 i.e. USA',
  `state_id` tinyint(3) unsigned NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `license_number` varchar(20) NOT NULL,
  `brokerage_firm_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(150) NOT NULL,
  `notification_preference` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0=email, 1=text, 2=both',
  `user_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0=not assigned any type, 1=posting agent, 2=showing agent, 3=posting & showing agent (both)',
  `profile_photo` varchar(45) DEFAULT NULL,
  `personal_bio` text,
  `average_rating` decimal(3,2) unsigned NOT NULL DEFAULT '0.00',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=inactive, 1=active, 2=cancelled',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `remember_token` varchar(255) NOT NULL,
  `activation_code` char(105) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `auth_net_customer_id`, `country_id`, `state_id`, `phone_number`, `license_number`, `brokerage_firm_name`, `email`, `password`, `notification_preference`, `user_type`, `profile_photo`, `personal_bio`, `average_rating`, `status`, `created_at`, `updated_at`, `remember_token`, `activation_code`) VALUES
(2, 'rajanikant', 'beero', '', 4, 5, '9658786196', '1234', 'mindfire solutions', 'rajanikantb@mindfiresolutions.com', '$2y$10$cawsfDqWP4w1WK28aYuI5u/7cPg/lQeh8qI6B8668BpZcwSsJSMjO', 0, 0, NULL, NULL, 0.00, 1, '2015-07-23 12:37:37', '2015-07-30 07:51:06', 'WOzXzc91x97DeArUqydaQpdernSAcFBuIVIl0rSH6BeiNmGSJEOAcmgRSnTg', NULL),
(3, 'pravasini', 'sahoo', '', 4, 5, '9658786196', '1234', 'mindfire solutions', 'pravasinis@mindfiresolutions.com', '7d5f9c268ccdf04983b165407b66302a', 0, 0, NULL, NULL, 0.00, 0, '2015-07-24 01:02:14', '2016-07-26 13:09:21', 'nG5YJK9yIPJZQyc6s2SRchefqAcraV6ujstYO5qOZWAbS8BunPZ4CXjJKCfM', NULL),
(4, 'Rajanikant', 'Beero', '', 4, 0, '3298732309', '98242423422', 'QWERTY', 'raj@test.com', '$2y$10$RHjGxce8CMmtMk6U3SAQmOkVBmXQSgFxzIy87FkP4TOK6EgMJTYrO', 0, 0, NULL, NULL, 0.00, 0, '2015-07-24 02:31:28', '2015-07-28 10:26:35', 'Q0yPREwglb5ESZsjgbc3Gl0Vy03RGY37XiHC1yqfRNc25EKSdqbe1ekvMuti', NULL),
(7, 'Steve', 'Smith ', '1500326920', 1, 6, '720-635-0430', '12564', 'Remax', 'kurt.frank@rapidfunnel.com', '$2y$10$S9nzJyitv3SlW5aEpn91FeeTIMfY/kWL7nytBbRtTlS133ru2RSr6', 0, 1, '', 'swswwsw', 0.00, 0, '2016-07-29 04:26:37', '2016-08-01 10:27:05', '9LXLXEvHx8QJzEJIDzcHNHvtNhRzkJ84lr6jSFDOLWSDOmPIxx5uoOd0FhHC', 's2ignSqfhywo3tAuthZ2WkBdozHFBNLkYd8gUFeP3US29J1R3coPRT99N99Ukurt.frank@rapidfunnel.com'),
(8, 'sandeep', 'kundu', '1500322000', 1, 5, '1254895786231', '8789548', '5485452', 'sandeep.kundu@webnyxa.com', '$2y$10$Uf5s8iWYQQymHH4ZoAjleeGsB5wX.RHYLZa3OFjoAOQpBLwmMXg/.', 2, 2, '15130.jpg', 'test', 0.00, 1, '2016-07-29 18:55:54', '2016-08-08 15:16:53', 'rdCjjaRxHTNdhG38i4Rzy9AjUyntraBaDOkLfW3Y', NULL),
(10, 'Kurt', 'Frank', '1500326907', 1, 6, '720-365-0430', '123456', 'Remax', 'kfrank@digitalassetsinc.com', '$2y$10$HGUDNdNuwgkW9fQKu.7Jp.umGMXTS4z.WX/56VHBNfXLzI8C45.mi', 2, 2, '', 'my test bio \r\n', 0.00, 1, '2016-08-01 10:04:14', '2016-08-01 10:22:49', 'Eoi1JREb5fj89CA3s5MnmbYkvzsPwXBTV6DGvovDuwytXAkR9dhjhFKV48P6', NULL),
(11, 'Deepak', 'Panwar', '1500327266', 1, 35, '12121212', 'B12', 'New', 'deepak.panwar@webnyxa.com', '$2y$10$IbTlhwUO8zpYwDwpjnIes.441.uS4KADNiE.7WQB7QWwwUamlW8q2', 2, 1, '56790.jpg', 'Posting Agent', 0.00, 1, '2016-08-01 12:39:24', '2016-08-08 09:51:57', '0XIXAHCNbPAzfHh4f9qyGEeXWK0d6o1AhssJ8oFRp0rbnlOfd9FBPDujWoDT', NULL),
(12, 'Mark', 'Rozer', '1500327340', 1, 20, '(323)232-3123', 'BMZ', 'New 2', 'mark_rozer@rediffmail.com', '$2y$10$Mv5ZjC3Ogmiipm3hv.HFaOQbY5gPBISSbOKh.efT.PlhI3XsmHViW', 2, 2, '33879.jpg', '', 0.00, 1, '2016-08-01 13:58:17', '2016-11-10 07:28:00', '6KEN54TxNhKIVGugb2NmhkEiupyATZ0cPq6xjfrJaeDjJLezvSy9VtH1ZJYu', 'PtdkMTW9w0h679cTO8CIJEev2AgFIRvvnXlFHU5T9QecZ11ESyQzDercjFybmark_rozer@rediffmail.com'),
(13, 'Deepak', 'Yahoo', '1500327386', 1, 5, '(234)234-234_', 'BDY', 'New 3', 'deepakpanwar15@yahoo.com', '$2y$10$7vwBzLkYsPVAd0pQAKbjmuKReuv6xYuQD32ZlKAqcvZ3a1EdFCwLS', 2, 3, '', '', 0.00, 1, '2016-08-01 15:21:46', '2017-01-04 05:04:40', 'd4SDObkVDcK9s3i1pJpSr7o4nFwtuABFaQJ8Nu0wbbHOtnzBXHDQvO6TtR39', 'kQigVxyx9ibAxrcxnUOPWO1F2KV25JO0fV8x90sf0HLwrvpmc8al9OwR1T6bdeepakpanwar15@yahoo.com'),
(14, 'Yogesh', 'Yadav', '1500337953', 1, 5, '(234)234-3243', '1234656', '123456', 'yogesh.yadav@webnyxa.com', '$2y$10$5yKwyVdzuqBBWUnjZRhu0OXVKAKWcwSxm6y3Fs2BwiegU2fMvMtB.', 1, 1, '67215.jpeg', 'Hello', 0.00, 1, '2016-08-03 10:19:36', '2017-01-11 22:48:36', 'fn0VY6GXXaEPa6UfHIDPnRmK5gjK402DXmYbNsHMxt7HRtZLy0fr8EjCBsnD', NULL),
(15, 'Mohd', 'Nadeem', '1500339005', 1, 6, '8010115413', '12356', '125', 'mohd.nadeem@webnyxa.com', '$2y$10$8iOVLOJTbtQRxcLFtwMfx./aIdva3/UbYyya4KN3I/a665FjkI2jq', 2, 2, '43768.jpeg', 'Hello this is Nadeem', 0.00, 1, '2016-08-03 15:54:55', '2017-01-04 06:20:40', 'Jj8IPZ6vpSQ4yMCZqjfI9Im0tVQFOGo2DfqEZbOqIo0Og3PHuiO1mUB3vo0Z', NULL),
(17, 'styogeshTest', 'Test', '''''', 1, 6, '9450747013', 'New web', '1234', 'ajeet.tiwari@webnyxa.com', '$2y$10$QLpUW0PF3ad/PhjbPhKjVuJ5/s/qp8UEGuBLPeOU2MTxki6apzDsW', 2, 0, NULL, NULL, 0.00, 0, '2016-10-25 07:50:47', '2016-10-25 07:56:23', 'fXdovzATyYVZZHdjRTPHcuybWAowBLu9z3qi5ZqPNRHkzKdBBK1Xe8EkB4ng', 'L6TdLwifQkdZHMh8X4zG3bgSh0i7OoX6mLAEjFNpLA9tEwhZOuzaDesiDMTEajeet.tiwari@webnyxa.com'),
(18, '3453534', '5345345', '''''', 1, 6, '(353)453-4534', 'eewerwe', 'rwerwerw', 'sdfsd@rer.com', '$2y$10$/4Agy.kXiMePlwpyOGhGjOmWNfTMAiIHZwepcwQlc4ehxodETgTFW', 2, 0, NULL, NULL, 0.00, 0, '2016-10-28 02:25:24', '2016-10-28 02:25:24', '4KBLRy8MBJLhJQ40sQLvgZMrPHgib9QQogqxMPKX', 'PlGb23tequ5EDdKSFGXMgZO2ojb4GLBZ66Rh6KHI3hJAy3cRMrkj8FfUOlNKsdfsd@rer.com'),
(19, 'rwerwe', '3423', '''''', 1, 6, '(234)234-2342', '32423423', 'sdfsd', 'sdfsd@sdsdas.com', '$2y$10$zejXyUESc5ectt5Y6WGfkOMuZbXzBzbE0m3h1ILdtWStRVHJETSEW', 2, 0, NULL, NULL, 0.00, 0, '2016-10-28 05:07:05', '2016-10-28 05:07:05', '4KBLRy8MBJLhJQ40sQLvgZMrPHgib9QQogqxMPKX', 'iDTUuRPN30OlUte6nuJUqTHxzz8IdKkMv8088apCoeHXcDlLnUQmdyKTI49Wsdfsd@sdsdas.com'),
(20, 'fsdf', 'dsf', '''''', 1, 6, '(223)434-2343', 'qweqweqwe', 'sdfcdf', 'sdfsd@df.com', '$2y$10$BWkP9n3uWb4Wl26hsVsV5.Cw.YLyMjrxd9TObfqmFY4hMtM3.swey', 2, 0, NULL, NULL, 0.00, 0, '2016-10-28 05:27:40', '2016-10-28 05:27:40', '4KBLRy8MBJLhJQ40sQLvgZMrPHgib9QQogqxMPKX', 'fVIHnjmiVU1XthZbhSTpKKsS7snwsTvFsUErcczVCmjkAWn9Kukj3FJ0cyhBsdfsd@df.com'),
(21, 'rewrwe23w', 'erwe', '''''', 1, 6, '(232)33_-____', 'erwer', 'erwe', 'erew@ss.com', '$2y$10$L4PPbl0swsVech9jBNGQ9.Qedtw5C3LQYSh/1Q3P5dn8fEMnqnw7e', 2, 0, NULL, NULL, 0.00, 0, '2016-10-28 05:33:43', '2016-10-28 05:33:43', '4KBLRy8MBJLhJQ40sQLvgZMrPHgib9QQogqxMPKX', '08Matj3yq9XE1lWxjk6UFVKbDDyQtbZmDoNZYvdlT3znfzTQjZ1222FTjIhderew@ss.com');

-- --------------------------------------------------------

--
-- Table structure for table `user_feedback_rating`
--

CREATE TABLE IF NOT EXISTS `user_feedback_rating` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT 'showing agent id',
  `showing_id` int(11) unsigned NOT NULL,
  `showing_user_id` int(11) unsigned NOT NULL,
  `client_show_up` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0=no, 1=yes',
  `client_submit_offer` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0=no, 1=yes, 2=maybe',
  `client_question` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0=no, 1=yes',
  `feedback_comment` text NOT NULL,
  `rating_point` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'rating can be from 1 to 5',
  `rating_comment` text NOT NULL,
  `block_comment` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=46 ;

--
-- Dumping data for table `user_feedback_rating`
--

INSERT INTO `user_feedback_rating` (`id`, `user_id`, `showing_id`, `showing_user_id`, `client_show_up`, `client_submit_offer`, `client_question`, `feedback_comment`, `rating_point`, `rating_comment`, `block_comment`) VALUES
(2, 13, 43, 8, 0, 1, 1, 'test', 1, '', ''),
(3, 14, 47, 15, 1, 1, 1, 'test', 2, 'sssssss', 'testset'),
(24, 14, 49, 15, 1, 1, 1, 'Hello', 1, '', ''),
(25, 14, 53, 15, 1, 0, 1, 'Hello  This is new test', 0, 'Hello anshu how are you', ''),
(26, 14, 58, 13, 1, 1, 0, 'Hello Jetali ji namaskar', 1, '', ''),
(27, 14, 56, 15, 1, 1, 1, 'Hello this is test please complete', 4, 'final complete ..\n', 'Heell'),
(35, 14, 56, 15, 1, 1, 1, 'Hello this is test', 4, 'final complete ..\n', 'Heell'),
(36, 14, 56, 15, 1, 1, 1, 'Hello this is new test', 4, 'final complete ..\n', 'Heell'),
(37, 14, 56, 15, 1, 1, 1, 'Hello this is new test...', 4, 'final complete ..\n', 'Heell'),
(38, 14, 56, 15, 1, 1, 1, 'retert', 4, 'final complete ..\n', 'Heell'),
(39, 14, 54, 15, 1, 1, 1, 'Hello yogesh .this is test......', 4, 'Done ', 'not  done '),
(40, 14, 73, 15, 1, 1, 1, 'Hello Rajnath are yoy kidding  ??????????????', 4, 'Hello Rajnath  now done your task.', 'Rajnath not kidding .....'),
(41, 13, 74, 15, 1, 1, 1, 'Hello Kiran now your showing are completed......', 4, 'Hi now kiran is passed...', 'Kiran rjected...'),
(42, 14, 75, 13, 1, 1, 1, 'Hello Gulam ali.....', 4, 'Hello Gulam Ali what are you doing......', 'gulam ali cheater...'),
(45, 14, 56, 15, 1, 1, 1, 'Hello this is test ...', 4, 'final complete ..\n', 'Heell');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
