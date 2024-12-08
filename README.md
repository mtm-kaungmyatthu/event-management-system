# README

## Event Management System
This is a simple Event Management System built using Ruby on Rails. The application allows users to create and manage events with features such as role management and event validation.

## Features
Create Event: Add new events with name, time, date, location, and description.

Role Management: Assign roles like Admin or Member to users.

Status Management: Activate or deactivate events.

Form Validations: Ensure data integrity with client-side and server-side validations.

## Setup Instructions

Prerequisites

Ensure you have the following installed:

* Ruby (3.3.6)

* Rails (8.0.0)

* Sqlite3

* Bundler

## Installation

Unzip the repository:
cd event_management_system

Install dependencies:

```
bundle install
```

Set up the database:
```
rails db:create
rails db:migrate
rails db:seed
```
Start the Rails server:
```
rails server
```
Open the application in your browser:
```
http://localhost:3000
```

## Runing local
Enter the email and password
```
Email: user1@test.com
Password: password1
```
## Disclaimer
The "Remember Me" and "Forgot Your Password" features are not working yet.
The "About" and "Contant" and "Follow Us social medias" from footer section are not also available yet.


