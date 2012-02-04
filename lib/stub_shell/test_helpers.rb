module StubShell
  module TestHelpers
    def stub_shell &block
      StubShell.current_context = StubShell::Shell.new &block
    end
  end
end
