module Betamax
  class Result
    attr_accessor :stdout, :stderr, :exitstatus

    def initialize
      @exitstatus = 0
    end
  end
end

