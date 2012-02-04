module StubShell
  class Command  
    attr_reader :context, :name, :result

    def initialize name, context, &block
      @name    = name
      @context = context
      @result  = Result.new

      instance_eval &block
    end

    def shell_context &block
      raise ArgumentError, "shell_context has already been defined for #{self}" if @shell_context
      @shell_context = ShellContext.new(self.context, &block)
    end

    def current_context
      @shell_context
    end

    def stdout output
      result.stdout = output
    end

    def stderr output
      result.stderr = output
    end

    def exitstatus code
      result.exitstatus = code
    end  
  end
end

