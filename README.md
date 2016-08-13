RestUri
===

[![Build Status](https://travis-ci.org/announce/rest_uri.svg?branch=master)](https://travis-ci.org/announce/rest_uri)
[![Gem Version](https://badge.fury.io/rb/rest_uri.svg)](https://rubygems.org/gems/rest_uri/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rest_uri'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rest_uri

## Usage

Simply,

```rb
tweet_url = RestUri.parse('https://twitter.com/jack/statuses/761304654147784704/photo/1')
tweet_url.status_id  #=> 761304654147784704
tweet_url.photo_id  #=> 1
```

To handle URL containing multibyte chars, run `gem install addressable` and

```rb
require 'addressable/uri'
require 'rest_uri'

rest_uri = RestUri.parse(
  'https://こんにちは.com/people/755950562227605504#foo',
  parser: Addressable::URI)
rest_uri.person_id  #=> 755950562227605504
```
