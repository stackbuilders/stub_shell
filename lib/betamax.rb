module Betamax  
  class << self
    attr_accessor :current_context
  end
  
  self.current_context = nil
end

require 'betamax/result'
require 'betamax/command'
require 'betamax/shell_context'
require 'betamax/test_helpers'

def `(cmd)
  command, Betamax.current_context = Betamax.current_context.execute(cmd)
  super("#{File.join(File.dirname(__FILE__), '..', 'bin', 'fake_process.sh')} '#{command.result.exitstatus}'")
  command.result.stdout
end
