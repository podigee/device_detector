# DeviceDetector

This is a Ruby port of the Universal Device Detection library. You can find the original code here: [https://github.com/piwik/device-detector].

The Universal Device Detection library will parse any User Agent and detect the browser, operating system, device used (desktop, tablet, mobile, tv, cars, console, etc.), brand and model.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'device_detector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install device_detector

## Usage

```ruby
user_agent = 'foo'
client = DeviceDetector.new(user_agent)

client.name # => Chrome
client.full_version # => '30.0.1599.69'
client.known? # => true, will return false if user_agent is unknown

client.os_name # => Mac
client.os_full_version # => '10_8_5'
```

`DeviceDetector` will return `nil` on all attributes, if the `user_agent` is unknown.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/device_detector/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
