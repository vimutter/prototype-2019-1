# README

Hi,

this is prototype crawler application aimed at be running in docker. A lot of implementation is done intentionally cutting corners. Use at your own risk.

## Ruby version
 This prototype was developed using Ruby 2.6 (MRI) on Ubunty

* System dependencies

This repository contains `Dockerfile`, so in order to build and run, you will need to install it on your system (https://docs.docker.com/docker-for-mac/install/)

* Configuration

* Database creation
This is prototype application, so all data is stored in sqlite DB, which means no object will persist between application restarts.

* Database initialization

* How to run the test suite

In order to run tests, execute following command:

`bundle ex rspec`

* Services (job queues, cache servers, search engines, etc.)
- TBD

* Deployment instructions
1. Build docker image:
`docker build -t prototype .`
2. Run image with port forwarding:
`docker run -p 3000:3000 -d prototype`
3. Open browser at `localhost:3000`
