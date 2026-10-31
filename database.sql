-- ============================================================
-- Gym Management System - database script
-- Import this file in phpMyAdmin (Import tab)
-- ============================================================
CREATE DATABASE IF NOT EXISTS gym_db
  CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE gym_db;

-- 1. users : administrator accounts
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,          -- stores password_hash() output
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. plans : membership plans
CREATE TABLE IF NOT EXISTS plans (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  plan_name VARCHAR(100) NOT NULL,
  duration_months INT NOT NULL,
  fees DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 3. trainers
CREATE TABLE IF NOT EXISTS trainers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  mobile VARCHAR(15) NOT NULL,
  specialization VARCHAR(100),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 4. members
CREATE TABLE IF NOT EXISTS members (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  mobile VARCHAR(15) NOT NULL,
  email VARCHAR(100),
  join_date DATE NOT NULL,
  plan_id INT NOT NULL,
  trainer_id INT NULL,
  FOREIGN KEY (user_id)    REFERENCES users(id)    ON DELETE CASCADE,
  FOREIGN KEY (plan_id)    REFERENCES plans(id)    ON DELETE RESTRICT,
  FOREIGN KEY (trainer_id) REFERENCES trainers(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- 5. attendance : one record per member per date
CREATE TABLE IF NOT EXISTS attendance (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  member_id INT NOT NULL,
  attendance_date DATE NOT NULL,
  status ENUM('Present','Absent') NOT NULL,
  UNIQUE KEY uniq_member_date (member_id, attendance_date),
  FOREIGN KEY (user_id)   REFERENCES users(id)   ON DELETE CASCADE,
  FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 6. payments : fee tracking
CREATE TABLE IF NOT EXISTS payments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  member_id INT NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  paid_on DATE NOT NULL,
  status ENUM('Paid','Pending') NOT NULL,
  FOREIGN KEY (user_id)   REFERENCES users(id)   ON DELETE CASCADE,
  FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE
) ENGINE=InnoDB;
