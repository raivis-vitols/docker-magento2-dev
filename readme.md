# Bare-Bones Magento 2 Docker Setup For Local Development
Magento 2 docker setup without extras and fancy utility commands.\
This docker setup is intended to be used by exec-ing into containers.\
TLS for local installation is handled via self-signed certificate by mkcert.

## Prerequisites

1. Install mkcert: `apt install mkcert`
2. Install the local CA: `mkcert -install`

## Build & Start Containers

1. Run `bin/setup.sh` and enter the prompted data
2. Build containers by running: `docker-compose build`
3. Start the containers: `docker-compose up`

Nginx container will not start correctly as it requires Magento to be installed first.\
Setup uses the `nginx.conf.sample` provided in default Magento as it's configuration.\
Once the `nginx.conf.sample` is present, restart the containers or wait for auto-restart.\
Alternatively you edit nginx config file located in: `build/nginx-http/default.conf`

### New Magento Installation

Install Magento via: `bin/install.sh` or exec into PHP container to install manually.\
Make sure the containers are running when executing the `bin/install.sh` script.\
No admin user will be created. Use Magento's `admin:user:create` command.

### Existing Magento Installation

Exec into PHP container and git clone your existing Magento project.

## Database Management

To manage the database, exec into database container and execute the mysql commands:\
`docker exec -ti [mysql-container-name] /bin/bash`

In order to import the existing Magento database:
1. Place the database dump into `data/sql-dumps/` directory
2. Exec into DB container: `docker exec -ti [mysql-container-name] /bin/bash`
3. Run standard MySQL DB import: the `sql-dumps` directory is mounted as `/var/sql-dumps`

## Cron
Cron service does not start automatically in the PHP container. Run the following script to start it:\
`bin/cron.sh start`

## Varnish
Export the VCL configuration from Magento and replace the contents in `build/varnish/default.vcl` file.\
Restart the containers and configure Magento to use Varnish cache instead of the built-in full page cache.

## Hosts File
Remember to add your local Magento installation's URL to `/etc/hosts` file. F.e. `127.0.0.1 local.magento.com`
