# Betamax [![Build Status](https://secure.travis-ci.org/stackbuilders/betamax.png)](http://travis-ci.org/stackbuilders/betamax)

## Installation

    gem install betamax

## Configuration

    require 'betamax'

    RSpec.configure do |config|
      config.include Betamax::TestHelpers
    end

## Usage

    it ... do
      betamax [['foo', ['my output', 127]]] do
        `foo`.should == 'my output'
        $?.exitstatus.should == 127
      end
    end

## Contribute

1. [Fork](http://help.github.com/forking/) betamax
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Create a [Pull Request](http://help.github.com/pull-requests/) from your branch

## License

See LICENSE
