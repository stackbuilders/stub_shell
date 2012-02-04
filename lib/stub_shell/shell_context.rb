module StubShell
  class ShellContext
    attr_reader :parent_context

    def initialize parent_context = nil, &block
      @parent_context  = parent_context
      @commands        = [ ]

      instance_eval &block
    end

    def command name, &block
      @commands << Command.new(name, self, &block)
    end

    # Resolves the requested command and returns the command definition and
    # the context from which to execute the next command.
    def execute command_string
      resolved_command = resolve(command_string)
      [resolved_command, resolved_command.current_context || self]
    end

    protected

    # Look in current context and recursively through any available parent contexts to
    # find definition of command. An Exception is raised if no implementation of command
    # is found.
    def resolve command_string
      if detected_command = @commands.detect{|cmd| cmd.name == command_string }
        detected_command
      elsif parent_context
        parent_context.resolve(command_string)
      else
        raise "Command #{command_string} could not be resolved from the current context."
      end
    end  
  end
end

