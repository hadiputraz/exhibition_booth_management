# Exhibition Booth Management System

## Overview

The Exhibition Booth Management System is a Flutter-based mobile application developed for managing exhibitions, booth reservations, exhibitor applications, and event administration.

The system supports four user roles:

* Guest
* Exhibitor
* Organizer
* Administrator

Each role is provided with specific functions to streamline exhibition management and booth booking processes.

---

## Features

### Guest

* Browse published exhibitions
* Search exhibition information

### Exhibitor

* Browse exhibitions
* View booth availability
* Select exhibition booths
* Submit booth applications
* Edit applications
* Monitor application status

### Organizer

* Create exhibitions
* Edit exhibitions
* Manage booths
* Review exhibitor applications
* Approve or reject applications

### Administrator

* Manage users
* Manage exhibitions
* Manage reservations
* Manage booths
* Manage floor plans

---

## Technologies Used

* Flutter
* Dart
* Firebase Authentication
* Cloud Firestore
* Android Studio
* GitHub

---

## Project Structure

```text
lib/
├── models/
├── services/
├── screens/
│   ├── admin/
│   ├── auth/
│   ├── exhibitor/
│   ├── guest/
│   └── organizer/
└── main.dart
```

## System Modules

### Authentication Module

* Login
* Registration
* Role-Based Access Control

### Exhibition Management Module

* Create Exhibition
* Edit Exhibition
* Publish Exhibition

### Booth Management Module

* Add Booth
* Update Booth
* Monitor Booth Availability

### Application Management Module

* Submit Application
* Approve Application
* Reject Application
* Cancel Application

### Administrative Module

* User Management
* Reservation Management
* Exhibition Management

---
