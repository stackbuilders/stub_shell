module Betamax  
  class << self
    attr_accessor :commands
  end
  
  self.commands = nil
end

require 'betamax/test_helpers'

def `(cmd)
  cset = Betamax.commands.shift

  if cmd == cset[0]
    super("#{File.join(File.dirname(__FILE__), '..', 'bin', 'fake_process.sh')} '#{cset[1][0]}' '#{cset[1][1]}'")
  else
    raise "You're not following the script!"
  end
end