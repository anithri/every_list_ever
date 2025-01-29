# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## setup
1. clone the repository & bundle
2. run bin/gen_env to generate .env
3. edit .env for any other values you want to change
4. run bin/gen_db_compose to generate the db.docker-compose.yml file
5. execute `bin/db start` to build a docker container with the values in .env
6. execute `bin/db setup` to run "rails db:create db:migrate db:seed"
7. if you use direnv, copy .envrc.sample to .envrc
8. execute `bin/dev`

## tools
* rails 8.0
* ruby 3.3.7
* rspec, factory_bot, database_cleaner, shoulda-matchers
* Phlex components, plus variants plugin
* clearance authentication
* pundit authorization
* simple-form
* tailwind

## Models
* User - people
* Session - logins
* Organization - groups of people
* OrganizationMember - relationship between User and Organization
* RankedList - every list ever
* ListItem - A single entry of a RankedList
* ListRank - the ranking for a single ListItem of a RankedList
* ListRankHistory? - historical ranking of ListRank
* ListItemData? - Extra meta-data for ListItem.

## Development 

  ### TODO
    #### Optimization
    - [ ] Tailwind class ordering
    #### Infrastructure
    - [x] Phlex Setup
    - [x] Figure out Phlex
    - [x] Phlex Component Setup
    - [X] Nav Panel
    - [x] Member Home Page & policy
    - [x] Guest Home Page & policy
    - [x] User Policy
    - [x] Organization Policy
    - [ ] Users views
    - [x] Routes constraints
    - [ ] Admin Section
    - [x] User model
    - [x] Organization model
    - [x] OrganizationMember model
    - [x] Update Organization Policy to account for organization roles
    - [ ] Extend Member Home to show more information
    - [ ] Extend Guest Home to show more information
    - [ ] Add list of members and roles in organization#show
    - [ ] Add list of organizations and roles in user#show
    - [ ] RankedList model
    - [ ] RankedList Policy
    - [ ] RankedList Views
    - [ ] ListItem model
    - [ ] ListItem form
    - [ ] ListItem card
    - [ ] ListItem row
    - [ ] ListRank model
    - [ ] ListRank voting component
    - [ ] ListRank 


