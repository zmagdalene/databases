# Docker Notes

## Introduction to Docker Images and Containers

These notes explain how Docker works using the development environment configured in the `./docker` folder of this project.

---

## 1. Docker Images and Containers

### What is a Docker Image?

A Docker **image** is a read-only template that contains everything needed to run an application:

- The operating system (usually a minimal Linux distribution)
- The application software (e.g., PHP, Apache, MySQL)
- Configuration files
- Dependencies and libraries

Think of an image as a **blueprint** or **recipe**. It defines what should be installed and configured, but it doesn't actually run anything.

**Key characteristics of images:**
- Read-only (cannot be changed once built)
- Can be stored and shared (via Docker Hub or other registries)
- Have a name and version tag (e.g., `php:8.4-apache`, `mysql:8.0`)
- Are built in layers (each instruction adds a layer)

### What is a Docker Container?

A Docker **container** is a running instance of an image. When you start a container, Docker:

1. Takes the image (the blueprint)
2. Creates a writable layer on top
3. Starts the application defined in the image

Think of containers as **running copies** of an image. You can have multiple containers running from the same image.

**Key characteristics of containers:**
- Can be started, stopped, restarted, and deleted
- Have their own isolated filesystem, network, and processes
- Changes made inside a container are lost when it's deleted (unless using volumes)
- Each container gets a unique ID and can be given a name

### The Relationship Between Images and Containers

```
┌─────────────────────────────────────────────────────────────┐
│                        DOCKER IMAGE                         │
│                      (Read-only blueprint)                  │
│                                                             │
│   Contains: OS + Software + Config + Dependencies           │
│   Example: php:8.4-apache                                   │
└─────────────────────────────────────────────────────────────┘
                              │
                              │ docker run
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      DOCKER CONTAINER                       │
│                    (Running instance)                       │
│                                                             │
│   - Has its own filesystem                                  │
│   - Has its own network interface                           │
│   - Runs the application                                    │
│   - Can be started/stopped                                  │
└─────────────────────────────────────────────────────────────┘
```

### Analogy: Classes and Objects

If you're familiar with programming:

| Programming | Docker |
|-------------|--------|
| Class definition | Image |
| Object instance | Container |
| `new MyClass()` | `docker run image-name` |

Just as you can create multiple objects from one class, you can create multiple containers from one image.

---

## 2. Dockerfile - Building Custom Images

### What is a Dockerfile?

A **Dockerfile** is a text file containing instructions for building a Docker image. Each instruction creates a layer in the image.

You don't need to write Dockerfiles for this module, but understanding them helps you understand what's happening inside your containers.

### Example: Our Apache-PHP Dockerfile

Here is the Dockerfile used to build our Apache-PHP container (located at `docker/apache-php/Dockerfile`):

```dockerfile
# Use the official PHP image with Apache
FROM php:8.4-apache

# Enable the Apache rewrite module
RUN a2enmod rewrite

# Install and enable Xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

# Install the PDO MySQL extension
RUN docker-php-ext-install pdo_mysql && docker-php-ext-enable pdo_mysql

# Copy custom Apache configuration file
COPY ./config/httpd.conf /etc/apache2/sites-available/000-default.conf

# Copy the development php.ini configuration file
RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

# Copy custom Xdebug and error reporting configuration files
COPY ./config/xdebug.ini          /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY ./config/error_reporting.ini /usr/local/etc/php/conf.d/error_reporting.ini
```

### Understanding Dockerfile Instructions

| Instruction | What it does | Example |
|-------------|--------------|---------|
| `FROM` | Specifies the base image to start from | `FROM php:8.4-apache` |
| `RUN` | Executes a command during the build process | `RUN a2enmod rewrite` |
| `COPY` | Copies files from your computer into the image | `COPY ./config/httpd.conf /etc/apache2/...` |
| `EXPOSE` | Documents which port the container will use | `EXPOSE 80` |

### How the Dockerfile Builds Our Image

```
Step 1: Start with php:8.4-apache image
        (This already has PHP 8.4 and Apache installed)
                    │
                    ▼
Step 2: Enable Apache's rewrite module
        (Needed for clean URLs in web applications)
                    │
                    ▼
Step 3: Install Xdebug
        (A debugging tool for PHP development)
                    │
                    ▼
Step 4: Install PDO MySQL extension
        (Allows PHP to connect to MySQL databases)
                    │
                    ▼
Step 5: Copy configuration files
        (Custom Apache and PHP settings)
                    │
                    ▼
        Final Image: Custom PHP+Apache+Xdebug+MySQL support
```

---

## 3. Docker Compose - Managing Multiple Containers

### Why Docker Compose?

Real applications often need multiple services working together:

- A **web server** to serve web pages (Apache + PHP)
- A **database** to store data (MySQL)
- An **admin tool** to manage the database (phpMyAdmin)

Docker Compose lets you define and run all these services together with a single command.

### The compose.yaml File

Docker Compose uses a YAML file (usually named `compose.yaml` or `docker-compose.yml`) to define the services.

Here is our project's `compose.yaml` file:

```yaml
services:
  mysql-container:
    image: mysql:8.0
    env_file:
      - .env
    ports:
      - "3306:3306"
    volumes:
      - ./docker/mysql/data:/var/lib/mysql
      - ./src/sql:/docker-entrypoint-initdb.d
    networks:
      - devnet

  phpmyadmin-container:
    build: ./docker/phpmyadmin
    env_file:
      - .env
    ports:
      - "8081:80"
    environment:
      PMA_HOST: mysql-container
      PMA_USER: ${MYSQL_USER}
      PMA_PASSWORD: ${MYSQL_PASSWORD}
    networks:
      - devnet
    depends_on:
      - mysql-container

  apache-php-container:
    build: ./docker/apache-php
    ports:
      - "8080:80"
    volumes:
      - ./src:/var/www/html
    networks:
      - devnet
    depends_on:
      - mysql-container

networks:
  devnet:
    driver: bridge
```

### Understanding the compose.yaml Structure

#### Services

The `services:` section defines each container. We have three services:

| Service Name | Purpose | Base |
|--------------|---------|------|
| `mysql-container` | Database server | Official MySQL 8.0 image |
| `phpmyadmin-container` | Database admin tool | Custom build from `./docker/phpmyadmin` |
| `apache-php-container` | Web server with PHP | Custom build from `./docker/apache-php` |

#### Key Configuration Options

**`image`** - Use a pre-built image from Docker Hub
```yaml
image: mysql:8.0
```

**`build`** - Build a custom image from a Dockerfile
```yaml
build: ./docker/apache-php
```

**`ports`** - Map ports from host to container
```yaml
ports:
  - "8080:80"    # host:container
```
This means: Access port 8080 on your computer to reach port 80 in the container.

**`volumes`** - Share folders between host and container
```yaml
volumes:
  - ./src:/var/www/html
```
This means: The `./src` folder on your computer appears as `/var/www/html` inside the container. Changes you make to files in `./src` are immediately visible in the container.

**`networks`** - Connect containers to a network
```yaml
networks:
  - devnet
```
Containers on the same network can communicate with each other using their service names as hostnames.

**`depends_on`** - Control startup order
```yaml
depends_on:
  - mysql-container
```
This container will wait for mysql-container to start first.

**`environment`** and **`env_file`** - Set environment variables
```yaml
env_file:
  - .env
environment:
  PMA_HOST: mysql-container
```

### How Our Services Connect

```
┌─────────────────────────────────────────────────────────────┐
│                    Your Computer (Host)                     │
│                                                             │
│   ./src folder ◄───────────────────────┐                    │
│   (Your PHP code)                      │ Volume mount       │
│                                        │ (files shared)     │
│   ┌────────────────────────────────────┴────────────────┐   │
│   │              Docker Network: devnet                 │   │
│   │                                                     │   │
│   │   ┌───────────────────┐     ┌───────────────────┐   │   │
│   │   │ apache-php        │     │ phpmyadmin        │   │   │
│   │   │ container         │     │ container         │   │   │
│   │   │                   │     │                   │   │   │
│   │   │ localhost:8080 ◄──┼─────┼── localhost:8081  │   │   │
│   │   │                   │     │                   │   │   │
│   │   └─────────┬─────────┘     └─────────┬─────────┘   │   │
│   │             │                         │             │   │
│   │             │   Database connection   │             │   │
│   │             └───────────┬─────────────┘             │   │
│   │                         │                           │   │
│   │                         ▼                           │   │
│   │             ┌───────────────────┐                   │   │
│   │             │ mysql-container   │                   │   │
│   │             │                   │                   │   │
│   │             │ Port: 3306        │                   │   │
│   │             │ Database: testdb  │                   │   │
│   │             └───────────────────┘                   │   │
│   │                                                     │   │
│   └─────────────────────────────────────────────────────┘   │
│                                                             │
│   Access Points:                                            │
│   • http://localhost:8080 → Your PHP application            │
│   • http://localhost:8081 → phpMyAdmin (database admin)     │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### How Containers Communicate

Containers on the same Docker network can reach each other using their **service names** as hostnames:

- PHP code connects to the database using hostname `mysql-container`
- phpMyAdmin connects to MySQL using hostname `mysql-container`

This is why our PHP database connection uses:
```php
$host = 'mysql-container';  // Not 'localhost'!
```

---

## 4. Essential Docker Commands

### Starting and Stopping Containers

**Start all containers** (run from the folder containing `compose.yaml`):
```bash
docker compose up -d
```
- `up` creates and starts the containers
- `-d` runs them in "detached" mode (in the background)

**Stop all containers:**
```bash
docker compose down
```
This stops and removes the containers (but not your data or images).

**Restart all containers:**
```bash
docker compose restart
```

**Restart a specific container:**
```bash
docker compose restart apache-php-container
```

### Viewing Container Status

**List running containers:**
```bash
docker ps
```

**List all containers** (including stopped ones):
```bash
docker ps -a
```

**View container logs** (useful for debugging):
```bash
docker compose logs apache-php-container
docker compose logs mysql-container
```

**Follow logs in real-time** (Ctrl+C to stop):
```bash
docker compose logs -f apache-php-container
```

### Working with Images

**List downloaded images:**
```bash
docker images
```

**Remove an image:**
```bash
docker rmi image-name
```

### Rebuilding After Dockerfile Changes

If the Dockerfile changes, rebuild the image:
```bash
docker compose build
docker compose up -d
```

Or in one command:
```bash
docker compose up -d --build
```

---

## 5. Quick Reference

### Our Project's Access Points

| Service | URL | Purpose |
|---------|-----|---------|
| Apache + PHP | http://localhost:8080 | Your web application |
| phpMyAdmin | http://localhost:8081 | Database management |
| MySQL | localhost:3306 | Database (for external tools) |

### Database Credentials

These are configured in the `.env` file:

| Setting | Value |
|---------|-------|
| Database Host | `mysql-container` (from PHP) |
| Database Name | `testdb` |
| Username | `testuser` |
| Password | `mysecret` |

### Command Cheat Sheet

| What you want to do | Command |
|---------------------|---------|
| Start everything | `docker compose up -d` |
| Stop everything | `docker compose down` |
| See what's running | `docker ps` |
| View logs | `docker compose logs container-name` |
| Restart a container | `docker compose restart container-name` |
| Rebuild after changes | `docker compose up -d --build` |

---

## 6. Common Issues and Solutions

### "Port already in use"

If you see an error about a port being in use, another application is using that port.

**Solution:** Either stop the other application, or change the port in `compose.yaml`:
```yaml
ports:
  - "8090:80"  # Change 8080 to 8090
```

### "Container keeps restarting"

Check the logs to see what's wrong:
```bash
docker compose logs container-name
```

### "Cannot connect to database"

Make sure:
1. The MySQL container is running: `docker ps`
2. You're using `mysql-container` as the hostname (not `localhost`)
3. The credentials match those in the `.env` file

### "Changes to PHP files not showing"

The `./src` folder is mounted as a volume, so changes should appear immediately. Try:
1. Hard refresh the browser (Ctrl+F5)
2. Check you're editing files in the `./src` folder
3. Restart the Apache container: `docker compose restart apache-php-container`

---

## Summary

| Concept | What it is |
|---------|------------|
| **Image** | A read-only template/blueprint containing OS, software, and configuration |
| **Container** | A running instance of an image |
| **Dockerfile** | Instructions for building a custom image |
| **Docker Compose** | Tool for defining and running multi-container applications |
| **compose.yaml** | Configuration file defining services, networks, and volumes |
| **Volume** | Shared folder between host and container |
| **Network** | Virtual network allowing containers to communicate |
