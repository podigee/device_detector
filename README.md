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
# Device types can be one of the following: desktop, smartphone, tablet, console, 
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

Updated on 2016-07-16

### Bots

360Spider, Aboundexbot, Acoon, AddThis.com, ADMantX, aHrefs Bot, Alexa Crawler, Amorank Spider, Analytics SEO Crawler, Applebot, archive.org bot, Ask Jeeves, Backlink-Ceck.de, BacklinkCrawler, Baidu Spider, BazQux Reader, BingBot, Blekkobot, BLEXBot Crawler, Bloglovin, Blogtrottr, Bountii Bot, Browsershots, BUbiNG, Butterfly Robot, CareerBot, ccBot crawler, Charlotte, Cliqzbot, CloudFlare Always Online, CommaFeed, Cốc Cốc Bot, Daum, Dazoobot, Discobot, Domain Re-Animator Bot, DotBot, Easou Spider, EMail Exractor, EmailWolf, ExaBot, ExactSeek Crawler, Ezooms, Facebook External Hit, Feed Wrangler, Feedbin, FeedBurner, Feedly, Feedspot, Fever, Generic Bot, Genieo Web filter, Gigabot, Gluten Free Crawler, Gmail Image Proxy, Goo, Google PageSpeed Insights, Google Partner Monitoring, Googlebot, Heritrix, HTTPMon, HubPages, ICC-Crawler, ichiro, IIS Site Analysis, Inktomi Slurp, Kouio, Larbin web crawler, Linkdex Bot, LinkedIn Bot, LTX71, Lycos, Magpie-Crawler, MagpieRSS, Mail.Ru Bot, Meanpath Bot, Mixrank Bot, MJ12 Bot, MojeekBot, Monitor.Us, NalezenCzBot, Netcraft Survey Bot, NetLyzer FastProbe, NetResearchServer, Netvibes, NewsBlur, NewsGator, NLCrawler, Nutch-based Bot, Omgili bot, Openindex Spider, OpenLinkProfiler, OpenWebSpider, Orange Bot, Outbrain, PagePeeker, PaperLiBot, PHP Server Monitor, Picsearch bot, Pingdom Bot, Pinterest, Pompos, QuerySeekerSpider, Reddit Bot, Rogerbot, ROI Hunter, Scooter, ScoutJet, Scrapy, Screaming Frog SEO Spider, ScreenerBot, Semrush Bot, Sensika Bot, SEOENGBot, Server Density, Seznam Bot, ShopWiki, SilverReader, SimplePie, SISTRIX Crawler, Site24x7 Website Monitoring, Skype URI Preview, Slackbot, Sogou Spider, Soso Spider, Speedy, Spinn3r, Sputnik Bot, Superfeedr Bot, Survey Bot, TelgramBot, TinEye Crawler, Tiny Tiny RSS, TurnitinBot, TweetedTimes Bot, Tweetmeme Bot, Twitterbot, Uptime Robot, URLAppendBot, Visual Site Mapper Crawler, W3C CSS Validator, W3C I18N Checker, W3C Link Checker, W3C Markup Validation Service, W3C MobileOK Checker, W3C Unified Validator, WebbCrawler, WebSitePulse, WebThumbnail, WeSEE:Search, Willow Internet Crawler, Wotbox, YaCy, Yahoo Gemini, Yahoo! Cache System, Yahoo! Link Preview, Yahoo! Slurp, Yandex Bot, Yeti/Naverbot, Yottaa Site Monitor, Youdao Bot, Yourls, Yunyun Bot, Zao, Zookabot, ZumBot

### Clients

360 Browser, 360 Phone Browser, ABrowse, Airmail, Akregator, Amaya, Amiga Aweb, Amiga Voyager, Amigo, Android Browser, AndroidDownloadManager, ANT Fresco, ANTGalio, Apple PubSub, Arora, Atomic Web Browser, Avant Browser, Baidu Browser, Baidu Spark, Banshee, Barca, Beonex, BlackBerry Browser, Boxee, Brave, BrowseX, Bunjalloo, Camino, Charon, Cheshire, Chrome, Chrome Frame, Chrome Mobile, Chrome Mobile iOS, ChromePlus, Chromium, Clementine, Coc Coc, CometBird, Comodo Dragon, Conkeror, CoolNovo, curl, Deepnet Explorer, Dillo, Dolphin, Element Browser, Elinks, Epiphany, Espial TV Browser, Facebook, FeedDemon, Feeddler RSS Reader, FeedR, Fennec, Firebird, Firefox, Fireweb, Fireweb Navigator, Flock, Fluid, FlyCast, Galeon, Google Earth, Google Play Newsstand, Google Plus, Guzzle (PHP HTTP Client), HotJava, IBrowse, iCab, IceDragon, Iceweasel, IE Mobile, Instacast, Internet Explorer, Iron, iTunes, Jasmine, Java, JetBrains Omea Reader, Jig Browser, K-meleon, Kapiko, Kazehakase, Kindle Browser, Kodi, Konqueror, Kylo, LG Browser, Liebao, Liferea, Line, Links, Lotus Notes, LuaKit, Lunascape, Lynx, MailBar, Maxthon, MediaMonkey, Mercury, MicroB, Microsoft Edge, Microsoft Outlook, Midori, Miro, MIUI Browser, Mobile Safari, Mobile Silk, NCSA Mosaic, NetFront, NetFront Life, NetNewsWire, NetPositive, Netscape, Newsbeuter, NewsBlur, NewsBlur Mobile App, NexPlayer, Nightingale, Nokia Browser, Nokia OSS Browser, Nokia Ovi Browser, Obigo, Odyssey Web Browser, Off By One, OmniWeb, ONE Browser, Openwave Mobile Browser, Opera, Opera Mini, Opera Mobile, Opera Next, Oregano, Otter Browser, Outlook Express, Pale Moon, Palm Blazer, Palm Pre, Palm WebPro, Palmscape, Perl, Phoenix, Pinterest, Polaris, Postbox, Puffin, Pulp, Python Requests, Python urllib, QQ Browser, QuickTime, ReadKit, Reeder, Rekonq, RockMelt, RSS Bandit, RSS Junkie, RSSOwl, Safari, Sailfish Browser, Samsung Browser, SEMC-Browser, Seraphic Sraf, Shiira, Sina Weibo, Skyfire, Sleipnir, Snowshoe, Sogou Explorer, Songbird, Stagefright, Stringer, SubStream, Sunrise, SuperBird, Swiftfox, The Bat!, Thunderbird, Tizen Browser, TweakStyle, UC Browser, Vision Mobile Browser, Vivaldi, VLC, WebPositive, WeChat, WeTab Browser, Wget, WhatsApp, Winamp, Windows Media Player, wOSBrowser, XBMC, Xiino, Yandex Browser, YouTube

### Devices

3Q, Acer, Ainol, Airness, Airties, Alcatel, Allview, Altech UEC, Amazon, Amoi, Apple, Archos, Arnova, ARRIS, Asus, Audiovox, Avvio, Axxion, BangOlufsen, Barnes & Noble, Becker, Beetel, BenQ, BenQ-Siemens, Bird, Blu, Bmobile, Boway, bq, Brondi, Bush, Capitel, Captiva, Carrefour, Casio, Cat, Celkon, Changhong, Cherry Mobile, CnM, Coby Kyros, Compal, ConCorde, Coolpad, Cowon, CreNova, Cricket, Crius Mea, Crosscall, Cube, CUBOT, Danew, Datang, Dbtel, Dell, Denver, Desay, Dicam, DMM, DNS, DoCoMo, Doogee, Doov, Dopod, Dune HD, E-Boda, Easypix, EBEST, ECS, Elephone, Energy Sistem, Ericsson, Ericy, Eton, eTouch, Evertek, Ezio, Ezze, Fairphone, Fly, Foxconn, Fujitsu, Garmin-Asus, Gemini, Gigabyte, Gigaset, Gionee, GOCLEVER, Goly, Google, Gradiente, Grundig, Haier, Hasee, Hi-Level, Hisense, Hosin, HP, HTC, Huawei, Humax, Hyundai, i-Joy, i-mate, i-mobile, iBall, iBerry, Ikea, iKoMo, iNew, Infinix, Inkti, Innostream, INQ, Intek, Intex, Inverto, iOcean, iTel, Jiayu, Jolla, K-Touch, Karbonn, Kazam, KDDI, Kingsun, Komu, Konka, Koobee, KOPO, Koridy, KT-Tech, Kumai, Kyocera, Lanix, Lava, LCT, Le Pan, Lenco, Lenovo, Lexibook, LG, Lingwin, Loewe, Logicom, M.T.T., Majestic, Manta Multimedia, Mecer, Mediacom, MediaTek, Medion, MEEG, Meizu, Memup, Metz, MEU, MicroMax, Microsoft, Mio, Mitsubishi, MLLED, Mobistel, Mofut, Motorola, Mpman, MSI, MyPhone, NEC, Netgear, Newgen, Nexian, NextBook, NGM, Nikon, Nintendo, Noain, Nokia, Nomi, O2, Onda, OnePlus, OPPO, Opsson, Orange, Ouki, OUYA, Overmax, Oysters, Palm, Panasonic, Pantech, PEAQ, Philips, phoneOne, Pioneer, Ployer, Point of View, Polaroid, PolyPad, Pomp, Positivo, Prestigio, ProScan, PULID, Qilive, QMobile, Qtek, Quechua, Ramos, RCA Tablets, Readboy, Rikomagic, RIM, Roku, Rover, Sagem, Samsung, Sanyo, Sega, Selevision, Sencor, Sendo, SFR, Sharp, Siemens, Skyworth, Smart, Smartfren, Softbank, Sony, Spice, Star, Stonex, Storex, Sumvision, SunVan, SuperSonic, Symphony, T-Mobile, TCL, TechniSat, TechnoTrend, Tecno Mobile, Telefunken, Telenor, Telit, Tesco, Tesla, teXet, ThL, Thomson, TIANYU, TiPhone, Tolino, Toplux, Toshiba, Trevi, Tunisie Telecom, Turbo-X, TVC, Uniscope, Unknown, Unowhy, UTStarcom, Vastking, Vertu, Vestel, Videocon, Videoweb, ViewSonic, Vitelcom, Vivo, Vizio, VK Mobile, Vodafone, Voto, Voxtel, Walton, WellcoM, Wexler, Wiko, Wolder, Wonu, Woxter, Xiaomi, Xolo, Yarvik, Ytone, Yuandao, Yusun, Zeemi, Zonda, Zopo, ZTE

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
