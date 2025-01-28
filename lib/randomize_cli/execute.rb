# frozen_string_literal: true

module RandomizeCli
  ALL_OPTS = {
    length: 16,
    from: 49152,
    to: 65535
  }

  class Execute
    def self.password(global, opts, args)
      key = "POSTGRES_PASSWORD"
      value = Utility.token(args[0], opts[:length])
      global[:env_file].sub key, value
    end

    def self.port(global, opts, _args)
      key = "POSTGRES_PORT"
      value = Utility.port(opts[:from], opts[:to])
      global[:env_file].sub key, value, :show_value
    end

    def self.user(global, _opts, args)
      key = "POSTGRES_USER"
      value = Utility.username(args[0])
      global[:env_file].sub key, value, :show_value
    end

    def self.secret(global, _opts, _args)
      key = "SECRET_KEY_BASE"
      value = Utility.secret_key_base
      global[:env_file].sub key, value
    end

    def self.all(global, _opts, args)
      Execute.password(global, ALL_OPTS, args)
      Execute.port(global, ALL_OPTS, args)
      Execute.user(global, ALL_OPTS, args)
      Execute.secret(global, ALL_OPTS, args)
    end
  end
end
