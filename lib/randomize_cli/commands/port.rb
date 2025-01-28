# frozen_string_literal: true

module RandomizeCli
  class App
    # arguments
    desc "change the POSTGRES_PORT in the env file"

    # command
    command :port do |c|
      c.desc "the range we will chose port from"
      c.default_value 49152
      c.flag [:r, :from ], type: Integer

      c.desc "the end of the range we will chose port from"
      c.default_value 65535
      c.flag [:t, :to ], type: Integer

      c.action do |global, options, args|
        Execute.port(global, options, args)
      end
    end
  end
end
