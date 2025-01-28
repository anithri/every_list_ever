# frozen_string_literal: true

module RandomizeCli
  class EnvFile
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def sub(key, value, show_value = false)
      orig = env.readlines
      to_change = orig.map do |line|
        line.start_with?(key) ? "#{key}='#{value}'\n" : line
      end
      env.write(to_change.join, 0)

      puts show_value ? "Updated #{key} to #{value} in #{env}\n" : "Updated #{key} in #{env}\n"
    end
  end
end
