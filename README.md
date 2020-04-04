<h1 align="center">Mage2click - Magento Docker Toolset</h1> 

<p align="center"><img src="assets/images/install.png" width="600" align="center" alt="Mage2click Docker Magento environment and toolset" /></p>

<p align="center">
  <a href="https://github.com/magento/magento2" target="_blank"><img src="https://img.shields.io/badge/magento-2.X-brightgreen.svg?logo=magento&longCache=true&style=for-the-badge&logoColor=white" alt="Supported Magento Versions" /></a>
  <a href="https://hub.docker.com/r/mage2click/m2c/" target="_blank"><img src="https://img.shields.io/docker/pulls/mage2click/m2c.svg?label=docker%20pulls&style=for-the-badge&logo=docker&logoColor=white&color=brightgreen" alt="Docker Hub Pulls" /></a>
  <a href="https://mage2click.slack.com/#general" target="_blank"><img src="https://img.shields.io/badge/chat-Mage2click-brightgreen.svg?style=for-the-badge&logo=slack" alt="Mage2click in Slack"/></a>
  <a href="https://twitter.com/intent/follow?screen_name=mage2click" target="_blank"><img src="https://img.shields.io/twitter/follow/mage2click?color=brightgreen&label=mage2click&logo=twitter&logoColor=white&style=for-the-badge" /></a>
</p>

Mage2click toolset is a system-wide command-line tool for creating and managing simultaneously running Docker Magento projects with insanely easy installation and configuration. It includes plenty of configurable services and useful commands for developing and project orchestration right out of the box. On macOS systems, mutagen.io tool will be bundled in the toolset for high-performance files sync between host and Docker containers.

## Table of contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [What is included](#what-is-included)
    - [Global system-wide services](#global-system-wide-services)
    - [Per-project services](#per-project-services)
- [Usage](#usage)
    - [Interactive project initialization mode](#interactive-project-initialization-mode)
    - [Commandline project initialization mode](#commandline-project-initialization-mode)
    - [CLI Commands reference](#cli-commands-reference)
    - [Connecting to Database](#connecting-to-database)
    - [Debugging with Xdebug](#debugging-with-xdebug)
- [Authors Information](#authors-information)
- [License](#license)

## Prerequisites

This setup assumes you are running Docker on a computer with at least 6GB of allocated RAM, a dual-core, and an SSD hard drive. 
 
This configuration has been tested on macOS. Linux based systems still require testing. Any testing are welcomed!

## Installation

To install Mage2click toolset to your system, simply run command below.

```bash
curl -sL raw.githubusercontent.com/mage2click/m2c/master/get | bash
```

Or shortened version of above.

```bash
curl -sL get.m2c.run | bash
```

## What is included

### Global system-wide services 

After toolset is installed, you will have the next tools available locally:

**Traefik** - `https://traefik.m2c.test`
> Traefik is an open-source reverse proxy and load balancer for HTTP and TCP-based applications that is easy, dynamic, automatic, fast, full-featured, production proven, provides metrics, and integrates with every major cluster technology. <a href="https://traefik.io" target="_blank">https://traefik.io</a>
>
**Portainer** - `https://portainer.m2c.test`
> Portainer is a lightweight management toolset that allows you to easily build, manage and maintain Docker environments. Created by experts, Portainer is an opinionated toolset that captures years of experience to allow you to reliably and quickly create, operate and trouble-shoot your Docker environments. <a href="https://portainer.io" target="_blank">https://portainer.io</a>

**Mailhog** - `https://mailhog.m2c.test`
> MailHog is an email testing tool for developers. Allows to view messages in the web UI, or retrieve them with the JSON API. Optionally allows to release messages to real SMTP servers for delivery. <a href="https://github.com/mailhog/MailHog" target="_blank">https://github.com/mailhog/MailHog</a>

**Dnsmasq** - `https://dnsmasq.m2c.test`
> Dnsmasq provides network infrastructure for small networks: DNS, DHCP, router advertisement and network boot. It is designed to be lightweight and have a small footprint, suitable for resource constrained routers and firewalls. <a href="http://www.thekelleys.org.uk/dnsmasq/doc.html" target="_blank">http://www.thekelleys.org.uk/dnsmasq/doc.html</a>

Toolset local homepage with links to all tools listed above - `https://m2c.test`

**All Docker images with services listed above required to be active for toolset functioning.**  
These services are configured to start automatically and should not be stopped. Without active Traefik and Dnsmasq, m2c backed projects can't work properly.  

If you don't want auto-start of these services, you can disable it with the command below.

```bash
m2c global autostart off
```

### Per-project services

Most of services are available with version on your choice.

All Docker Magento projects initialized with: 

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

## Usage

After toolset is installed on your system, you may use it to initialize new or existing magento projects.

To get a list of all commands and usage information, run command below.

```bash
m2c --help
```

### Interactive project initialization mode

To initialize project, open the desired directory with terminal and run

```bash
m2c init
```

This command will launch project initialization in interactive mode. Simply follow the steps to configure the desired Docker Magento development environment.

### Commandline project initialization mode

If at least one command argument is defined, automated setup will be started. All undefined parameters will be set with default values.

```bash
m2c init [parameters...] [flags...]
```

To get a list of all available parameters and flags for project configuration, run 

```bash
m2c init --help
```

### CLI Commands reference

#### Project area commands 

```bash
m2c add service <service> [--help]
m2c add domain <domain> [--help]
m2c add [--help]
``` 
Adds optional service or extra domain to the project. Available optional services are: `elasticsearch`, `phpmyadmin`, `rabbitmq` and `varnish`. Run `m2c add --help` for command usage information.

```bash
m2c bash [--debug] [--root] ...
```
Opens the bash prompt on the project's php Docker service.  With `--debug` flag, the bash prompt will be opened on the project's xdebug Docker service. With `--root` flag, the root user will be used.

```bash
m2c cli [--debug] [--root] ...
```
Runs any CLI command without going into the bash prompt of the project's php service. With `--debug` flag, the CLI command will run on the project's xdebug service. With `--root` flag, the root user will be used.

```bash
m2c composer <command> [options] [arguments]
```
Runs [Composer](https://getcomposer.org) specific commands. Run `m2c composer` for command usage information.

```bash
m2c db [command] [--help]
```
Database related commands. Import/Export database commands and MySQL CLI tool access. Available optional services are: `export`, `import` and `mysql`. Run `m2c db --help` for command usage information.

```bash
m2c down
```
Removes project Docker containers, volumes, and networks. Project sources on the host will be untouched. Don't forget to create a database backup before running this command.

```bash
m2c grunt
```
The grunt command-line interface. Runs grunt specific commands at projects Docker container. Run `m2c grunt --help` for command usage information.

```bash
m2c info
```
Prints project info and Docker containers status.

```bash
m2c init
```
Initializes project in the current directory. Run `m2c init --help` for command usage information.

```bash
m2c m
```
Magento command-line tool interface. Runs `bin/magento` specific commands at projects Docker container.  Its is shortened alias of `m2c magento` command.

```bash
m2c mr
```
N98-magerun command-line tool interface. Runs `n98-magerun` specific commands at projects Docker container. It is shortened alias of `m2c magerun` command. Run `m2c mr --help` for command usage information.

```bash
m2c node 
```
Node command-line tool interface. Runs `node` specific commands at projects Docker container. Run `m2c node --help` for command usage information.

```bash
m2c npm
```
NPM command-line tool interface. Runs `npm` specific commands at projects Docker container. Run `m2c npm --help` for command usage information.

```bash
m2c redis [options] [cmd [arg [arg ...]]]
```
Redis command-line tool interface. Runs `redis-cli` specific commands at projects Redis Docker container. Run `m2c redis --help` for command usage information.

```bash
m2c remove [service] [--help]
```
Removes optional service from the project. Available optional services are: `elasticsearch`, `phpmyadmin`, `rabbitmq` and `varnish`. Run `m2c remove --help` for command usage information.

```bash
m2c restart [service [service ...]]
```
Restarts running project Docker services and starts all stopped ones. If services are explicitly specified, only specified will be restarted.

```bash
m2c share [region] [--help]
```
Starts sharing session over [ngrok](https://ngrok.com) secure tunnels. Command accepts an optional parameter to specify a region. Ex. `m2c share eu`. Available regions are `us`, `eu`, `ap`, `au`, `sa`, `jp`, and `in`. By default, region is `us`. For proper functioning of this command, required dependencies will be installed. Please, visit [https://github.com/shkoliar/magento-ngrok](https://github.com/shkoliar/magento-ngrok) and [https://github.com/shkoliar/docker-ngrok](https://github.com/shkoliar/docker-ngrok) for more information. Run `m2c share --help` for command usage information. 

```bash
m2c sign [domain [domain ...]]
```
Signs SSL certificate for provided domain names. Only domains with .test TLD are allowed.  

```bash
m2c start [service [service ...]]
```
Starts stopped project services. If services are explicitly specified, only specified will be started.

```bash
m2c status
```
Prints project information and services status.

```bash
m2c stop [service [service ...]]
```
Stops active project services. If services are explicitly specified, only specified will be stopped.

```bash
m2c sync [command] [--help]
```
Controls the synchronization sessions between host and docker container.

```bash
m2c update
```
Updates the project's docker configuration to the latest version.

```bash
m2c urn
```
Generates Uniform Resource Names (URN) for PHPStorm and remaps paths for the host.

```bash
m2c varnish <tool>
```
Run varnish command line tools such as `varnishadm`, `varnishhist`, `varnishstat`, `varnishtop`, `varnishtest`, `varnishlog` etc.


_Adding information about other CLI commands is in progress..._


### Connecting to Database

Project database can be easily accessed in a few ways - with help of optional phpMyAdmin service or with database managing applications by using a direct connection to the database via SSH tunnel.  
Read the article at project's wiki page on how to connect to your project's database - <a href="https://github.com/mage2click/m2c/wiki/Connecting-to-Database" target="_blank">Connecting to Database</a>

### Debugging with Xdebug

Mage2click toolset supports Magento debugging with Xdebug out of the box. Only a few configuration steps are required.  
Read the article at project's wiki page on how to use Xdebug with PHPStorm - <a href="https://github.com/mage2click/m2c/wiki/Debugging-with-Xdebug" target="_blank">Debugging with Xdebug</a>

## Authors Information

### Dmitry Shkoliar
<a href="https://www.zend.com/en/yellow-pages/ZEND026786" target="_blank">Zend Certified PHP Engineer</a>, Magento2, Docker, PWA, Varnish, JS, HTML5, Mobile, iOS, Android  
Github: <a href="https://github.com/shkoliar" target="_blank">@shkoliar</a>  
Twitter: <a href="https://twitter.com/shkoliar" target="_blank">@shkoliar</a>  
Website: <a href="https://shkoliar.com" target="_blank">shkoliar.com</a>  

## License

[MIT](LICENSE)
