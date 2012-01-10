module Betamax::TestHelpers
  def betamax script, &block
    Betamax.commands = script

    yield block

    raise "You didn't call these commands within the block: #{Betamax.commands.map(&:first).join(', ')}" unless Betamax.commands.empty?
    Betamax.commands = nil
  end
end
