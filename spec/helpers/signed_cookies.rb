# frozen_string_literal: true
# https://sudogem.wordpress.com/2014/03/10/rspec-how-to-set-signed-cookies-in-rspec/
# create a signed_cookie method:
def signed_cookies(name, opts={})
  verifier = ActiveSupport::MessageVerifier.new(request.env["action_dispatch.secret_token".freeze])
  if opts[:value]
    @request.cookies[name] = verifier.generate(opts[:value])
  else
    verifier.verify(cookies[name])
  end
end
