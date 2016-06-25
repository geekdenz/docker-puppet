docker-postgis
==============

Docker PostGIS Image with working PostGIS enabled database.

How to use
==========

```bash
./build # if you want to rebuild the image
./run_localhost # run PostgreSQL on local port 5432
```

The commands do the following:

```bash
#./build
sudo docker build -t denz/postgis .
```

```bash
#./run_localhost
sudo docker run -p 5432:5432 -d denz/postgis
```
