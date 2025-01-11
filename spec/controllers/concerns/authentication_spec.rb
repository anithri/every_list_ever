# Test: spec/controllers/concerns/authentication_spec.rb
# Src:  app/controllers/concerns/authentication.rb
# #
# RSpec.xdescribe Authentication, type: :controller do
#
#   context "when the user is unauthenticated" do
#     describe "allows access to" do
#
#       #  region standard routes
#       it "root_path GET /" do
#         # always a redirect
#         # root may return a redirect instead, so we need to check for that
#       end
#       it "public_route GET /public_route" do
#         # allows access
#       end
#       # endregion
#
#       # region passwords
#       it "new_password GET /passwords/new" do
#         # this is the password reset form
#         # might redirect for authenticated user
#       end
#       it "password PUT /passwords/:token" do
#         # this is the password reset action
#       end
#       # endregion
#
#       # region sessions
#       it "new_session GET /sessions/new" do
#         # this is the logon form
#       end
#       it "session put /sessions/new" do
#         # this is the logon form action
#       end
#       # endregion
#       #
#     end
#
#     describe "denies access to" do
#       # region standard routes
#       it "protected_route GET /protected_route" do
#         # denies access
#       end
#       # endregion
#
#       # region passwords
#       # endregion
#
#       # region session
#       it "session DELETE /sessions/new" do
#         # this is the logout action.  no related form
#       end
#       # endregion
#     end
#
#   end
#
#   context "when the user is authenticated" do
#     describe "allows access to" do
#
#       #  standard routes
#       it "root_path GET /" do
#         # always a redirect
#         # root may return a redirect instead, so we need to check for that
#       end
#       it "public_route GET /public_route" do
#         # allows access
#       end
#       # endregion
#
#       # region passwords
#       it "new_password GET /passwords/new" do
#         # this is the password reset form
#         # might redirect for authenticated user
#       end
#       # endregion
#
#       # region sessions
#       it "session DELETE /sessions/new" do
#         # this is the logout action.  no related form
#       end
#       #
#     end
#
#     describe "denies access to" do
#       # region standard routes
#       it "protected_route GET /protected_route" do
#         # denies access
#       end
#       # endregion
#
#       # region passwords
#
#       # endregion
#
#       # region session
#       it "session DELETE /sessions/new" do
#         # this is the logout action.  no related form
#       end
#       # endregion
#     end
#   end
# end
  # Test Doc
  # 1. We are testing the module not the controller with the module controller.
  #    This will still require us to use controller methods but we will largely
  #    be testing the response_code and not the response body.
  # 2. A way to control the test environments we need:
  #    - be able to control the encoding and content of the session[:session_id] cookie.
  #      not being able presents the issues on not be able to test
  #    -
  #    environment   Current.session before the before_action :require_authentication
  #     * Having and using a valid session[:session_id] cookie
  #     * stub and wrap(?) `resume_session` so we can set Current.session first
  #     * stub and wrap(?) `authenticated?` so we can set Current.session first
  #     * any other ideas?
  # 2.
  # 3. there are 3 types of users to test = unauthenticated, authenticated, and admin
  # 4. there are 5 types of routes to test = /, /passwords, /sessions, /a_protected_route, /public_route
  #   * if the passwords and session test work, th

  # Remember!
  # 1. we are testing the Authentication module, not the whole controller package
  # 2.
  # 3.
