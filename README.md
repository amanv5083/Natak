# Gym Management System

A PHP + MySQL web application to manage a gym: members, trainers, membership plans, attendance and payments, with an admin dashboard and reports.

## Features
- Admin registration and login (passwords stored with `password_hash()`)
- Members, trainers, plans, attendance and payments modules
- Dashboard and reports
- CSRF protection helper

## Tech Stack
PHP (PDO) · MySQL · HTML/CSS/JavaScript · XAMPP

## Folder Structure
```
gym_management/
├── assets/        css, js, img
├── config/        db.php (database connection)
├── includes/      header, footer, sidebar, auth, csrf, helper functions
├── modules/       members, trainers, plans, payments, attendance
├── database.sql   database + tables
├── index.php, login.php, register.php, logout.php
├── dashboard.php, reports.php
```

## Setup (XAMPP)
1. Install XAMPP and start **Apache** and **MySQL**.
2. Copy this folder to `C:\xampp\htdocs\gym_management`.
3. Open `http://localhost/phpmyadmin` → **Import** → choose `database.sql` (creates the `gym_db` database).
4. Check the credentials in `config/db.php` (default XAMPP: user `root`, empty password).
5. Open `http://localhost/gym_management/` in the browser.

## Author
Aman Choudhary — B.Sc. Computer Science mini project
