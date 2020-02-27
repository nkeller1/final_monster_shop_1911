## Turing Project
Monster Shop - Module 2 Group Project

### Contributors:
* David H. - Slack, @DavidH | GitHub, https://github.com/DavidHoltkamp1
* Nathan K. - Slack, @NathanKeller | GitHub, https://github.com/nkeller1
* Maria R. - Slack, @MariaRonauli | GitHub, https://github.com/mronauli
* Paul D. - Slack, @PaulDebevec | GitHub, https://github.com/PaulDebevec

# Welcome to Monster Shop!   
Ruby on Rails e-commerce website! 

## Learning Goals
* Many-to-many relationship setup
* Utilize partials and namespacing

### Rails
* Practice CRUD functionality and RESTfulness
* Implement professional grade user authenication through sessions, Bcrypt, params and filters

### ActiveRecord
* Demonstrate the use of ActiveRecord query calls to populate monolith with appropriate data

### Databases
* Understand one to many and many to many relational database techniques
* Practice schema creation and model testing to enforce database requirements

## Schema
<img width="954" src="https://i.ibb.co/2vqHbNN/Screen-Shot-2020-02-27-at-4-18-12-PM.png" alt="Screen-Shot-2020-02-27-at-4-18-12-PM" border="0"></a>

## Setup

1. Rails setup
  * `bundle install` (May need to delete the Gemfile.lock and run bundle install)
  * `rails db:{drop, create, migrate, seed}`
  * `rspec` to run the test suite
  * `rails s` to run the server

2. This is currently hosted on Heroku
  * https://hdkr-monster-shop.herokuapp.com/

3. Install software dependencies
- Rails 5.1.x
- PostgreSQL
- 'bcrypt' (authenication)

## Highlights

1. 100% model and feature test coverage via simplecov.

## User Roles available in this e-commerce solution

0. Visitor - this type of user is anonymously browsing our site and is not logged in, can place items in the cart but cannot check out.
1. Regular User - this user is registered and logged in to the application while performing their work; can place items in a cart and create an order by checking out with their cart.
2. Merchant Employee - this user works for a merchant. They can fulfill orders on behalf of their merchant. They also have the same permissions as a regular user (adding items to a cart and checking out).
3. Admin User - a registered user who has "superuser" access to all areas of the application; user is logged in to perform their work

## Order Progression in thie ecommerce solution

1. 'pending' means a user has placed items in a cart and "checked out" to create an order, merchants may or may not have fulfilled any items yet
2. 'packaged' means all merchants have fulfilled their items for the order, and has been packaged and ready to ship
3. 'shipped' means an admin has 'shipped' a package and can no longer be cancelled by a user
4. 'cancelled' - only 'pending' and 'packaged' orders can be cancelled
