require 'spec_helper'

describe Betamax do
  describe "stubbing commands in the correct order" do
    it "should return the correct string and exit code with one command" do
      betamax [['foo', ['my output', 127]]] do
        `foo`.should == 'my output'
        $?.exitstatus.should == 127
      end
    end

    it "should return the correct string and exit code with two commands" do
      betamax [['foo', ['my output', 125]], ['bar', ['second output', 127]]] do
        `foo`
        `bar`.should == 'second output'
        $?.exitstatus.should == 127
      end
    end

    it "should raise an exception when the script is not followed" do
      betamax [['bar', ['my output', 100]]] do
        lambda { `foo` }.should raise_exception
      end
    end
    
    it "should raise an error if all commands are not invoked" do
      lambda {
        betamax [['foo', ['my output', 100]], ['bar', ['hey there', 55]]] do
          `foo`
        end
      }.should raise_exception
    end
  end
end
