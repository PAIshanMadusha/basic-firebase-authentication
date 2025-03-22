# 🔐 Basic Firebase Authentication App

The **Basic Firebase Authentication App** is a Flutter-based authentication system using Firebase Authentication. This app allows users to sign up, sign in, reset passwords, and use third-party authentication providers like Google and GitHub. Additionally, it supports anonymous login.

## 🚀 Features:
- **🛡️ Firebase Authentication Error Handling**: Proper handling of authentication errors with messages for a seamless experience.
- **🎨 Attractive UI Design**: The app features a modern and user-friendly interface for a seamless experience.
- **📝 Sign Up**: Users can create an account by entering their email, password, and confirming their password.
- **🔑 Sign In**: Users can log in using their registered email and password.
- **✅ Email & Password Validation**: Ensures users enter valid email addresses and secure passwords.
- **🔄 Forgot Password**: Users can reset their password by entering their email. A password reset link is sent to their email inbox.
- **👻 Anonymous Sign-In**: Users can log in without an email and password.
- **🌍 Google Sign-In**: Users can authenticate using their Google account.
- **🐙 GitHub Sign-In**: Users can authenticate using their GitHub account.

## 🛠️ Technologies Used:
- Flutter: For building the UI.
- Firebase Authentication: A backend service for authenticating users.
- Dart: For application logic.
- Google Sign-In: Allows users to sign in using their Google accounts.
- GitHub Sign-In: Enables users to log in using their GitHub credentials.

## 📦 Dependencies:
The following dependencies are used in this project:

```yaml
  firebase_core: ^3.12.1
  firebase_auth: ^5.5.1
  google_sign_in: ^6.3.0
  flutter_svg: ^2.0.17
```
## ⚠️ Firebase Authentication Error Codes:
Here are the Firebase authentication error codes and their descriptions handled in the app:

```dart
// Sign In With Email And Password 
case 'wrong-password':
  return 'The password is invalid or the account does not have a password set.';
case 'invalid-email':
  return 'The email address is not valid.';
case 'user-disabled':
  return 'The user corresponding to the given email has been disabled.';
case 'user-not-found':
  return 'No user corresponding to the given email was found.';

// Create User With Email And Password
case 'email-already-in-use':
  return 'An account already exists with the given email address.';
case 'operation-not-allowed':
  return 'Email/password accounts are not enabled. Enable them in the Firebase Console.';
case 'weak-password':
  return 'The password provided is not strong enough.';

// Sign In With Credential
case 'account-exists-with-different-credential':
  return 'An account already exists with the email address provided. Sign in using one of the returned providers.';
case 'invalid-credential':
  return 'The credential is malformed or has expired.';
case 'invalid-verification-code':
  return 'The verification code is not valid.';
case 'invalid-verification-id':
  return 'The verification ID is not valid.';

// Reauthenticate With Credential
case 'user-mismatch':
  return 'The credential given does not correspond to the user.';

// Sign In With Email Link
case 'expired-action-code':
  return 'The OTP in the email link has expired.';

default:
  return 'An unknown error occurred.';
```

## 📥 Installation:
1. Clone the repository:
   ```bash
   https://github.com/PAIshanMadusha/basic-firebase-authentication.git
   ```
2. Navigate to the project directory:
   ```bash
   cd basic-firebase-authentication
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
## ✅ Set up Firebase:
   
### ⚠️ If you are unfamiliar with Firebase connecting:

- 📖I’ve written a detailed [Medium](https://medium.com/@ishanmadusha) article explaining the step-by-step process to connect Firebase to Flutter with screenshots.

- 📖**Read my blog on Medium here:** [Link](https://medium.com/@ishanmadusha/how-to-connect-firebase-manually-to-a-flutter-android-project-without-errors-7a2c2a8e2741)

- 📝**Also, you can view my previous project,** [Taskly Firebase App](https://github.com/PAIshanMadusha/taskly-firebase-app.git) I have written clearly on the README how to set up Firebase.

### 🚀 To use Firebase services in this project, follow these steps:

- Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
- Add Firebase to Your Flutter App: In Firebase Console, select either Android or iOS, depending on your target platform and, Fill the Required details.
- Ensure this If you want to use Google Sign-In, you must generate the SHA-1 key.
- Download the `google-services.json` file (for Android) and `GoogleService-Info.plist` (for iOS) and place them in the appropriate folders.

### 🚀 Enable Authentication Providers in Firebase Console:

- Navigate to Firebase Authentication by opening the Firebase Console, selecting the "Authentication" tab in the left sidebar Build Section, and then going to the "Sign-in method" tab.
  
### 🚀 Enable Specific Sign-In Methods:

- In the Sign-in method section, enable Email/Password and Anonymous under the Native Providers section.
- Enable Google under the Additional Providers section. If you've generated the SHA-1 key and don't want to fill in other details, simply select your email for the project and save.
- To enable GitHub under the Additional Providers section, follow the below instructions:
  
### 🚀 GitHub Authentication Setup:

1. **Access GitHub Developer Settings**:  
   Go to your GitHub profile, select **Settings**, scroll down to **Developer settings**, and then click on **OAuth Apps**.

2. **Register a New OAuth App**:  
   Click on **New OAuth App** and fill in the required details. For the **Authorization Callback URL**, copy the URL from your Firebase console which states:  
   _"To complete setup, add this authorization callback URL to your GitHub app configuration"_. Paste this URL into the form and click **Register App**.

3. **Obtain Credentials**:  
   After registering, you will see the **Client ID**. Copy this and paste it into the required field in your Firebase console. Next, generate the **Client Secret**, copy it, and save it securely as required.
   
### ✅ All setup is complete. Now you can run the app. Make sure there are no errors:
   ```bash
   flutter run
   ```
   
---

## 📸 System Screenshots:

<p align="center">
  <img src="https://github.com/user-attachments/assets/e4fb1224-5093-45a4-885c-a6410e9ac646" alt="Screenshot 1" width="125">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/df400ee9-9dcb-40d2-adc4-9fafe2c12380" alt="Screenshot 2" width="125">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/435b11ef-85d2-4e96-9766-145b65677307" alt="Screenshot 3" width="125">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/7257d5da-1874-4ef7-a4bf-7cf7d6b0db14" alt="Screenshot 3" width="125">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/dba7fc8d-c3f2-45b4-83ff-9f451de2c602" alt="Screenshot 3" width="125">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>

---

### 👨‍💻 Created by: 
**Ishan Madhusha**  
GitHub: [PAIshanMadusha](https://github.com/PAIshanMadusha)

Feel free to explore my work and get in touch if you'd like to collaborate! 🚀

---

## 📝 License  
This project is open-source and available under the MIT License.
