module Betamax::TestHelpers
  def shell_context &block
    Betamax.current_context = Betamax::ShellContext.new &block
  end
end
