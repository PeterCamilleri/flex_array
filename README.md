# The flex array gem.

This project contains the Ruby FlexArray gem. A gem used to facilitate the
creation and processing of multi-dimensional arrays in a flexible manner.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flex_array'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flex_array

The flex_array gem itself is found at: ( https://rubygems.org/gems/flex_array )

## Usage

Using flex_array in an application can be as simple as:
```ruby
require 'flex_array'

arr1 = FlexArray.new([10,10])                       # 10 by 10 of nil
arr2 = FlexArray.new([10,10], 0)                    # 10 by 10 of zero
arr2 = FlexArray.new([1..12,1..12]) {|i| i[0]*i[1]} # Times table.

arr2[4..5,4..5] = 42 #Set the middle of the array.

```

A lot more information on the operation of this gem may be found in the docs
folder in the Flex_Array_UG, available in both open office (.odt) and portable
document (.pdf) formats.

## Contributing

#### Plan A

1. Fork it ( https://github.com/PeterCamilleri/flex_array/fork )
2. Switch to the development branch ('git branch development')
3. Create your feature branch ('git checkout -b my-new-feature')
4. Commit your changes ('git commit -am "Add some feature"')
5. Push to the branch ('git push origin my-new-feature')
6. Create new Pull Request

#### Plan B

Go to the GitHub repository and raise an issue calling attention to some
aspect that could use some TLC or a suggestion or an idea.
