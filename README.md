# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:
## Models
User - people
Session - logins
Organization - groups of people
Member - relationship between User and Organization
RankedList - every list ever
ListItem - A single entry of a RankedList
ListRank - the ranking for a single ListItem of a RankedList
ListRankHistory? - historical ranking of ListRank
ListItemData? - Extra meta-data for ListItem.

## Development 
  ### Priorities
    - Next
    - Soon
    - Pending
    - Later
  ### TODO
    #### Optimization
    - [ ] Tailwind class ordering
    #### Infrastructure
    - [x] Phlex Setup
    - [x] Figure out Phlex
    - [ ] Phlex Component Setup
    - [X] Nav Panel
    - [x] Member Home Page
    - [x] Guest/Member policy
    - [x] User Policy
    - [x] Guest User
    - [ ] Users views
    - [ ] ~~Routes constraints~~
    - [ ] Admin Section
    - [ ] authentication does not set session when allow_unauthenticated_access is true

    #### User Model
      - [x] rejoin with  
      - [ ] Has roles in many organizations (soon)</li>
    #### User Controller
      - [ ] Sign Up (later)</li>
      - [X] Sign In</li>
      - [ ] Sign Out (soon)</li>
                   
    #### Organization Model

  ### Testing TODO
    - [ ] rails 8 authentication testing helpers to set session use Current.user/Current.session ?
    - [ ] request specs that respect a session/current user
    - [ ] phlex Testing with full render