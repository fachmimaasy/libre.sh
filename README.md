## IndieHosters

This repository contains the configuration and scripts we use to control our servers.
It can run inside Vagrant or
[deploy to a server](doc/getting-started-as-a-hoster.md) (FIXME: update those instructions to
prescribe less folder structure, explain static https+smtp hosting, and check if they currently
work).

## Prerequisites to running this code with Vagrant:
- [vagrant](http://www.vagrantup.com/)
- [virtualbox](https://www.virtualbox.org/)
- nfs
  - linux: run `apt-get install nfs-kernel-server`, or your OS equivalent
- [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater)
  - run `vagrant plugin install vagrant-hostsupdater` to install

## Get started:

```bash
vagrant up
```

Wait for the provisioning to finish (~40mins), and go to your browser: https://indiehosters.dev

If the process fails, for instance due to network problems, you can retry by running `vagrant provision`.

### Set up a domain:

```bash
vagrant ssh core-1
sudo mkdir -p /data/import/example.dev/TLS
sudo cp /data/indiehosters/scripts/unsecure-certs/example.dev.pem /data/import/example.dev/TLS
sudo systemctl enable static@example.dev
sudo systemctl start static@example.dev
```

Check https://example.dev in your bowser!

### Cleaning up

To clean up stuff from previous runs of your VM, you can do:

```bash
vagrant destroy
vagrant up
```

## Tests

```bash
vagrant destroy
vagrant up
# Set up example.dev as above, and test https://example.dev in your browser
vagrant ssh core-1
sudo su
/data/indiehosters/tests/main.sh
```
