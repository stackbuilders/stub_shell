module Betamax  
  class << self
    attr_accessor :commands
  end

  def self.run_command!(cmd, kernel_method, return_stdout)
    print "jajaja ", cmd
    command = Betamax::Command.new(cmd, kernel_method, return_stdout, Betamax.commands)
    
    return_value = command.execute
    Betamax.commands = command.script
    return_value
  end
  
  self.commands = nil
end

require 'betamax/test_helpers'
require 'betamax/command'

def `(cmd)
  print "printing from the overriden method ", cmd
  Betamax.run_command!(cmd, :`, true)
end

def system(cmd)
  Betamax.run_command!(cmd, :system, false)
end

