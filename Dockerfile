FROM ubuntu:trusty
MAINTAINER Tim-Hinnerk Heuer <th.heuer@gmail.com>

# Install packages
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install wget
RUN DEBIAN_FRONTEND=noninteractive wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb -O /tmp/puppetlabs-release-pc1-trusty.deb
RUN DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/puppetlabs-release-pc1-trusty.deb
RUN apt-get update
#RUN DEBIAN_FRONTEND=noninteractive apt-get -y install postgresql-9.3-postgis-2.1 puppet-agent
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install puppet
RUN DEBIAN_FRONTEND=noninteractive gem install r10k

# Add image configuration and scripts

# Add volumes for MySQL
#VOLUME  ["/etc/mysql", "/var/lib/mysql" ]
#VOLUME []

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-9.3`` package when it was ``apt-get installed``
USER root
#USER postgres

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
# Note: here we use ``&&\`` to run commands one after the other - the ``\``
#       allows the RUN command to span multiple lines.
    #createlang -d template_postgis plpgsql &&\
#RUN    /etc/init.d/postgresql start &&\
#    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
#    psql --command "CREATE DATABASE docker OWNER docker;" &&\
#    echo SUCCESS
#RUN    /etc/init.d/postgresql start &&\
#    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
#    createdb -E UTF8 -U postgres --template=template0 template_postgis &&\
#    psql -U postgres -d template_postgis -c"CREATE EXTENSION hstore;" &&\
#    psql -U postgres -d template_postgis -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql &&\
#    psql -U postgres -d template_postgis -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql &&\
#    createdb -O docker --template template_postgis docker &&\
#    psql -U postgres -d template_postgis -c "GRANT ALL ON geometry_columns TO PUBLIC;" &&\
#    psql -U postgres -d template_postgis -c "GRANT ALL ON spatial_ref_sys TO PUBLIC;" &&\
#    psql -U postgres -d template_postgis -c "GRANT ALL ON geography_columns TO PUBLIC;"
#
## Adjust PostgreSQL configuration so that remote connections to the
## database are possible. 
#RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf
#
## And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
#RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432
EXPOSE 80
EXPOSE 8080

VOLUME  ["/var/www"]
## Add VOLUMEs to allow backup of config, logs and databases
#VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
#
## Set the default command to run when starting the container
#CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]
