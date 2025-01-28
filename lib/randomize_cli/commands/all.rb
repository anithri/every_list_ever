# frozen_string_literal: true

module RandomizeCli
  class App
    # command
    desc "do all other commands.  you cannot pass options or arguments to this command."
    command :all do |c|
      c.action do |global, options, args|
        Execute.all(global, options, args)
      end
    end
  end
end
