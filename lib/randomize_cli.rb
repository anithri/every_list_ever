# frozen_string_literal: true

require_relative "./randomize_cli/version"
require "gli"
require 'faker'
module RandomizeCli
  class Error < StandardError; end
end

require_relative "./randomize_cli/utility"
require_relative "./randomize_cli/env_file"
require_relative "./randomize_cli/execute"
# require last
require_relative "./randomize_cli/app"
