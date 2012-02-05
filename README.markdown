# StubShell [![Build Status](https://secure.travis-ci.org/stackbuilders/stub_shell.png)](http://travis-ci.org/stackbuilders/stub_shell)

StubShell helps you to test your libraries that interact with the system through the Kernel backquote and system methods.  
It does this by providing a DSL to describe the messages that you expect the shell to receive in the order that you expect
to receive them.  StubShell can be used to stub simple interactions, or ones that cause the system that you're working with
to change state.

## Installation

    gem install stub_shell

## Configuration

    require 'stub_shell'

    RSpec.configure do |config|
      config.include StubShell::TestHelpers
    end

## Usage

StubShell can handle simple cases where you want to stub a system call in Ruby or more complex interactions 
where commands may change the state and return values of subsequent commands.

### Simple Usage

You use StubShell simply by describing the commands that you want stubbed out, along with the value that they
should return in STDOUT and STDERR, as well as their exit status.

    it ... do
      stub_shell do
        command "ls /tmp/foobar" do
          stdout "hey there"
          stderr "some error"
          exitstatus 2
        end
      end
    end

By default, StubShell assumes that STDOUT and STDERR are nil, and that the exit status is 0 (success), so you 
can leave these options out if you want.

### Stubbing Complex Shell Interactions

You can stub more complex interactions with the shell, including cases where commands that you execute will
change the output of subsequent commands.

    stub_shell do
      command 'ls /tmp/foobar' do
        stdout 'yes, foobar exists'
      end
    
      command "rm /tmp/foobar" do
        stub_shell do
          command 'ls /tmp/foobar' do
            stderr 'the file no longer exists'
            exitstatus 2
          end
        end
      end
    end

StubShell starts looking for defined commands at the current level of the execution hierarchy, so if you
invoke the command to remove /tmp/foobar above, it will always look at the stub_shell context nested below
that command for matches to subsequent commands.  If no matching commands are found at that level, StubShell
searches recursively upwards in the tree for matches until it either finds one or it runs out of options and 
raises an error indicating that no matches were found.

### Regular Expression Matching of Commands

You can use regular expressions to match commands in StubShell.

    stub_shell do
      command /ls \/tmp.*foo/' do
        stdout 'yes, your directory exists'
      end
    end

### Additional Documentation

We suggest that you read the acceptance tests included with this library to help understand the 
way that it works.

## Authors

Justin Leitgeb (@jsl) and @itsmeduncan.

## Contribute

1. [Fork](http://help.github.com/forking/) stub_shell
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Create a [Pull Request](http://help.github.com/pull-requests/) from your branch

## License

See LICENSE
