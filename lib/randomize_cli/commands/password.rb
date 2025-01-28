# frozen_string_literal: true

module RandomizeCli
  class App

    # command
    desc "change the POSTGRES_PASSWORD in the env file"
    arg "new_password", optional: true
    command :password do |c|
      c.desc "the length of the password (ignored if new_password is given)"
      c.arg_name "new_length"
      c.default_value 16
      c.flag [ :l, :length ]

      c.action do |global, options, args|
        Execute.password(global, options, args)
      end
    end
  end
end
