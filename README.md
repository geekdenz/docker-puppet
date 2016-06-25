docker-puppet
==============

Docker Puppet Image Proof of Concept.

See [docker-puppet GitHub Repository](https://github.com/geekdenz/docker-puppet).

How to use
==========

```bash
# You may need to use sudo with these:
./build # if you want to rebuild the image
```

The commands do the following:

```bash
#./build
sudo docker build -t denz/puppet-provision .
```

```bash
./run_daemon # run image in daemon mode
./run_daemon_and_attach # run and immediately start a shell
./run_puppet # run example puppet command
```
