module StubShell::TestHelpers
  def shell_context &block
    StubShell.current_context = StubShell::ShellContext.new &block
  end
end
