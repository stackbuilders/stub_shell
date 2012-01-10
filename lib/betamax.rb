module Betamax  
  class << self
    attr_accessor :commands
  end
  
  self.commands = nil
end

require 'betamax/test_helpers'

def `(cmd)
  raise "Tried to invoke '#{cmd}' when Betamax was not configured" if Betamax.commands.nil?
  raise "You tried to invoke '#{cmd}' but there are no commands defined in Betamax" if Betamax.commands.empty?

  cset = Betamax.commands.shift

  if cmd == cset[0]
    super("#{File.join(File.dirname(__FILE__), '..', 'bin', 'fake_process.sh')} '#{cset[1][1]}'")
    cset[1][0]
  else
    raise "You're not following the script!"
  end
end