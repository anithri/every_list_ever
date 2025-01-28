
# frozen_string_literal: true

module RandomizeCli
  class App
    # command
    desc "change the POSTGRES_USER in the env file"
    arg "new_user", optional: true
    command :user do |c|
      c.action do |global, _options, args|
        Execute.user(global, _options, args)
      end
    end
  end
end
