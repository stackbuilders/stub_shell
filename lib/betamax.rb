module Betamax  
  class << self
    attr_accessor :commands
  end
  
  def self.call_shell_command(cmd, shell_command, return_stdout)  
  end

  self.commands = nil
end

require 'betamax/test_helpers'
require 'betamax/command'

def `(cmd)
  Betamax::Command.new(cmd, :`, true).execute
end

def system(cmd)
  Betamax::Command.new(cmd, :system, false).execute
end

