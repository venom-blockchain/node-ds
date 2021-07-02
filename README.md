# README

This HOWTO contains instructions on how to build and configure a TON OS DApp Server in TON blockchain. The instructions and scripts below were verified on Ubuntu 20.04.

# Table of Contents
- [Introduction](#introduction)
- [Getting Started](#getting-started)
  - [1. System Requirements](#1-system-requirements)
  - [2. Prerequisites](#2-prerequisites)
    - [2.1 Set the Environment](#21-set-the-environment)
    - [2.2 Install Dependencies](#22-install-dependencies)
    - [2.3 Deploy Node](#23-deploy-node)
- [Stopping, restarting and deleting DApp Server](#stopping-restarting-and-deleting-dapp-server)
- [Redeploying DApp Server](#redeploying-dapp-server)

# Introduction

TON OS DApp Server is a set of services enabling you to work with TON blockchain.

The core element of TON OS DApp Server is [TON node written in Rust](https://github.com/tonlabs/ton-labs-node) focused on performance and safety. TON OS DApp Server provides a set of services serving TON SDK endpoint: scalable multi-model database [ArangoDB](https://www.arangodb.com/documentation/) with the information about all blockchain entities (like accounts, blocks, transactions, etc.) stored over time, distributed high-throughput, low-latency streaming platform [Kafka](https://kafka.apache.org/documentation/), [TON GraphQL Server](https://github.com/tonlabs/ton-q-server) (aka Q-Server) for serving GraphQL queries to the database and [Nginx](https://nginx.org/en/docs/) web-server.

All the TON OS DApp Server services can be easily deployed with Docker/Docker Compose wrapped into unix shell scripts, provided below.

> **Note**: Node is included in the DApp Server, and doesn't have to be installed separately.

# Getting Started

## 1. System Requirements
| Configuration | CPU (cores) | RAM (GiB) | Storage (GiB) | Network (Gbit/s)|
|---|:---|:---|:---|:---|
| Recommended |24|192|2000|1| 

SSD disks are recommended for the storage.

**Note**: To connect to a DApp Server you are running with client applications (such as [TONOS-CLI](https://github.com/tonlabs/tonos-cli#21-set-the-network-and-parameter-values)), it should have a domain name and a DNS record. Then its URL may be used to access it.

## 2. Prerequisites
### 2.1 Set the Environment
Adjust (if needed) `TON-OS-DApp-Server/scripts/env.sh`:
- specify the network - use main.ton.dev for the main network and net.ton.dev for the developer network
- specify notification email

Set environment variables:

    $ cd TON-OS-DApp-Server/scripts/
    $ . ./env.sh 


### 2.2 Install Dependencies
Ubuntu 20.04:

    $ ./install_deps.sh
    
**Note**: Make sure to add your user to the docker group, or run subsequent command as superuser:


    sudo usermod -a -G docker $USER


### 2.3 Deploy Full Node
Deploy full node:

    $ ./deploy.sh 2>&1 | tee ./deploy.log


**Note**: the log generated by this command will be located in the `TON-OS-DApp-Server/scripts/` folder and can be useful for troubleshooting.

# Stopping, restarting and deleting DApp Server

**Note**: call docker-compose commands from the `TON-OS-DApp-Server/docker-compose/ton-node` folder.
    
To stop the node use the following command:

    docker-compose stop

To restart a stopped node use the following command:
    
    docker-compose restart

To remove the node use the following commands:
    
    docker-compose down
    git reset --hard origin/master
    git clean -ffdx
    
**Warning**: all local files and changes will be deleted from the git tree.

# Redeploying DApp Server

Before redeploying DApp server, make sure to remove the node and reset the git branch:
    
    cd TON-OS-DApp-Server/docker-compose/ton-node
    docker-compose down
    git reset --hard origin/master
    git clean -ffdx

Otherwise redeployment will fail.
When the branch is reset, repeat steps 2.1 - 2.3.
