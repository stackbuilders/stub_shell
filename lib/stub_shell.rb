require 'stub_shell/result'
require 'stub_shell/command'
require 'stub_shell/shell'
require 'stub_shell/test_helpers'

module StubShell  
  class << self
    attr_accessor :current_context
    
    def run_command cmd
      command, StubShell.current_context = StubShell.current_context.execute(cmd)
      Kernel.send(:`, "#{File.join(File.dirname(__FILE__), '..', 'bin', 'fake_process.sh')} '#{command.result.exitstatus}'")
      command
    end
  end
  
  self.current_context = nil
end

def `(cmd)
  StubShell.run_command(cmd).result.stdout
end

def system(cmd)
  StubShell.run_command(cmd).result.exitstatus == 0
end