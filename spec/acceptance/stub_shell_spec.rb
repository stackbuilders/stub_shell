require 'spec_helper'

describe StubShell do
  describe "stubbing a command with backquote" do
    it "should set the correct value for STDOUT" do
      stub_shell do
        command "ls /tmp/foobar" do
          stdout "hey there"
        end
      end
      
      `ls /tmp/foobar`.should == 'hey there'
    end
    
    it "should have an exitstatus of 0 by default" do      
      stub_shell do
        command "ls /tmp/foobar" do
          stdout "hey there"
        end
      end
      
      `ls /tmp/foobar`
      $?.exitstatus.should == 0
    end
    
    it "should allow the user to set a non-zero exit status" do
      stub_shell do
        command "ls /tmp/foobar" do
          stdout "hey there"
          exitstatus 1
        end
      end
      
      `ls /tmp/foobar`
      $?.exitstatus.should == 1
    end
  end  
  
  describe "using a shell context after the shell state has been mutated" do
    it "should use the return value from the nested context" do
      stub_shell do
        command 'ls /tmp/foobar' do
          stdout 'yes, foobar exists'
        end

        command "rm /tmp/foobar" do
          stderr 1

          stub_shell do
            command 'ls /tmp/foobar' do
              stdout 'the file no longer exists'
            end
          end
        end
      end

      `ls /tmp/foobar`.should == 'yes, foobar exists'
      `rm /tmp/foobar`
      `ls /tmp/foobar`.should == 'the file no longer exists'
    end
    
    it "should find commands defined in a more general context even when some state has been mutated" do
      stub_shell do
        command 'ls /tmp/myfile' do
          stdout 'yes, your file exists'
        end

        command "rm /tmp/foobar" do
          stderr 1

          stub_shell do
            command 'ls /tmp/foobar' do
              stdout 'the file no longer exists'
            end
          end
        end
      end

      `rm /tmp/foobar`
      `ls /tmp/myfile`.should == 'yes, your file exists'
    end
  end
  
  describe "with Kernel#system" do
    it "should return true if the command succeeds (ie., has an exitstatus of 0)" do
      stub_shell { command('ls /tmp/stuff') { exitstatus 0 } }
      system('ls /tmp/stuff').should be_true
    end
    
    it "should return true if the command succeeds (ie., has a non-zero exit status)" do
      stub_shell { command('ls /tmp/stuff') { exitstatus 1 } }
      system('ls /tmp/stuff').should be_false
    end
  end
  
  describe "with a command having a regular expression" do
    it "should match a command matching the regular expression" do
      stub_shell do
        command /ls .*/ do
          stdout 'yes, your file exists'
        end
      end
      
      `ls /tmp/heythere`.should == 'yes, your file exists'
    end
  end
end
