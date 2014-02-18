# Rspec::DoAction 

[![Build Status](https://travis-ci.org/sunteya/rspec-do_action.png?branch=master)](https://travis-ci.org/sunteya/rspec-do_action)
[![Code Climate](https://codeclimate.com/github/sunteya/rspec-do_action.png)](https://codeclimate.com/github/sunteya/rspec-do_action)
[![Dependency Status](https://gemnasium.com/sunteya/rspec-do_action.png)](https://gemnasium.com/sunteya/rspec-do_action)
[![Gem Version](https://badge.fury.io/rb/rspec-do_action.png)](http://badge.fury.io/rb/rspec-do_action)

add 'acton' and some useful methods for rspec one-liner syntax.

## Installation

Add this line to your application's Gemfile:

    gem 'rspec-do_action'

## Usage

```ruby
describe "invoke 'do_action' automatically" do
  subject(:result) { [] }
  action { result << 2 } # will invoke after all before hook run finished
  before { result << 1 }
  it { should eq [ 1, 2 ] }
end

describe "explicit invoke 'do_action'" do
  subject(:result) { [] }
  action { result << 2 }
  before { result << 1 }
  do_action
  before { result << 3 }
  
  it { should eq [ 1, 2, 3 ] }
end

describe "skip auto 'do_action' invoke" do
  action { raise RuntimeError }
  skip_do_action

  it { expect{ do_action }.to raise_error }
end
```

## Contributing

1. Fork it ( http://github.com/sunteya/rspec-do_action/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
