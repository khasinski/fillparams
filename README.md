# FillParams

[![Gem Version](https://badge.fury.io/rb/fillparams.svg)](http://badge.fury.io/rb/fillparams)
[![Code Climate](https://codeclimate.com/github/khasinski/fillparams.png)](https://codeclimate.com/github/khasinski/fillparams)
[![Build Status](https://travis-ci.org/khasinski/fillparams.svg?branch=master)](https://travis-ci.org/khasinski/fillparams)
[![Coverage](https://codeclimate.com/github/khasinski/fillparams/coverage.png)](https://codeclimate.com/github/khasinski/fillparams)
[![GetBadges Game](https://khasinski-fillparams.getbadges.io/shield/company/khasinski-fillparams)](https://khasinski-fillparams.getbadges.io/?ref=shield-game)

This tool allows you to manage ignored YAML parameters in your config files. 
It is inspired by [Incenteev ParameterHandler](https://github.com/Incenteev/ParameterHandler).

## Installation

Add this line to your application's Gemfile:

    gem 'fillparams'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fillparams

## Usage

By default, the dist file is assumed to be in the same place as the parameters
file, suffixed by ``.dist``.

The script handler will ask you interactively for parameters which are missing
in the parameters file, using the value of the dist file as default value.
All prompted values are parsed as inline YAML, to allow you to define ``true``,
``false``, ``null`` or numbers easily.

If fillparams is run in a non-interactive mode, the values of the dist file
will be used for missing parameters.

**Warning:** This parameters handler will overwrite any comments or spaces into
your parameters.yml file so handle with care. If you want to give format
and comments to your parameter's file you should do it on your dist version.

Basic usage is:

    $ fillparams
    
This will look for a file called `init.yml`, which should contain:

    files:
        - some_config.yml
        - config/database.yml
        - more_configs.yml
        
fillparams will look for each of those files and a corresponding ``.dist`` file (ex. ``config/database.yml.dist``),
go through parameters and ask for the missing ones. Check ``fillparams --help`` for more options. 

**Important:** fillparams will ask for parameters that are strings, numbers, arrays, nulls (nils) and booleans. For
hashes it will go deeper until it finds something to work on.

For example in file ``database.yml.dist``

    development:
        username: dbuser
        host: localhost
        fancy_options: 
            - a
            - b
            - c

it will ask for `username`, `host` and `fancy_options`, it **won't** ask for `development` itself as it can go deeper into nested options.

## Contributing

1. Fork it ( https://github.com/khasinski/fillparams/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
