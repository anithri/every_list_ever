Rails.application.routes.draw do
  # get /password/new forgot password form
  # post /password forgot password target redirects to /new
  # get /password/new change_password form
  # put /password target for change_password

  get "/forgot_password" => "password#new", as: "forgot_password"
  get "/change_password" => "password#edit", as: "change_password"
  put "/change_password" => "password#update", as: "update_password"

  # resource :password, controller: "password", except: [ :destroy, :show ], path_names: { new: "sign_in" }
  # resolve("Password") { [ :password ] }

  # get /sign_in/new "login form"
  # post /sign_in # "sign_in action"
  # delete /sign_in # sign_in logout
  # get "/sign_in" => "sign_in#new"
  # post "/sign_in" => "sign_in#create"
  # delete "/sign_in" => "sign_in#destroy"
  resolve("SignIn") { [ :sign_in ] }
  resource :sign_in, only: [ :new, :create, :destroy ], controller: :sign_in

  constraints Clearance::Constraints::SignedOut.new do
    resources :users, controller: "clearance/users", only: [ :create ] do
      resource :password,
               controller: "clearance/passwords",
               only: [ :edit, :update ]
    end

    get "/sign_up" => "clearance/users#new", as: :sign_up

    get "/guest" => "guests#home", as: :guests_home
    get "/*", to: redirect("/sign_in")
  end

  constraints Clearance::Constraints::SignedIn.new do
    resources :users, except: [ :new, :create ]
    resources :organizations
    # delete "/sign_in" => "clearance/sessions#destroy", as: "sign_in"
    get "member" => "members#home", as: :members_home
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # root is last
  root to: "pages#root"
end

# == Route Map
#
#                                   Prefix Verb   URI Pattern                                                                                       Controller#Action
#                                                 /assets                                                                                           Propshaft::Server
#                                passwords POST   /passwords(.:format)                                                                              clearance/passwords#create
#                             new_password GET    /passwords/new(.:format)                                                                          clearance/passwords#new
#                                  sign_in POST   /sign_in(.:format)                                                                                clearance/sessions#create
#                       edit_user_password GET    /users/:user_id/password/edit(.:format)                                                           clearance/passwords#edit
#                            user_password PATCH  /users/:user_id/password(.:format)                                                                clearance/passwords#update
#                                          PUT    /users/:user_id/password(.:format)                                                                clearance/passwords#update
#                                    users POST   /users(.:format)                                                                                  clearance/users#create
#                                  sign_in GET    /sign_in(.:format)                                                                                clearance/sessions#new
#                                 sign_in DELETE /sign_in(.:format)                                                                               clearance/sessions#destroy
#                                  sign_up GET    /sign_up(.:format)                                                                                clearance/users#new
#                                          GET    /users(.:format)                                                                                  users#index
#                                          POST   /users(.:format)                                                                                  users#create
#                                 new_user GET    /users/new(.:format)                                                                              users#new
#                                edit_user GET    /users/:id/edit(.:format)                                                                         users#edit
#                                     user GET    /users/:id(.:format)                                                                              users#show
#                                          PATCH  /users/:id(.:format)                                                                              users#update
#                                          PUT    /users/:id(.:format)                                                                              users#update
#                                          DELETE /users/:id(.:format)                                                                              users#destroy
#                            organizations GET    /organizations(.:format)                                                                          organizations#index
#                                          POST   /organizations(.:format)                                                                          organizations#create
#                         new_organization GET    /organizations/new(.:format)                                                                      organizations#new
#                        edit_organization GET    /organizations/:id/edit(.:format)                                                                 organizations#edit
#                             organization GET    /organizations/:id(.:format)                                                                      organizations#show
#                                          PATCH  /organizations/:id(.:format)                                                                      organizations#update
#                                          PUT    /organizations/:id(.:format)                                                                      organizations#update
#                                          DELETE /organizations/:id(.:format)                                                                      organizations#destroy
#                       rails_health_check GET    /up(.:format)                                                                                     rails/health#show
#                             members_home GET    /member(.:format)                                                                                 members#home
#                              guests_home GET    /guest(.:format)                                                                                  guests#home
#                                     root GET    /                                                                                                 pages#root
#         turbo_recede_historical_location GET    /recede_historical_location(.:format)                                                             turbo/native/navigation#recede
#         turbo_resume_historical_location GET    /resume_historical_location(.:format)                                                             turbo/native/navigation#resume
#        turbo_refresh_historical_location GET    /refresh_historical_location(.:format)                                                            turbo/native/navigation#refresh
#            rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
#               rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
#            rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
#      rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
#            rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
#             rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
#           rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
#                                          POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
#        new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                                      rails/conductor/action_mailbox/inbound_emails#new
#            rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
# new_rails_conductor_inbound_email_source GET    /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
#    rails_conductor_inbound_email_sources POST   /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
#    rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
# rails_conductor_inbound_email_incinerate POST   /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)                            rails/conductor/action_mailbox/incinerates#create
#                       rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#                 rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                          GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#                rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
#          rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                          GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#                       rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#                update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#                     rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create
