# DeviceDetector

![Podigee DeviceDetector Travisci Badge](https://travis-ci.org/podigee/device_detector.svg)

DeviceDetector is a precise and fast user agent parser and device detector written in Ruby, backed by the largest and most up-to-date user agent database.

DeviceDetector will parse any user agent and detect the browser, operating system, device used (desktop, tablet, mobile, tv, cars, console, etc.), brand and model. DeviceDetector detects thousands of user agent strings, even from rare and obscure browsers and devices.

The DeviceDetector is optimized for speed of detection, by providing optimized code and in-memory caching.

This project originated as a Ruby port of the Universal Device Detection library.
You can find the original code here: https://github.com/piwik/device-detector.

## Disclaimer

This port does not aspire to be a one-to-one copy from the original code, but rather an adaptation for the Ruby language.

Still, our goal is to use the original, unchanged regex yaml files, in order to mutually benefit from updates and pull request to both the original and the ported versions.

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
user_agent = 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.17 Safari/537.36'
client = DeviceDetector.new(user_agent)

client.name # => 'Chrome'
client.full_version # => '30.0.1599.69'

client.os_name # => 'Windows'
client.os_full_version # => '8'

# For many devices, you can also query the device name (usually the model name)
client.device_name # => 'iPhone 5'
# Device types can be one of the following: smartphone, tablet, console, 
# portable media player, tv, car browser, camera
client.device_type # => 'smartphone'
```

`DeviceDetector` will return `nil` on all attributes, if the `user_agent` is unknown.
You can make a check to ensure the client has been detected:

```ruby
client.known? # => will return false if user_agent is unknown
```

### Memory cache

`DeviceDetector` will cache up 5,000 user agent strings to boost parsing performance.
You can tune the amount of keys that will get saved in the cache. You have to call this code **before** you initialize the Detector.

```ruby
DeviceDetector.configure do |config|
  config.max_cache_keys = 5_000 # increment this if you have enough RAM, proceed with care
end
```

If you have a Rails application, you can create an initializer, for example `config/initializers/device_detector.rb`.

## Benchmarks

We have measured the parsing speed of almost 200,000 non-unique user agent strings and compared the speed of DeviceDetector with the two most popular user agent parsers in the Ruby community, Browser and UserAgent.

### Testing machine specs

- MacBook Pro 15", Late 2013
- 2.6 GHz Intel Core i7
- 16 GB 1600 MHz DDR3

### Gem versions

- DeviceDetector - 0.5.1
- Browser - 0.8.0
- UserAgent - 0.13.1

### Code

```ruby
require 'device_detector'
require 'browser'
require 'user_agent'
require 'benchmark'

user_agent_strings = File.read('./tmp/user_agent_strings.txt').split("\n")

## Benchmarks

Benchmark.bm(15) do |x|
  x.report('device_detector') {
    user_agent_strings.each { |uas| DeviceDetector.new(uas).name }
  }
  x.report('browser') {
    user_agent_strings.each { |uas| Browser.new(ua: uas).name }
  }
  x.report('useragent') {
    user_agent_strings.each { |uas| UserAgent.parse(uas).browser }
  }
end
```

### Results

```
                      user     system      total        real
device_detector   1.180000   0.010000   1.190000 (  1.198721)
browser           2.240000   0.010000   2.250000 (  2.245493)
useragent         4.490000   0.020000   4.510000 (  4.500673)

                      user     system      total        real
device_detector   1.190000   0.020000   1.210000 (  1.201447)
browser           2.250000   0.010000   2.260000 (  2.261001)
useragent         4.440000   0.010000   4.450000 (  4.451693)

                      user     system      total        real
device_detector   1.210000   0.020000   1.230000 (  1.228617)
browser           2.220000   0.010000   2.230000 (  2.222565)
useragent         4.450000   0.000000   4.450000 (  4.452741)
```

## Detectable clients, bots and devices

Updated on 2015-03-17

### Bots

360Spider, Aboundexbot, Acoon, AddThis.com, aHrefs Bot, Alexa Crawler, Amorank Spider, Analytics SEO Crawler, archive.org bot, Ask Jeeves, Backlink-Ceck.de, BacklinkCrawler, Baidu Spider, BingBot, Blekkobot, BLEXBot Crawler, Bloglovin, Bountii Bot, Browsershots, Butterfly Robot, CareerBot, ccBot crawler, Cliqzbot, CloudFlare Always Online, CommaFeed, Dazoobot, Discobot, DotBot, Easou Spider, EMail Exractor, ExaBot, ExactSeek Crawler, Ezooms, Facebook External Hit, Feedbin, FeedBurner, Feedly, Feedspot, Fever, Genieo Web filter, Goo, Google PageSpeed Insights, Googlebot, Heritrix, HTTPMon, IIS Site Analysis, Kouio, Linkdex Bot, LinkedIn Bot, Mail.Ru Bot, Magpie-Crawler, MagpieRSS, Meanpath Bot, Mixrank Bot, MJ12 Bot, MojeekBot, NalezenCzBot, Netcraft Survey Bot, Netvibes, NewsBlur, NewsGator, NLCrawler, Omgili bot, Openindex Spider, OpenLinkProfiler, OpenWebSpider, PaperLiBot, Picsearch bot, Pingdom Bot, QuerySeekerSpider, Reddit Bot, Rogerbot, Screaming Frog SEO Spider, ScreenerBot, Semrush Bot, Sensika Bot, SEOENGBot, Seznam Bot, ShopWiki, SilverReader, SimplePie, SISTRIX Crawler, Sogou Spider, Soso Spider, Superfeedr Bot, Spinn3r, Sputnik Bot, Survey Bot, TinEye Crawler, Tiny Tiny RSS, TurnitinBot, TweetedTimes Bot, Tweetmeme Bot, Twitterbot, Uptime Robot, URLAppendBot, Visual Site Mapper Crawler, Voila Bot, W3C CSS Validator, W3C I18N Checker, W3C Link Checker, W3C Markup Validation Service, W3C MobileOK Checker, W3C Unified Validator, WeSEE:Search, WebbCrawler, Wotbox, YaCy, Yahoo! Slurp, Yandex Bot, Yeti/Naverbot, Youdao Bot, Yunyun Bot, Zookabot, ZumBot, Yottaa Site Monitor, Lycos, Inktomi Slurp, Speedy, ScoutJet, NetResearchServer, Scooter, Gigabot, Charlotte, Pompos, ichiro, PagePeeker, WebThumbnail, Willow Internet Crawler, EmailWolf, NetLyzer FastProbe, Bot, Nutch-based Bot, Generic Bot

### Clients

Internet Explorer, Sailfish Browser, Camino, Fennec, MicroB, Avant Browser, Amigo, Bunjalloo, Iceweasel, WebPositive, Pale Moon, CometBird, IceDragon, Flock, Kapiko, Swiftfox, Firefox, ANTGalio, Espial TV Browser, RockMelt, Fireweb Navigator, Netscape, Opera Mobile, Opera Mini, Opera Next, Opera, Rekonq, CoolNovo, Comodo Dragon, ChromePlus, Conkeror, Konqueror, Baidu Browser, Baidu Spark, Yandex Browser, Vivaldi, Midori, Mercury, Maxthon, Puffin, Iron, Epiphany, Liebao, Sogou Explorer, QQ Browser, Chrome Mobile, Chrome Mobile iOS, Chrome Frame, Chromium, Chrome, UC Browser, Tizen Browser, Palm Blazer, Palm Pre, wOSBrowser, Palm WebPro, Jasmine, Lynx, NCSA Mosaic, ABrowse, Amaya, Amiga Voyager, Amiga Aweb, Arora, Beonex, BlackBerry Browser, BrowseX, Charon, Cheshire, Dillo, Dolphin, Elinks, Firebird, Fluid, Galeon, Google Earth, HotJava, IBrowse, iCab, Sleipnir, Lunascape, IE Mobile, Kazehakase, Kindle Browser, K-meleon, Links, Openwave Mobile Browser, OmniWeb, Phoenix, Mobile Silk, MIUI Browser, Nokia Browser, Nokia OSS Browser, Nokia Ovi Browser, NetFront Life, NetFront, NetPositive, Obigo, Off By One, Oregano, Polaris, SEMC-Browser, Shiira, Snowshoe, Sunrise, WeTab Browser, Xiino, Android Browser, Mobile Safari, Safari, Akregator, Apple PubSub, FeedDemon, Feeddler RSS Reader, JetBrains Omea Reader, Liferea, NetNewsWire, NewsBlur Mobile App, NewsBlur, Newsbeuter, Pulp, ReadKit, Reeder, RSS Bandit, RSS Junkie, RSSOwl, Wget, curl, Python Requests, Python urllib, Java, Perl, Banshee, Clementine, iTunes, FlyCast, MediaMonkey, Miro, NexPlayer, Nightingale, QuickTime, Songbird, SubStream, VLC, Winamp, Windows Media Player, XBMC, Stagefright, AndroidDownloadManager, FeedR, WeChat, Sina Weibo, Outlook Express, Microsoft Outlook, Thunderbird, Airmail, Lotus Notes, Barca, Postbox, The Bat!

### Devices

3Q, Acer, Airness, Alcatel, Amoi, Apple, Archos, Arnova, Asus, Audiovox, Avvio, Axxion, BBK, BangOlufsen, Barnes & Noble, Becker, Beetel, BenQ, BenQ-Siemens, Bird, Blu, Bmobile, Capitel, Cat, Celkon, Cherry Mobile, CnM, Coby Kyros, Compal, ConCorde, Coolpad, Cowon, CreNova, Cricket, Crius Mea, Cube, DMM, Danew, Dbtel, Dell, Denver, Dicam, DoCoMo, Doogee, Dopod, E-Boda, Easypix, Ericsson, Ericy, Evertek, Ezio, Ezze, Fly, Gemini, Gigabyte, Gigaset, Gionee, Google, Gradiente, Grundig, HP, HTC, Haier, Hisense, Huawei, Humax, INQ, Ikea, Infinix, Inkti, Innostream, Intek, Intex, Inverto, Jiayu, Jolla, K-Touch, KDDI, KT-Tech, Karbonn, Kazam, Kindle, Konka, Kyocera, LCT, LG, Lanix, Lava, Lenco, Lenovo, Lexibook, Loewe, Logicom, MEU, Manta Multimedia, MediaTek, Medion, Memup, Metz, MicroMax, Microsoft, Mio, Mitsubishi, Mobistel, Motorola, Mpman, MyPhone, NEC, NGM, Newgen, Nexian, Nikon, Nintendo, Nokia, O2, OPPO, OUYA, Onda, Opsson, Orange, Oysters, PEAQ, Palm, Panasonic, Pantech, Philips, Polaroid, PolyPad, Positivo, Prestigio, Qilive, Qtek, Quechua, RIM, Ramos, Rikomagic, Rover, SFR, Sagem, Samsung, Sanyo, Sega, Selevision, Sendo, Sharp, Siemens, Smart, Smartfren, Softbank, Sony, Spice, Storex, Sumvision, SuperSonic, Symphony, T-Mobile, TCL, TIANYU, TVC, TechniSat, TechnoTrend, Tecno Mobile, Telefunken, Telit, Tesla, Thomson, TiPhone, Tolino, Toplux, Toshiba, Tunisie Telecom, UTStarcom, VK Mobile, Vertu, Vestel, Videocon, Videoweb, ViewSonic, Vitelcom, Voxtel, Web TV, WellcoM, Wiko, Wolder, Wonu, Woxter, Xiaomi, Yuandao, ZTE, Zonda, Zopo, bq, eTouch, i-mate, i-mobile, iBall, iBerry, iKoMo, iTel, phoneOne, teXet

## Maintainers

- Mati Sojka: https://github.com/yagooar
- Ben Zimmer: https://github.com/benzimmer

## Contributors

Thanks a lot to the following contributors:

- Peter Gao: https://github.com/peteygao

## Contributing

1. Open an issue and explain your feature request or bug before writing any code (this can save a lot of time, both the contributor and the maintainers!)
2. Fork the project (https://github.com/podigee/device_detector/fork)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request (compare with develop)
7. When adding new data to the yaml files, please make sure to open a PR in the original project, as well (https://github.com/piwik/device-detector)
