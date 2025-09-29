# Ramadan Todak App 🌙

A Flutter-based multi-screen app for Ramadan, featuring user authentication, prayer times, and Quran reading modules.

---

## Test Account

Use this account to test the app immediately:

* **Email:** [abu1@gmail.com]
* **Password:** abu123

---

## How to Run

1. **Clone the repository**

   ```bash
   git clone https://github.com/nazarulazham/flutterRamadan
   ```
2. **Navigate into the project folder**

   ```bash
   cd ramadan_companion
   ```
3. **Install dependencies**

   ```bash
   flutter pub get
   ```
4. **Run the app**

   ```bash
   flutter run
   ```
5. **Build Android APK**

   ```bash
   flutter build apk --release
   ```

   APK will be available at:

   ```
   build/app/outputs/flutter-apk/app-release.apk
   ```

---

## App Structure

* **main.dart**
  Initializes Firebase, sets up Provider for authentication state, and loads the correct screen.

* **screens/**

  * `login_screen.dart` → Login with Firebase Authentication
  * `register_screen.dart` → User registration
  * `home_screen.dart` → Home with gold-themed feature cards (Prayer Times, Quran, Qibla Finder, Ramadan Tips, Donation)
  * `prayer_times_screen.dart` → Fetches and displays prayer times from Aladhan API
  * `quran/` → Fetches Surah list and displays Surah details using Quran API

* **services/**

  * `auth_service.dart` → Handles Firebase Authentication (login, register, logout, user stream)
  * `api_service.dart` → Handles API calls (Prayer Times, Quran)

* **widgets/** (optional)
  Reusable UI components like cards, headers, etc.

---

## Features

* **Firebase Authentication** (Register/Login/Logout)
* **Provider** for state management and auth stream handling
* **Prayer Times** module fetching data from Aladhan API
* **Quran Module** to read Surah list and details from API
* **Gold/Beige Theme** for cohesive UI
* **Logout Confirmation Dialog** to prevent accidental sign-out
* **Feature Cards** on HomeScreen with "Coming Soon" banners for future modules

---

## Firebase Setup

* Firebase project is connected for **Authentication**.
* Reviewer has been added as **Viewer** for project inspection.
* Ensure `google-services.json` or web Firebase config is included if running from source.

---

## Notes

* The home screen shows a **personalized welcome message** using the logged-in user's display name.
* Clicking **Prayer Times** opens the API-based prayer schedule.
* Clicking **Quran** opens the list of Surahs; selecting one shows the verses.
* Other feature cards are marked "Coming Soon" except **Donation**, which can be further implemented.

---

## Contact

For any issues or questions, please reach out via your GitHub repo issues.
