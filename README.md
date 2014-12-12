[![Gem Version](https://badge.fury.io/rb/confickle.svg)](http://badge.fury.io/rb/confickle)

# Confickle #

Simplified access to config files.

## Installation ##

    gem install confickle

## Usage ##

### Basic ###

    require 'confickle'

    # All paths will be relative to the
    # path specified in the initializer
    c = Confickle.new("path/to/config")

    # Grab the contents of:
    #
    #   path/to/config/some/file.txt
    #
    puts c.contents("some", "file.txt")

    # Parse the file as JSON.  By default,
    # names will be symbolized.
    json = c.json("another", "file.json")
    puts json[:some_key]


### Slightly More Advanced ###

Guess what?  You can specify default behaviors when creating a Confickle instance:

    c = Confickle.new(
      root:            "path/to/config",
      symbolize_names: false
    )

Now, the JSON parser will no longer symbolize the names of the keys unless you tell it to:

    json_str = c.json("file.json")
    puts json_str["some_key"]

    json_sym = c.json("file.json", symbolize_names: true)
    puts json_sym[:some_key]
