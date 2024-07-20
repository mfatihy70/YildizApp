<img src="https://github.com/user-attachments/assets/5b0bd0c5-f63e-44eb-af77-4fb9766a491a" width="250">  

# Yildiz App

Yildiz App is a Flutter application designed for managing orders.

## Database Configuration

For the application to connect to the Aiven Cloud PostgreSQL database, ensure you have a `variables.env` file under the `assets` folder with the following entries:
Please write the values with your actual database configuration details.

- `DB_HOST=`
- `DB_NAME=`
- `DB_USERNAME=`
- `DB_PASSWORD=`
- `DB_PORT=`
- `DB_SSL_MODE=true`


If you wish to use another PostgreSQL server, just input the requiered information in the app settings under database connection.

The databse table will be created when the first order is sent.


## Features

The Yildiz App comes with a variety of features:

- **Home Page**: Features a modern-looking home page with hero view components.
- **Order Form**: Allows users to send an order to the database after validation.
- **Order List**: Fetches the orders from the database, handles possible errors, and displays them in a table.
- **Settings**: Provides standard settings options such as app theme, language, notifications, privacy, and account management.

## Getting Started
1. Clone the repository:
    ```
    git clone https://github.com/mfatihy70/YildizApp.git
    ```
2. Navigate into the project directory:
    ```
    cd YildizApp
    ```
3. Install the dependencies:
    ```
    flutter pub get
    ```
4. Run the app:
    ```
    flutter run

## Contributing

Contributions are welcome! Just create a PR or write to me.

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.


<img src="https://github.com/user-attachments/assets/32dde3d1-9bd1-47e2-b901-aba7603a0292" width="400" alt="v026 Home">
<img src="https://github.com/user-attachments/assets/a15c435d-837f-4d05-826f-08ddc9a104c1" width="400" alt="v026 Form">
<img src="https://github.com/user-attachments/assets/c1a5ff08-5453-4bbd-833d-ae1b32a35a2f" width="400" alt="v026 List">
<img src="https://github.com/user-attachments/assets/fc175cac-3efb-4e25-b496-f865d2a21b5b" width="400" alt="v026 Settings">
