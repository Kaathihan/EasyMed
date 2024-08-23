# EasyMed - Medication Reminder App

![post-it-branding (4)](https://github.com/user-attachments/assets/dd4b53d9-f4bd-434c-8e27-7de67a6c6ee0)

## Description
EasyMed is a mobile application designed to assist users in managing their medication schedules. The app addresses common issues such as forgetting to take medication or misunderstanding instructions. By offering features like medication reminders, instructions, and pharmacy connectivity, EasyMed aims to improve medication adherence, especially for individuals with chronic illnesses or complex medication regimens.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Architecture](#architecture)
- [Technologies Used](#technologies-used)
- [Contributors](#contributors)
- [Contributing](#contributing)

## Overview
EasyMed allows users to:
- Scan or manually enter medication information.
- Set up personalized medication schedules.
- Receive reminders and notifications for medication times.
- Connect with local pharmacists for medication review and refills.

## Features
- **Multiple Screens & Navigation**: Intuitive navigation across login, home, search, map, and profile pages.
- **Dialogs & Pickers**: User-friendly interfaces for adding medications.
- **Snackbars & Notifications**: Real-time updates and reminders for medication schedules.
- **Local & Cloud Storage**: Data persistence using SQLite for local storage and Firebase for cloud storage.
- **Geolocation & Geocoding**: Locate nearby pharmacies and display them on an interactive map.
- **Internationalization**: Support for multiple languages on the profile page.

## Installation

### Prerequisites
- Android Studio or a compatible IDE
- Flutter SDK
- Firebase account for backend services

### Steps
1. **Clone the repository:**
   ```bash
   git clone https://github.com/Kaathihan/EasyMed.git
2. **Open the project in Android Studio.**
3. **Configure Firebase:**
      - Add your SHA-1 and SHA-256 keys to the Firebase project settings.
4. **Install dependencies:**
   ```
   flutter pub get
   ```
5. **Run the application:**
   ```
   flutter run
   ```

### Usage
- Login with Google: Add SHA keys to Firebase and log in using your Google account.
- Guest Access: Explore the app's features without logging in, except for the profile page.
- Medication Management: Add medications to your schedule and receive timely reminders.
- Pharmacy Locator: Use the map feature to find nearby pharmacies.

### Architecture
- Frontend: Developed using Flutter for a seamless cross-platform experience.
- Backend: Firebase for authentication, cloud storage, and real-time database.

### Technologies Used
- Languages: Dart
- Framework: Flutter
- Backend: Firebase
- APIs: Google Maps API for geolocation and geocoding

### Contributors
- Fadi Chamas 
- Chanuka Goonetileke 
- Kaathihan Luxmachandran
- Preet Panchal 
- Eihab Syed
  
### Contributing

   1. Contributions are welcome! Please follow these steps:
   2. Fork the repository.
   3. Create a new branch: git checkout -b feature/YourFeature
   4. Commit your changes: git commit -m 'Add some feature'
   5. Push to the branch: git push origin feature/YourFeature
   6. Open a pull request.

      
