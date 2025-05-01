# PHP Project

## Description
This is a simple PHP project running on a LEMP stack using Docker.

## Instructions
1. Ensure you have Docker and Docker Compose installed on your system.
2. Clone this repository to your local machine.
3. Navigate to the php-project directory.
4. Build and start the Docker containers:
    ```bash
    docker-compose up -d
    ```
5. Run the setup script:
    ```bash
    ./run.sh
    ```
6. Access the project via your browser at `https://localhost` or `https://folder_name.test`.

## Notes
- The `php-project` folder will automatically register example domains in the format `folder_name.test` for local development.
- The `run.sh` script is used to register local domains and set up HTTPS support using `mkcert`. Ensure `mkcert` is installed and trusted on your system before running the script.
- The Docker Compose file includes services for Nginx, MySQL, PHPMYADMIN, and PHP.
- Customize the `docker-compose.yml` and `php.ini` files as needed.
- Follow best practices for PHP development.

## Supported Platforms
- [x] Linux
- [ ] Windows
- [ ] macOS

## Future Development
- Support for multiple PHP versions to allow testing and running different PHP-based applications.
- Enhanced Nginx configuration to support frameworks and CMS beyond Laravel, such as WordPress and other PHP-based platforms.
- Improved flexibility in the `docker-compose.yml` file to enable easier customization for various project requirements.
- Additional documentation for setting up and configuring multiple PHP versions and Nginx configurations.
- Potential integration with tools like Xdebug for debugging across different PHP versions.
- Streamlined process for adding new domains and SSL certificates for additional projects.
- Testing and support for Windows and macOS platforms.