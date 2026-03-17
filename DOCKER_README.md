# ERMS - Employee Record Management System - Docker Setup

## Overview
This Docker setup allows you to run the ERMS application with Apache and MySQL in isolated containers.

## Prerequisites
- [Docker](https://www.docker.com/products/docker-desktop) installed
- [Docker Compose](https://docs.docker.com/compose/install/) installed

## Quick Start

### 1. Build and Run Containers
```bash
docker-compose up --build
```

This command will:
- Build the PHP/Apache image
- Start the PHP web server on `http://localhost`
- Start a MySQL database server
- Automatically initialize the database with `ermsdb.sql`

### 2. Access the Application
- **Web Application**: http://localhost
- **Database**: `localhost:3306` (MySQL)

### 3. Database Connection Details
The containers use the following credentials (defined in `docker-compose.yml`):
- **Host**: `db` (Docker service name) or `localhost` (from outside Docker)
- **User**: `root`
- **Password**: `password`
- **Database**: `ermsdb`

## Running the Containers

### Start Containers
```bash
docker-compose up
```

### Stop Containers
```bash
docker-compose down
```

### View Container Logs
```bash
docker-compose logs -f web
docker-compose logs -f db
```

### Rebuild After Code Changes
```bash
docker-compose up --build
```

## File Structure
- `Dockerfile` - Configuration for PHP/Apache container
- `docker-compose.yml` - Orchestrates web and database services
- `.dockerignore` - Files excluded from Docker build

## Environment Variables
The following environment variables are available in the web container:
- `DB_HOST` - Database host (default: `db`)
- `DB_USER` - Database user (default: `root`)
- `DB_PASSWORD` - Database password (default: `password`)
- `DB_NAME` - Database name (default: `ermsdb`)

To modify these, edit the `environment` section in `docker-compose.yml`.

## Database Persistence
The MySQL database data is stored in a Docker volume named `erms-erms-network` to ensure data persists even if containers are stopped.

To reset the database:
```bash
docker-compose down -v
docker-compose up --build
```

## Troubleshooting

### Can't Connect to Database
- Ensure the `db` service in `docker-compose.yml` is running: `docker-compose ps`
- Check database logs: `docker-compose logs db`
- Verify database credentials in `docker-compose.yml`

### Application Gives "Connection Fail"
- Wait 10-15 seconds after starting containers for MySQL to fully initialize
- Check that the database name in `docker-compose.yml` matches your SQL file

### Port Already in Use
If port 80 or 3306 are already in use, modify the port mappings in `docker-compose.yml`:
```yaml
ports:
  - "8080:80"  # Access on http://localhost:8080
  - "3307:3306"
```

### View Running Containers
```bash
docker ps
docker-compose ps
```

## Additional Commands

### Access MySQL CLI Inside Container
```bash
docker exec -it erms-db mysql -u root -p ermsdb
```

### Execute PHP Commands
```bash
docker exec erms-web php -r "phpinfo();"
```

### Rebuild Specific Service
```bash
docker-compose up --build web
```

## Production Considerations
⚠️ **Important**: This setup is suitable for development. For production:
- Change default database password in `docker-compose.yml`
- Use environment files (`.env`) instead of hardcoding values
- Add HTTPS/SSL configuration to Apache
- Implement proper backup strategies for database volumes
- Add health checks to the services
- Use proper secrets management

---

For more information about Docker and Docker Compose, visit:
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
