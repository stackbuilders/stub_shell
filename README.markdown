# StubShell [![Build Status](https://secure.travis-ci.org/stackbuilders/stub_shell.png)](http://travis-ci.org/stackbuilders/stub_shell)

## Installation

    gem install stub_shell

## Configuration

    require 'stub_shell'

    RSpec.configure do |config|
      config.include StubShell::TestHelpers
    end

## Usage

    it ... do
      stub_shell [['foo', ['my output', 127]]] do
        `foo`.should == 'my output'
        $?.exitstatus.should == 127
      end
    end

## Contribute

1. [Fork](http://help.github.com/forking/) stub_shell
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Create a [Pull Request](http://help.github.com/pull-requests/) from your branch

## License

See LICENSE
