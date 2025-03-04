-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 08, 2023 at 01:28 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `opensb`
--

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE `bans` (
  `autoint` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `reason` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `channel_comments`
--

CREATE TABLE `channel_comments` (
  `comment_id` int(11) NOT NULL,
  `id` text NOT NULL,
  `reply_to` bigint(20) NOT NULL DEFAULT 0,
  `comment` text NOT NULL,
  `author` bigint(20) NOT NULL,
  `date` bigint(20) NOT NULL,
  `deleted` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` bigint(20) NOT NULL,
  `id` text NOT NULL COMMENT 'ID to video or user.',
  `reply_to` bigint(20) NOT NULL DEFAULT 0,
  `comment` text NOT NULL COMMENT 'The comment itself, formatted in Markdown.',
  `author` bigint(20) NOT NULL COMMENT 'Numerical ID of comment author.',
  `date` bigint(20) NOT NULL COMMENT 'UNIX timestamp when the comment was posted.',
  `deleted` tinyint(4) NOT NULL COMMENT 'States that the comment is deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `user_id` int(11) NOT NULL,
  `video_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ipbans`
--

CREATE TABLE `ipbans` (
  `ip` varchar(45) NOT NULL DEFAULT '0.0.0.0',
  `reason` varchar(255) NOT NULL DEFAULT '<em>No reason specified</em>'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `music`
--

CREATE TABLE `music` (
  `ID` int(11) NOT NULL,
  `music_id` varchar(11) NOT NULL,
  `title` text NOT NULL,
  `author` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `file` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `title` varchar(128) NOT NULL DEFAULT 'Lorem ipsum',
  `text` text DEFAULT NULL,
  `time` bigint(20) DEFAULT 0,
  `redirect` varchar(256) DEFAULT NULL,
  `author_userid` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `level` int(11) DEFAULT NULL,
  `recipient` int(11) NOT NULL,
  `sender` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `passwordresets`
--

CREATE TABLE `passwordresets` (
  `id` varchar(64) NOT NULL,
  `user` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `user` bigint(20) UNSIGNED NOT NULL COMMENT 'User that does the rating.',
  `video` bigint(20) UNSIGNED NOT NULL COMMENT 'Video that is being rated.',
  `rating` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1 for like, 0 for dislike.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `revisions`
--

CREATE TABLE `revisions` (
  `id` int(11) NOT NULL,
  `page` text NOT NULL,
  `revision` int(11) NOT NULL DEFAULT 1,
  `size` int(11) NOT NULL DEFAULT 0,
  `sizediff` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT current_timestamp(),
  `description` text NOT NULL DEFAULT 'No description',
  `author` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(11) NOT NULL COMMENT 'ID of the user that wants to subscribe to a user.',
  `user` int(11) NOT NULL COMMENT 'The user that the user wants to subscribe to.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tag_index`
--

CREATE TABLE `tag_index` (
  `video_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tag_meta`
--

CREATE TABLE `tag_meta` (
  `tag_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `latestUse` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL COMMENT 'Incrementing ID for internal purposes.',
  `name` varchar(128) NOT NULL COMMENT 'Username, chosen by the user',
  `email` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL COMMENT 'Password, hashed in bcrypt.',
  `token` varchar(128) NOT NULL COMMENT 'User token for cookie authentication.',
  `joined` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'User''s join date',
  `lastview` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Timestamp of last view',
  `lastpost` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `title` text NOT NULL COMMENT 'Display Name',
  `about` text DEFAULT NULL COMMENT 'User''s description',
  `customcolor` varchar(7) DEFAULT '#523bb8' COMMENT 'The color that the user has set for their profile',
  `language` varchar(10) NOT NULL DEFAULT 'en-US' COMMENT 'Language (Defaults to English)',
  `avatar` tinyint(1) NOT NULL DEFAULT 0,
  `ip` varchar(32) NOT NULL DEFAULT '999.999.999.999',
  `u_flags` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '8 bools to determine certain user properties',
  `powerlevel` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0 - banned. 1 - normal user. 2 - moderator. 3 - administrator',
  `group_id` int(11) NOT NULL DEFAULT 3
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE `videos` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Incrementing ID for internal purposes.',
  `video_id` varchar(11) NOT NULL COMMENT 'Random alphanumeric video ID which will be visible.',
  `title` varchar(128) NOT NULL COMMENT 'Video title',
  `description` text DEFAULT NULL COMMENT 'Video description',
  `author` bigint(20) UNSIGNED NOT NULL COMMENT 'User ID of the video author',
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Unix timestamp for the time the video was uploaded',
  `most_recent_view` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `views` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Video views',
  `flags` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '8 bools to determine certain video properties',
  `category_id` int(11) DEFAULT 0 COMMENT 'Category ID for the video',
  `videofile` text DEFAULT NULL COMMENT 'Path to the video file(?)',
  `videolength` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Length of the video in seconds',
  `tags` text DEFAULT NULL COMMENT 'Video tags, serialized in JSON',
  `post_type` int(11) NOT NULL DEFAULT 0 COMMENT 'The type of the post, 0 is a video, 1 is a legacy video, 2 is art, and 3 is music.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `views`
--

CREATE TABLE `views` (
  `video_id` text NOT NULL,
  `user` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`autoint`);

--
-- Indexes for table `channel_comments`
--
ALTER TABLE `channel_comments`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indexes for table `music`
--
ALTER TABLE `music`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `revisions`
--
ALTER TABLE `revisions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bans`
--
ALTER TABLE `bans`
  MODIFY `autoint` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `channel_comments`
--
ALTER TABLE `channel_comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `music`
--
ALTER TABLE `music`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `revisions`
--
ALTER TABLE `revisions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Incrementing ID for internal purposes.';

--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Incrementing ID for internal purposes.';
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
