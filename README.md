# road_signs_tz

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

-Road Signs & Driving Q&A Flutter Offline App
Project Documentation: Road Signs TZ

📌 Overview
Road Signs TZ is a simple and educational mobile app developed using Flutter. The goal of the app is to help users in Tanzania (or learners of Tanzanian driving rules) to:
•Learn 200+ road signs and their meanings.
•Practice with Q&A related to driving.
•Mark and save favorite signs/questions.
•Toggle between light/dark themes.
•Use the app completely offline.
•View a motivational splash screen on startup.

Features
✅ Splash Screen
•Displays app logo and a welcome message.
•Has a Start Learning button.
•Controlled by SplashScreen widget in splash/splash_screen.dart.

✅ Home Page

•Two main options:
oRoad Signs
oDriving Q&A
•Access to settings (theme, share, favorites, update, about).
•Located in main.dart under HomePage.

✅ Road Signs Tabbed Interface
•Tabs:
oAll Signs
oFavorites
•Signs are loaded from a local JSON file.
•Each sign has:
oImage
oDescription
oFavorite toggle
•Implemented in tabs/road_signs_tabs_screen.dart.

✅ Driving Q&A
•Similar tabbed layout (All Q&A, Favorites).
•Loaded from local JSON.
•Implemented in screens/qa_screen.dart.

✅ Settings Menu (Modal Sheet)

•Theme switch (System / Light / Dark)
•Share app via Share Plus
•Navigate to:
oFavorites
oCheck for updates
oAbout screen

✅ Favorites
•Allows users to view saved favorite signs or Q&A.
•Favorites are stored locally via SharedPreferences.
•Managed by FavoritesService.

✅ Theme Support
•Light, Dark, and System mode.
•Managed via ThemeService.

✅ Persistent Data
• Theme and favorites are persisted using SharedPreferences.
