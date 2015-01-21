# Porteiro

Porteiro is pundit for controllers. Policies are meant for authorizing requests through controller actions. 

## Features: 

- Supports policy fallback, so you can create a default policy that will be used in the absence of a 
defined policy. To use this, define a method in your controller called default_policy and add a string with the name
of the class to be used. E.g..

    def default_policy
      'ApplicationPolicy'
    end


## Installation

Add this line to your application's Gemfile:

    gem 'porteiro'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install porteiro

## Usage


## Contributing

1. Fork it ( https://github.com/[my-github-username]/porteiro/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
