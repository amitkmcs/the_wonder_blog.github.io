-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2021 at 12:45 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `the_wonder_blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(50) NOT NULL,
  `Name` text NOT NULL,
  `Email` varchar(50) NOT NULL,
  `P_no` varchar(50) NOT NULL,
  `Msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `Name`, `Email`, `P_no`, `Msg`, `date`) VALUES
(1, 'Amit Kumar', 'amitkmcs007@gmail.com', '7754885561', 'testing again', '2021-04-28 16:29:47'),
(26, 'Amit Kumar', 'amitkmcs007@gmail.com', '7754885561', 'sc', '2021-04-28 18:52:14'),
(27, 'test3', 'test3@gmail.com', '7055482155', 'testing\r\n', '2021-04-29 13:01:21'),
(28, 'Amit Kumar', 'amitkmcs007@gmail.com', '7754885561', 'new', '2021-05-01 16:23:28'),
(29, 'Amit Kumar', 'amitkmcs007@gmail.com', '7754885561', 'nj', '2021-05-02 11:26:19');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `sub_heading` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `post_by` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `img_file` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `sub_heading`, `slug`, `content`, `post_by`, `date`, `img_file`) VALUES
(1, 'Send an E-mail with Python Flask', 'Web-based applications typically require the ability to send mail to the user/client.', 'first-post', 'Introduction\r\nFirst, the Flask-Mail extension should be installed with the help of the pip utility.\r\n\r\npip install Flask-Mail\r\nYou then need to configure the Flask-Mail by setting the values for the following application parameters.\r\n\r\nMAIL_SERVER\r\nMAIL_USE_TLS\r\nMAIL_USE_SSL\r\nMAIL_DEBUG\r\nMAIL_USERNAME\r\nMAIL_PASSWORD\r\nMAIL_DEFAULT_SENDER\r\nMAIL_MAX_EMAILS\r\nMAIL_SUPPRESS_SEND\r\nMAIL_ASCII_ATTACHMENTS\r\nThe flask-mail module contains definitions of the following important classes.\r\n\r\nThe Mail class manages email messaging requirements.The class constructor takes the form of:\r\n\r\nflask-mail.Mail(app = None)\r\nMail class methods include: send(), connect() and send_message().\r\n\r\nThe Message class encapsulated an email.The Message class constructor has several parameters:\r\n\r\nflask-mail.Message(subject, recipients, body, html, sender, cc, bcc, \r\n   reply-to, date, charset, extra_headers, mail_options, rcpt_options)\r\nMessage class method attach () - Add attachment for mail.This method takes the following parameters:\r\n\r\nfilename : The name of the file\r\ncontent_type : MIME type\r\ndata - file data\r\nYou can use add_recipient() to add another recipient to the message.\r\n\r\nMail config and functions\r\nIn the example below, the SMTP server for the Google gmail service is used as the MAIL_SERVER for the Flask-Mail configuration.\r\n\r\nStep 1: Import the Mail and Message classes from the flask-mail module in the code.\r\n\r\nfrom flask_mail import Mail, Message\r\nStep 2: Configure server parameters\r\n\r\napp.config[\'MAIL_SERVER\']=\'smtp.gmail.com\'\r\napp.config[\'MAIL_PORT\'] = 465\r\napp.config[\'MAIL_USERNAME\'] = \'yourId@gmail.com\'\r\napp.config[\'MAIL_PASSWORD\'] = \'*****\'\r\napp.config[\'MAIL_USE_TLS\'] = False\r\napp.config[\'MAIL_USE_SSL\'] = True\r\nStep 3: Create an instance of the Mail class.\r\n\r\nmail = Mail(app)\r\nStep 4: The Message object is set in a Python function that is mapped by the URL rule (‘/‘).\r\n\r\n@app.route(\"/\")\r\ndef index():\r\n   msg = Message(\'Hello\', sender = \'yourId@gmail.com\', recipients = [\'someone1@gmail.com\'])\r\n   msg.body = \"This is the email body\"\r\n   mail.send(msg)\r\n   return \"Sent\"', 'Ajeet kumar', '2021-05-03 12:43:13', 'post-sample-image.jpg'),
(2, 'Second Post is this', 'subtitle is testing', 'second_post', 'post content here', 'here posted by amit', '2021-04-30 18:01:46', 'post-bg.jpg'),
(3, 'Variable', 'Template variables are defined by the context dictionary passed to the template.', 'third-post', 'You can mess around with the variables in templates provided they are passed in by the application. Variables may have attributes or elements on them you can access too. What attributes a variable has depends heavily on the application providing that variable.\r\n\r\n', 'new1', '2021-05-02 11:18:27', 'post-bg.jpg'),
(4, 'Variables', 'Template variables are defined by the context dictionary passed to the template.\r\n', 'fouth-post', 'You can mess around with the variables in templates provided they are passed in by the application. Variables may have attributes or elements on them you can access too. What attributes a variable has depends heavily on the application providing that variable.\r\n\r\n', 'new3', '2021-04-29 15:13:52', 'post-bg.jpg'),
(5, 'Filters', 'Variables can be modified by filters. Filters are separated from the variable by a pipe symbol (|)', 'fifth-post', 'Variables can be modified by filters. Filters are separated from the variable by a pipe symbol (|) and may have optional arguments in parentheses. Multiple filters can be chained. The output of one filter is applied to the next.\r\n\r\nFor example, {{ name|striptags|title }} will remove all HTML Tags from variable name and title-case the output (title(striptags(name))).\r\n\r\nFilters that accept arguments have parentheses around the arguments, just like a function call. For example: {{ listx|join(\', \') }} will join a list with commas (str.join(\', \', listx)).\r\n\r\nThe List of Builtin Filters below describes all the builtin filters', 'new', '2021-05-03 12:45:06', 'post-bg.jpg'),
(14, 'tset', 'fkj', 'nld', 'amit2', 'vld', '2021-05-03 12:42:46', 'lv');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
