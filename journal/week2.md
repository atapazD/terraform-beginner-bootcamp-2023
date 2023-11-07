# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

Bundler is a package manager for ruby. It is the primary way to install ruby packages (aka gems) for ruby

### Install Gems

You need to create a Gemfile and define your gems in that file

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command.

This will install the gems on the system globally (unlike nodejs which install packages in place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Execute ruby scripts in the context of bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra

Sinatra is a micro web-framerwork for ruby to build web-apps. 

Its great for mock or development servers or for simple projects. You can create a web-server in a single file.

[Sinatra](https://sinatrarb.com/)

## Terratowns Mock Server 

### RUnning the web server

We can run the webserer by executing the fllowing commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the cod efor our server is stored in the `server.rb` file.

## CRUD

Terraform Provider resources use CRUD.

CRUD stands for Create, Read, Update, and Delete

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete
