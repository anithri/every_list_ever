# frozen_string_literal: true

module RandomizeCli
  class App
    # command
    desc "change the POSTGRES_PASSWORD, POSTGRES_PORT, and POSTGRES_USER in the env file"
    command :secret do |c|
      c.action do |global, options, args|
        Execute.secret(global, options, args)
      end
    end
  end
end
