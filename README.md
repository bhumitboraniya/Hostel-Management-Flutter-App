# Hotel Manager App

# Images:
<img src="https://github.com/user-attachments/assets/44089a94-3b6e-4cd6-b7ae-a516449230dc" alt="Image 1" width="100" height="200">

<img src="https://github.com/user-attachments/assets/8eb687dc-a4fd-42d9-b12f-81e343b8898e" alt="Image 2" width="100" height="200">

<img src="https://github.com/user-attachments/assets/f819a210-591e-4c11-9912-81d60e4d6b5e" alt="Image 3" width="100" height="200">

<img src="https://github.com/user-attachments/assets/561a54b0-9170-4cfe-a179-9a2668354350" alt="Image 4" width="100" height="200">

<img src="https://github.com/user-attachments/assets/61fa6949-949b-4bda-9d7a-6187205c89bb" alt="Image 5" width="100" height="200">


## Overview

The Hotel Manager App is a Flutter-based application designed to manage hotel operations efficiently. It includes user authentication, a splash screen, and integration with MongoDB for data management.

## Features

- **Splash Screen**: Displays a logo and app name with a gradient background.
- **Login Screen**: Allows users to log in with email and password.
- **MongoDB Integration**: Connects to MongoDB for user data management.
- **State Management**: Manages application state and data flow efficiently.

## Installation

**Clone the repository:**
```
git clone https://github.com/yourusername/hotel_manager.git
```

## Navigate to the project directory:


```
cd hotel_manager

```

## Install dependencies:

```
flutter pub get

```
## Set up MongoDB:

Update the constant.dart file with your MongoDB connection details (MONGO_URL and COLLECTION_NAME).

## Run the app:
```
flutter run
```
## Configuration
MongoDB Configuration: Ensure you have MongoDB running and replace the placeholders in constant.dart with your MongoDB connection string and collection name.
Assets: Place your assets (e.g., logos) in the assets/images/ directory.


## Directory Structure

lib/
├── mongodb.dart          # MongoDB connection and data handling </br>
├── constant.dart         # Configuration constants</br>
├── main.dart             # Entry point of the application</br>
├── login.dart            # Login screen implementation</br>
├── splash.dart           # Splash screen implementation</br>
└── MongoDBModel.dart     # Data model for MongoDB</br>

## Usage
Splash Screen: The initial screen shown to users with a 2-second delay before navigating to the Login screen.</br>
Login Screen: Users can log in using their email and password. On successful login, they are redirected to the home screen.</br>

## Contributing
Feel free to fork the repository and submit pull requests. For bug reports or feature requests, please create an issue on GitHub.


## Contact
For any questions or feedback, please contact bhumitboraniya@gmail.com
