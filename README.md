# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

this repositry of myportal


## Registered Services
* redis
* postgres
* nginx
* rapportal #<-Unicorn Service
* rapportal_sidekiq


## Add RSS Target
* add rake task to feed for rapportal.rake
* add worker to app/workers/
* add config code to config/sidekiq.yml
* restart service of sidekiq 
