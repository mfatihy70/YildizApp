<img src="https://github.com/user-attachments/assets/5b0bd0c5-f63e-44eb-af77-4fb9766a491a" width="250">  


---

# Yildiz App

Yildiz App is a modern Flutter application with Material 3 UI designed for managing orders of a small food delivery company.
It replaces the old system of sending messages for orders, which makes it easier both for the clients and the owner.
Functions are viewing the food list, filling and submitting an order form, show, edit or delete sent orders and settings

## Features

The Yildiz App includes a variety of useful features:

- **Home Page**: A modern home page with hero view components.
- **Order Form**: Validates and submits orders to the database.
- **Order List**: Fetches orders from the database, handles potential errors, and displays them in a table format. Includes options to edit or delete orders.
- **Settings**: Includes settings for app theme, language, notifications, privacy, and account management.

## Getting Started
###  Clone the repository:
    git clone https://github.com/mfatihy70/YildizApp.git

### Navigate into the project directory:
    cd YildizApp
    
### Install the dependencies:
    flutter pub get
    

### Database Configuration

Before running the app, ensure the application is connected to a cloud PostgreSQL database (Aiven.io eg.)
You will need to create a `variables.env` file in the `assets` folder with the following entries:
```
DB_HOST=
DB_NAME=
DB_USERNAME=
DB_PASSWORD=
DB_PORT=
DB_SSL_MODE=true
```

Please replace the values with your actual database configuration details.

The necessary database tables will be created automatically when the first order is submitted.

 ### Run the app:
    flutter run

---
## Contributing

Contributions are welcome! Feel free to create a pull request (PR) or contact me directly.

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

---

<img src="https://github.com/user-attachments/assets/32dde3d1-9bd1-47e2-b901-aba7603a0292" width="400" alt="v026 Home">
<img src="https://github.com/user-attachments/assets/a15c435d-837f-4d05-826f-08ddc9a104c1" width="400" alt="v026 Form">
<img src="https://github.com/user-attachments/assets/c1a5ff08-5453-4bbd-833d-ae1b32a35a2f" width="400" alt="v026 List">
<img src="https://github.com/user-attachments/assets/fc175cac-3efb-4e25-b496-f865d2a21b5b" width="400" alt="v026 Settings">
