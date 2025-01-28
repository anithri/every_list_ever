# frozen_string_literal: false

module RandomizeCli

  # responsible for defining and running the GLI app
  class App
    extend GLI::App

    program_desc "insert random values into .env to reset database"

    version RandomizeCli::VERSION

    subcommand_option_handling :normal
    arguments :strict
    synopsis_format :terminal

    accept(Pathname) do |string|
      Pathname.new(string).expand_path
    end

    # global options
    desc "the path to the .env file"
    default_value Pathname.new("./.env")
    arg_name "<path_to_env_file>"
    flag [ :e, :env ], type: Pathname

    pre do |global, command, options, args|
      if global[:env].exist?
        global[:env_file] = EnvFile.new global[:env]
      else
        exit_now! "env file not found", 10
      end
    end
  end
end

require_relative "./commands/all"
require_relative "./commands/password"
require_relative "./commands/port"
require_relative "./commands/secret"
require_relative "./commands/user"
