/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `message_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `message_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `message_users_message_id_foreign` (`message_id`),
  KEY `message_users_user_id_foreign` (`user_id`),
  CONSTRAINT `message_users_message_id_foreign` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `message_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` bigint unsigned DEFAULT NULL,
  `room_id` bigint unsigned DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `messages_sender_id_foreign` (`sender_id`),
  KEY `messages_room_id_foreign` (`room_id`),
  CONSTRAINT `messages_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `room_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `room_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `room_users_room_id_foreign` (`room_id`),
  KEY `room_users_user_id_foreign` (`user_id`),
  CONSTRAINT `room_users_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `room_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `rooms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rooms_created_by_foreign` (`created_by`),
  CONSTRAINT `rooms_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;











INSERT INTO `message_users` (`id`, `message_id`, `user_id`, `is_read`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27');
INSERT INTO `message_users` (`id`, `message_id`, `user_id`, `is_read`, `created_at`, `updated_at`) VALUES
(2, 1, 3, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27');
INSERT INTO `message_users` (`id`, `message_id`, `user_id`, `is_read`, `created_at`, `updated_at`) VALUES
(3, 1, 4, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27');
INSERT INTO `message_users` (`id`, `message_id`, `user_id`, `is_read`, `created_at`, `updated_at`) VALUES
(4, 2, 1, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(5, 2, 3, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(6, 2, 4, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(7, 3, 1, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(8, 3, 2, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(9, 3, 4, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(10, 4, 1, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(11, 4, 2, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(12, 4, 3, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(13, 5, 2, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(14, 5, 3, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(15, 5, 4, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(16, 6, 1, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(17, 6, 3, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(18, 6, 4, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(19, 7, 1, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(20, 7, 2, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(21, 7, 4, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(22, 8, 1, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(23, 8, 2, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(24, 8, 3, 0, '2024-06-04 11:01:27', '2024-06-04 11:01:27');

INSERT INTO `messages` (`id`, `sender_id`, `room_id`, `text`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'test message 1', '2024-06-04 11:01:27', '2024-06-04 11:01:27');
INSERT INTO `messages` (`id`, `sender_id`, `room_id`, `text`, `created_at`, `updated_at`) VALUES
(2, 1, 2, 'test message 2', '2024-06-04 11:01:27', '2024-06-04 11:01:27');
INSERT INTO `messages` (`id`, `sender_id`, `room_id`, `text`, `created_at`, `updated_at`) VALUES
(3, 2, 1, 'test message 3', '2024-06-04 11:01:27', '2024-06-04 11:01:27');
INSERT INTO `messages` (`id`, `sender_id`, `room_id`, `text`, `created_at`, `updated_at`) VALUES
(4, 2, 2, 'test message 4', '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(5, 3, 1, 'test message 5', '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(6, 3, 2, 'test message 6', '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(7, 4, 1, 'test message 7', '2024-06-04 11:01:27', '2024-06-04 11:01:27'),
(8, 4, 2, 'test message 8', '2024-06-04 11:01:27', '2024-06-04 11:01:27');

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(130, '0001_01_01_000000_create_users_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(131, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(132, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(133, '2024_06_03_092333_create_rooms_table', 1),
(134, '2024_06_03_094619_create_messages_table', 1),
(135, '2024_06_03_094648_create_room_users_table', 1),
(136, '2024_06_03_095122_create_message_users_table', 1);



INSERT INTO `room_users` (`id`, `room_id`, `user_id`) VALUES
(1, 1, 1);
INSERT INTO `room_users` (`id`, `room_id`, `user_id`) VALUES
(2, 1, 2);
INSERT INTO `room_users` (`id`, `room_id`, `user_id`) VALUES
(3, 1, 3);
INSERT INTO `room_users` (`id`, `room_id`, `user_id`) VALUES
(4, 1, 4),
(5, 2, 1),
(6, 2, 2),
(7, 2, 3),
(8, 2, 4),
(9, 3, 3),
(10, 4, 4);

INSERT INTO `rooms` (`id`, `name`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'chat room 1', 1, '2024-06-04 11:01:27', '2024-06-04 11:01:27');
INSERT INTO `rooms` (`id`, `name`, `created_by`, `created_at`, `updated_at`) VALUES
(2, 'chat room 2', 2, '2024-06-04 11:01:27', '2024-06-04 11:01:27');
INSERT INTO `rooms` (`id`, `name`, `created_by`, `created_at`, `updated_at`) VALUES
(3, 'chat room 3', 3, '2024-06-04 11:01:27', '2024-06-04 11:01:27');
INSERT INTO `rooms` (`id`, `name`, `created_by`, `created_at`, `updated_at`) VALUES
(4, 'chat room 4', 4, '2024-06-04 11:01:27', '2024-06-04 11:01:27');



INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'a', 'a@a.a', NULL, '$2y$12$Vo8fyF/YlJUjLBudFy.Hb.XCRpNyZ7RbewljT/ZvfpZx3ToknlLKK', NULL, '2024-06-04 11:01:26', '2024-06-04 11:01:26');
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(2, 'b', 'b@b.b', NULL, '$2y$12$LXixRs8lXNDqT2hkLs9JZuF9JLKzs3wWE/mKvQ70GfzzK2Ic0qiqq', NULL, '2024-06-04 11:01:26', '2024-06-04 11:01:26');
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(3, 'c', 'c@c.c', NULL, '$2y$12$9/aZBjsGfccfAVEwrT6qAexkUzI6xxm7zDVuxjyGKT3hyJvWwEXRy', NULL, '2024-06-04 11:01:27', '2024-06-04 11:01:27');
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(4, 'd', 'd@d.d', NULL, '$2y$12$v07KysDD8KYTw2ZfNL581el.ykKf5iE5IMb.vrzCsT85GonT0Smyq', NULL, '2024-06-04 11:01:27', '2024-06-04 11:01:27');


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;