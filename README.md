# PostWizard Frontend

Welcome to the frontend repository for **PostWizard**, an AI-powered social media automation app. This app simplifies the process of generating and posting optimized captions on various social media platforms by utilizing AI. 

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

**PostWizard** is designed to help users automate their social media management by generating SEO-optimized captions based on user-uploaded images and descriptions. This repository contains the frontend code, which provides an intuitive user interface for interacting with the backend services, allowing users to upload images, manage their accounts, and automate their social media posts.

## Features

- **User-Friendly Interface:** Built with Flutter, providing a seamless experience across mobile devices.
- **User Authentication:** Secure login, registration, and password recovery flows.
- **Image Upload:** Simple image upload with the option to add descriptions for AI-powered caption generation.
- **Automated Posting:** Users can automate their social media posts across various platforms with a single click.
- **Responsive Design:** Optimized for mobile devices with a responsive UI.

## Tech Stack

- **Frontend Framework:** Flutter
- **State Management:** Provider
- **Networking:** HTTP Client (for communication with the backend API)
- **UI Components:** Material Design for a consistent and modern look

## Screenshots

Here are some screenshots of the app in action:

- **Home Screen:**

  <img src="https://github.com/polymorphisma/postWizard-frontend/blob/main/images/Screenshot_20240830_080553.png" width="128"/>

- **Login Screen:**
  
  <img src="https://github.com/polymorphisma/postWizard-frontend/blob/main/images/Screenshot_20240830_080356.png" width="128"/>

- **Register Screen:**
  
  <img src="https://github.com/polymorphisma/postWizard-frontend/blob/main/images/Screenshot_20240830_080309.png" width="128"/>

- **Upload Screen:**
  
  <img src="https://github.com/polymorphisma/postWizard-frontend/blob/main/images/Screenshot_20240830_080603.png" width="128"/>
  <img src="https://github.com/polymorphisma/postWizard-frontend/blob/main/images/Screenshot_20240830_080634.png" width="128"/>

- **Forgot Password Screen:**
  
  <img src="https://github.com/polymorphisma/postWizard-frontend/blob/main/images/Screenshot_20240830_080328.png" width="128"/>


- **Result:**
  
  <img src="https://github.com/polymorphisma/postWizard-frontend/blob/main/images/Screenshot 2024-08-30 080742.png" width="128"/>


## Installation

### Prerequisites

- Flutter SDK installed on your machine
- Android Studio or Xcode for mobile development
- A backend API to connect with (refer to the [PostWizard Backend Repository](https://github.com/polymorphisma/postWizard-backend) for details)

### Clone the Repository

```bash
git clone https://github.com/polymorphisma/postWizard-frontend.git
cd postWizard-frontend
```

### Install Dependencies

```bash
flutter pub get
```

### Run the app

- To run the app on your device or emulator:
```bash
flutter run
```

## Usage

### User Authentication

- **Login:** Users can log in using their email and password. 
- **Registration:** New users can create an account by providing necessary details.
- **Password Recovery:** Users can reset their password via email if they forget it.

### Image Upload and Caption Generation

- **Upload Image:** Users can upload an image from their device and optionally add a description.
- **AI-Generated Captions:** The app communicates with the backend to generate and display AI-powered captions for different social media platforms.
- **Automated Posting:** With a single click, users can post the generated content across their connected social media accounts.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an issue for any bugs or feature requests.

### Steps to Contribute

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a Pull Request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
