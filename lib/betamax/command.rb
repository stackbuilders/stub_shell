module Betamax
  class Command
    FAKE_PROCESS_SCRIPT = File.join(File.dirname(__FILE__), '..', '..', 'bin', 'fake_process.sh')
    
    attr_reader :script
    
    def initialize(cmd, shell_command, return_stdout, script)
      @cmd           = cmd
      @shell_command = shell_command
      @return_stdout = return_stdout
      @script        = script.clone
    end
    
    def execute
      verify_valid_arguments!
      
      command = cast_arguments!      
      verify_valid_command! command.cmd      
      result = invoke_kernel_command! command
                          
      @return_stdout ? command.stdout : result
    end
    
    private
    
    def invoke_kernel_command! command
      Kernel.send(@shell_command, "#{FAKE_PROCESS_SCRIPT} '#{command.retval}'")
    end
    
    def verify_valid_arguments!
      raise "Tried to invoke '#{@cmd}' when Betamax was not configured" if Betamax.commands.nil?
      raise "You tried to invoke '#{@cmd}' but there are no commands defined in Betamax" if Betamax.commands.empty?      
    end
    
    def verify_valid_command!(current_command)
      puts 50.times{print "/"}, current_command, @cmd
      raise "You're not following the script!" unless @cmd == current_command
    end
    
    CommandValues = Struct.new(:cmd, :stdout, :retval)
    
    def cast_arguments!
      cset = @script.shift
      CommandValues.new(cset[0], cset[1][0], cset[1][1])
    end
  end
end