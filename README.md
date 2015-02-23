# DeviceDetector

This is a Ruby port of the Universal Device Detection library.
You can find the original code here: [https://github.com/piwik/device-detector].

The Universal Device Detection library will parse any User Agent and detect
the browser, operating system, device used (desktop, tablet, mobile, tv, cars,
console, etc.), brand and model.

## Disclaimer

This port does not aspire to be a one-to-one copy from the original code, but
rather an adaptation for the Ruby language.

Still, our goal is to use the original, unchanged regex yaml files, in order to
mutually benefit from updates and pull request to both the original and the
ported versions.

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

client.name # => 'Chrome'
client.full_version # => '30.0.1599.69'
client.known? # => true, will return false if user_agent is unknown

client.os_name # => 'Mac'
client.os_full_version # => '10_8_5'

# For many devices, you can also query the device name (usually the model name)
# Look into regexes/devices/mobiles.yml to see what devices can be detected
client.device_name # => 'iPhone 5'
client.device_type # => 'smartphone'
```

`DeviceDetector` will return `nil` on all attributes, if the `user_agent` is unknown.

### Memory cache

`DeviceDetector` will cache up 5,000 user agent strings to boost parsing performance.
You can tune the amount of keys that will get saved in the cache:

```ruby
# You have to call this code **before** you initialize the Detector
DeviceDetector.configure do |config|
  config.max_cache_keys = 20_000 # if you have enough RAM, proceed with care
end
```

## Maintainers

- Mati Sojka: https://github.com/yagooar
- Ben Zimmer: https://github.com/benzimmer

## Contributors

Thanks a lot to the following contributors:

- Peter Gao: https://github.com/peteygao

## Contributing

1. Fork it ( https://github.com/podigee/device_detector/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
