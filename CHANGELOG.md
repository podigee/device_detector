# Change Log

## [0.7.0]
- [Issue #8](https://github.com/podigee/device_detector/issues/8) Fixed Mac OS X full version format. Thanks to [aaronchi](https://github.com/aaronchi) for reporting.

## [0.6.0]

- [Issue #7](https://github.com/podigee/device_detector/issues/7) Fixed missing name extraction from regexp. Thanks to [janxious](https://github.com/janxious) for reporting.
- Optimized performance of name and version extraction, by using the built-in memory cache
- Move specs from RSpec to the more lightweight Minitest

## [0.5.1]

- Added the minimum required Ruby version (>= 1.9.3)

## [0.5.0]

- Added rake task for automatic generation of supported and detectable clients and devices
- Updated detection rules
- Fixed device type detection, when type is specified on top level of a nested regex

