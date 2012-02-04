module StubShell
  class Command  
    attr_reader :context, :result, :match

    def initialize match, context, &block
      @match    = match
      @context = context
      @result  = Result.new

      instance_eval &block
    end

    def stub_shell &block
      raise ArgumentError, "stub_shell has already been defined for #{self}" if @stub_shell
      @stub_shell = Shell.new(self.context, &block)
    end

    def matches? input_string
      case match
      when String
        input_string == match
      when Regexp
        !!(match.match input_string)
      end
    end
    
    def current_context
      @stub_shell
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

