Clearance.configure do |config|
  config.cookie_domain = "localhost"
  config.cookie_expiration = lambda { |cookies| 1.year.from_now.utc }
  config.cookie_name = "remember_token"
  config.cookie_path = "/"
  config.routes = false
  config.httponly = true
  config.mailer_sender = "reply@example.com"
  config.password_strategy = Clearance::PasswordStrategies::BCrypt
  config.redirect_url = "/member"
  config.url_after_destroy = "/guest"
  config.url_after_denied_access_when_signed_out = "/sign_ins/new"
  config.rotate_csrf_on_sign_in = true
  config.same_site = nil
  config.secure_cookie = Rails.configuration.force_ssl
  config.signed_cookie = false
  config.sign_in_guards = []
  config.user_model = "User"
  config.parent_controller = "ApplicationController"
  config.sign_in_on_password_reset = false
end
