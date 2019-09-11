# Mage2click Docker Magento <br><small>environment and toolset</small>

<p align="center"><img src="assets/images/install.png" width="600" align="center" alt="Mage2click Docker Magento environment and toolset" /></p>

Mage2click toolset is a system-wide command-line tool for managing simultaneously running docker Magento projects with insanely easy installation and configuration. It includes plenty of configurable services and useful commands for developing and projects orchestration right out of the box.

## Prerequisites

This setup assumes you are running Docker on a computer with at least 6GB of allocated RAM, a dual-core, and an SSD hard drive. 
 
This configuration has been tested on macOS.

## Installation

To install Mage2click toolset to your system, simply run command below.

```bash
curl -sL raw.githubusercontent.com/mage2click/m2c/master/get | bash
```

Or shortened version of above.

```bash
curl -sL get.m2c.run | bash
```

For macOS systems, mutagen.io tool will be bundled in the toolset for high-performance files sync between host and docker containers.

## What is included

### Global system-wide services 

After toolset is installed, you will have the next tools available locally:

- Traefik - https://traefik.m2c.test
- Portainer - https://portainer.m2c.test
- Mailhog - https://mailhog.m2c.test
- Dnsmasq - https://dnsmasq.m2c.test

Toolset local homepage with links to all tools listed above - https://m2c.test  

### Per-project services

Most of services are available with version on your choice.

All docker Magento projects initialized with: 

- Nginx
- PHP-FPM
- MariaDB
- Redis
- Xdebug

And optionally available:

- Varnish
- Elasticsearch
- phpMyadmin
- RabbitMQ 

