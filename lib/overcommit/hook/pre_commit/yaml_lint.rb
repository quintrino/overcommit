# frozen_string_literal: true

module Overcommit::Hook::PreCommit
  # Runs `YAMLLint` against any modified YAML files.
  #
  # @see https://github.com/adrienverge/yamllint
  class YamlLint < Base
    def run
      result = execute(command, args: applicable_files)

      if result.success?
        :pass
      elsif result.stdout.include?('error')
        [:fail, result.stdout]
      else
        [:warn, result.stdout]
      end
    end
  end
end
