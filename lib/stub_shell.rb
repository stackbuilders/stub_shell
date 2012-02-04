module StubShell  
  class << self
    attr_accessor :current_context
  end
  
  self.current_context = nil
end

require 'stub_shell/result'
require 'stub_shell/command'
require 'stub_shell/shell'
require 'stub_shell/test_helpers'

def `(cmd)
  command, StubShell.current_context = StubShell.current_context.execute(cmd)
  super("#{File.join(File.dirname(__FILE__), '..', 'bin', 'fake_process.sh')} '#{command.result.exitstatus}'")
  command.result.stdout
end
