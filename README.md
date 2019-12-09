# DeviceDetector

[![Build Status](https://travis-ci.org/podigee/device_detector.svg?branch=develop)](https://travis-ci.org/podigee/device_detector)

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

Updated on 2019-12-09

### Bots

360Spider, Aboundexbot, Acoon, AddThis.com, ADMantX, aHrefs Bot, Alexa Crawler, Alexa Site Audit, Amazon Route53 Health Check, Amorank Spider, Analytics SEO Crawler, ApacheBench, Applebot, Arachni, archive.org bot, Ask Jeeves, Backlink-Check.de, BacklinkCrawler, Baidu Spider, BazQux Reader, BingBot, BitlyBot, Blekkobot, BLEXBot Crawler, Bloglovin, Blogtrottr, BoardReader Blog Indexer, Bountii Bot, Browsershots, BUbiNG, Butterfly Robot, CareerBot, Castro 2, Catchpoint, ccBot crawler, Charlotte, Cliqzbot, CloudFlare Always Online, CloudFlare AMP Fetcher, Collectd, CommaFeed, CSS Certificate Spider, Cốc Cốc Bot, Datadog Agent, Datanyze, Dataprovider, Daum, Dazoobot, Discobot, Domain Re-Animator Bot, DotBot, DuckDuckGo Bot, Easou Spider, eCairn-Grabber, EMail Exractor, EmailWolf, evc-batch, ExaBot, ExactSeek Crawler, Ezooms, Facebook External Hit, Feed Wrangler, Feedbin, FeedBurner, Feedly, Feedspot, Fever, Findxbot, Flipboard, FreshRSS, Generic Bot, Genieo Web filter, Gigablast, Gigabot, Gluten Free Crawler, Gmail Image Proxy, Goo, Google Favicon, Google PageSpeed Insights, Google Partner Monitoring, Google Search Console, Google Structured Data Testing Tool, Googlebot, Grapeshot, Heritrix, Heureka Feed, HTTPMon, HubPages, HubSpot, ICC-Crawler, ichiro, IIS Site Analysis, Inktomi Slurp, inoreader, IP-Guide Crawler, IPS Agent, Kouio, Larbin web crawler, Let's Encrypt Validation, Lighthouse, Linkdex Bot, LinkedIn Bot, LTX71, Lycos, Magpie-Crawler, MagpieRSS, Mail.Ru Bot, masscan, Mastodon Bot, Meanpath Bot, MetaInspector, MetaJobBot, Mixrank Bot, MJ12 Bot, Mnogosearch, MojeekBot, Monitor.Us, Munin, Nagios check_http, NalezenCzBot, nbertaupete95, Netcraft Survey Bot, netEstate, NetLyzer FastProbe, NetResearchServer, Netvibes, NewsBlur, NewsGator, NLCrawler, Nmap, Nutch-based Bot, Nuzzel, Octopus, Omgili bot, Openindex Spider, OpenLinkProfiler, OpenWebSpider, Orange Bot, Outbrain, PagePeeker, PaperLiBot, Phantomas, PHP Server Monitor, Picsearch bot, Pingdom Bot, Pinterest, PocketParser, Pompos, PritTorrent, QuerySeekerSpider, Quora Link Preview, Qwantify, Rainmeter, RamblerMail Image Proxy, Reddit Bot, Riddler, Rogerbot, ROI Hunter, RSSRadio Bot, SafeDNSBot, Scooter, ScoutJet, Scrapy, Screaming Frog SEO Spider, ScreenerBot, Semrush Bot, Sensika Bot, Sentry Bot, SEOENGBot, SEOkicks-Robot, Seoscanners.net, Server Density, Seznam Bot, Seznam Email Proxy, Seznam Zbozi.cz, ShopAlike, Shopify Partner, ShopWiki, SilverReader, SimplePie, SISTRIX Crawler, SISTRIX Optimizer, Site24x7 Website Monitoring, SiteSucker, Sixy.ch, Skype URI Preview, Slackbot, Snapchat Proxy, Sogou Spider, Soso Spider, Sparkler, Speedy, Spinn3r, Spotify, Sputnik Bot, sqlmap, SSL Labs, StatusCake, Superfeedr Bot, Survey Bot, Tarmot Gezgin, TelegramBot, The Knowledge AI, theoldreader, TinEye Crawler, Tiny Tiny RSS, TLSProbe, Trendiction Bot, TurnitinBot, TweetedTimes Bot, Tweetmeme Bot, Twingly Recon, Twitterbot, UkrNet Mail Proxy, UniversalFeedParser, Uptime Robot, Uptimebot, URLAppendBot, Vagabondo, Visual Site Mapper Crawler, VK Share Button, W3C CSS Validator, W3C I18N Checker, W3C Link Checker, W3C Markup Validation Service, W3C MobileOK Checker, W3C Unified Validator, Wappalyzer, WebbCrawler, WebPageTest, WebSitePulse, WebThumbnail, WeSEE:Search, Willow Internet Crawler, WordPress, Wotbox, YaCy, Yahoo Gemini, Yahoo! Cache System, Yahoo! Link Preview, Yahoo! Slurp, Yandex Bot, Yeti/Naverbot, Yottaa Site Monitor, Youdao Bot, Yourls, Yunyun Bot, Zao, zgrab, Zookabot, ZumBot

### Clients

2345 Browser, 360 Browser, 360 Phone Browser, ABrowse, aiohttp, Airmail, Akregator, Aloha Browser, Amaya, Amiga Aweb, Amiga Voyager, Amigo, Android Browser, AndroidDownloadManager, ANT Fresco, AntennaPod, ANTGalio, AOL Shield, Apple News, Apple PubSub, Arora, Atomic Web Browser, Audacious, Avant Browser, Avast Secure Browser, B-Line, Baidu Box App, Baidu Browser, Baidu Spark, Banshee, Barca, BashPodder, Basilisk, Beaker Browser, Beonex, BeyondPod, BingWebApp, BlackBerry Browser, Boxee, bPod, Brave, Breaker, BriskBard, BrowseX, Bunjalloo, Camino, Castro, Castro 2, Charon, Cheetah Browser, Cheshire, Chrome, Chrome Frame, Chrome Mobile, Chrome Mobile iOS, Chrome Webview, ChromePlus, Chromium, Clementine, CM Browser, Coast, Coc Coc, CometBird, Comodo Dragon, Conkeror, CoolNovo, CrosswalkApp, Cunaguaro, curl, Cyberfox, DAVdroid, dbrowser, Deepnet Explorer, Deezer, Dillo, DoggCatcher, Dolphin, Dooble, Dorado, douban App, Downcast, DuckDuckGo Privacy Browser, Ecosia, Element Browser, Elinks, Epic, Espial TV Browser, Facebook, Facebook Messenger, Faraday, FeedDemon, Feeddler RSS Reader, FeedR, Fennec, Firebird, Firefox, Firefox Focus, Firefox Mobile, Firefox Mobile iOS, Firefox Rocket, Fireweb, Fireweb Navigator, Flipboard App, Flock, Fluid, FlyCast, Foobar2000, FreeU, Galeon, GNOME Web, Go-http-client, Google Earth, Google HTTP Java Client, Google Play Newsstand, Google Plus, Google Search App, gPodder, Guzzle (PHP HTTP Client), Hawk Turbo Browser, Headless Chrome, hola! Browser, HotJava, HTTP_Request2, HTTPie, Huawei Browser, IBrowse, iCab, iCab Mobile, iCatcher, IceCat, IceDragon, Iceweasel, IE Mobile, Instacast, Instagram App, Internet Explorer, Iridium, Iron, Iron Mobile, Isivioo, iTunes, Jasmine, Java, JetBrains Omea Reader, Jig Browser, Jio Browser, K-meleon, K.Browser, Kapiko, Kazehakase, Kindle Browser, Kiwi, Kodi, Konqueror, Kylo, LG Browser, libdnf, LieBaoFast, Liferea, Line, Links, Lotus Notes, LuaKit, Lunascape, Lynx, MailBar, Maxthon, Mechanize, MediaMonkey, Mercury, MicroB, Microsoft Edge, Microsoft Outlook, Midori, Mint Browser, Miro, MIUI Browser, Mobicip, Mobile Safari, Mobile Silk, NCSA Mosaic, NetFront, NetFront Life, NetNewsWire, NetPositive, Netscape, NetSurf, NewsArticle App, Newsbeuter, NewsBlur, NewsBlur Mobile App, NexPlayer, Nightingale, Nokia Browser, Nokia OSS Browser, Nokia Ovi Browser, Nox Browser, NTENT Browser, Obigo, Oculus Browser, Odyssey Web Browser, Off By One, OkHttp, OmniWeb, ONE Browser, Openwave Mobile Browser, Opera, Opera Devices, Opera Mini, Opera Mini iOS, Opera Mobile, Opera Neon, Opera Next, Opera Touch, Oppo Browser, Oregano, Otter Browser, Outlook Express, Overcast, Pale Moon, Palm Blazer, Palm Pre, Palm WebPro, Palmscape, Perl, Phoenix, Pinterest, Player FM, Pocket Casts, Podcast & Radio Addict, Podcast Republic, Podcasts, Podcat, Podcatcher Deluxe, Podkicker, Polaris, Polarity, Postbox, PritTorrent, Puffin, Pulp, Python Requests, Python urllib, QQ Browser, QQ Browser Mini, QtWebEngine, QuickTime, QuiteRSS, QupZilla, Qutebrowser, Qwant Mobile, ReadKit, Realme Browser, Reeder, Rekonq, REST Client for Ruby, RestSharp, RockMelt, RSS Bandit, RSS Junkie, RSSOwl, RSSRadio, Safari, Sailfish Browser, Samsung Browser, SeaMonkey, SEMC-Browser, Seraphic Sraf, Seznam Browser, Shiira, Sina Weibo, Skyfire, Sleipnir, Snowshoe, Sogou Explorer, Sogou Mobile Browser, SogouSearch App, Songbird, Sputnik Browser, Stagefright, Streamy, Stringer, SubStream, Sunrise, SuperBird, Swiftfox, TenFourFox, Tenta Browser, The Bat!, Thunderbird, tieba, Tizen Browser, TweakStyle, UC Browser, UC Browser Mini, urlgrabber (yum), Vision Mobile Browser, Vivaldi, vivo Browser, VLC, Waterfox, Web Explorer, WebPositive, WeChat, WeTab Browser, Wget, Whale Browser, WhatsApp, Winamp, Windows Media Player, wOSBrowser, WWW-Mechanize, XBMC, Xiino, Yahoo! Japan, Yandex Browser, Yandex Browser Lite, Yelp Mobile, YouTube

### Devices

3Q, 4Good, Acer, Advan, Advance, AGM, Ainol, Airness, Airties, AIS, Aiwa, Akai, Alcatel, AllCall, Allview, Allwinner, Altech UEC, altron, Amazon, AMGOO, Amoi, ANS, Apple, Archos, Arian Space, Ark, Arnova, ARRIS, Ask, Assistant, Asus, Audiovox, AVH, Avvio, Axxion, Azumi Mobile, BangOlufsen, Barnes & Noble, Becker, Beeline, Beetel, BenQ, BenQ-Siemens, BGH, Bird, Bitel, Black Fox, Blackview, Blaupunkt, Blu, Bluboo, Bluegood, Bmobile, bogo, Boway, bq, Bravis, Brondi, Bush, CAGI, Capitel, Captiva, Carrefour, Casio, Casper, Cat, Celkon, Changhong, Cherry Mobile, China Mobile, Clarmin, CnM, Coby Kyros, Comio, Compal, ComTrade Tesla, Concord, ConCorde, Condor, Coolpad, Cowon, CreNova, Crescent, Cricket, Crius Mea, Crosscall, Cube, CUBOT, Cyrus, Danew, Datang, Datsun, Dbtel, Dell, Denver, Desay, DEXP, Dialog, Dicam, Digi, Digicel, Digiland, Digma, DMM, DNS, DoCoMo, Doogee, Doov, Dopod, Doro, Dune HD, E-Boda, E-tel, Easypix, EBEST, Echo Mobiles, ECS, EE, EKO, Eks Mobility, Elenberg, Elephone, Energizer, Energy Sistem, Ergo, Ericsson, Ericy, Essential, Essentielb, Eton, eTouch, Etuline, Eurostar, Evercoss, Evertek, Evolio, Evolveo, EvroMedia, Explay, Extrem, Ezio, Ezze, Fairphone, Famoco, Fengxiang, FiGO, FinePower, Fly, FNB, Fondi, FORME, Forstar, Foxconn, Freetel, Fujitsu, G-TiDE, Garmin-Asus, Gemini, Geotel, Ghia, Gigabyte, Gigaset, Ginzzu, Gionee, GOCLEVER, Goly, GoMobile, Google, Gradiente, Grape, Grundig, Hafury, Haier, HannSpree, Hasee, Hi-Level, Hisense, Hoffmann, Homtom, Hoozo, Hosin, HP, HTC, Huawei, Humax, Hyundai, i-Joy, i-mate, i-mobile, iBall, iBerry, IconBIT, iHunt, Ikea, iKoMo, iLA, IMO Mobile, Impression, iNew, Infinix, InFocus, Inkti, InnJoo, Innostream, Inoi, INQ, Insignia, Intek, Intex, Inverto, iOcean, iPro, Irbis, iRola, iTel, iView, JAY-Tech, Jiayu, Jolla, Just5, K-Touch, Kaan, Kalley, Karbonn, Kazam, KDDI, Kempler & Strauss, Keneksi, Kiano, Kingsun, Kocaso, Kodak, Kogan, Komu, Konka, Konrow, Koobee, KOPO, Koridy, KRONO, Krüger&Matz, KT-Tech, Kumai, Kyocera, LAIQ, Land Rover, Landvo, Lanix, Lark, Lava, LCT, Le Pan, Leagoo, Ledstar, LeEco, Lemhoov, Lenco, Lenovo, Leotec, Lephone, Lexand, Lexibook, LG, Lingwin, Loewe, Logicom, Lumus, LYF, M.T.T., M4tel, Majestic, Manta Multimedia, Masstel, Maxwest, Maze, Mecer, Mecool, Mediacom, MediaTek, Medion, MEEG, MegaFon, Meitu, Meizu, Memup, Metz, MEU, MicroMax, Microsoft, Mio, Miray, Mitsubishi, MIXC, MLLED, Mobicel, Mobiistar, Mobiola, Mobistel, Modecom, Mofut, Motorola, Movic, Mpman, MSI, MTC, MTN, MYFON, MyPhone, Myria, MyWigo, Navon, NEC, Neffos, Netgear, NeuImage, Newgen, NEXBOX, Nexian, Nextbit, NextBook, NGM, Nikon, Nintendo, NOA, Noain, Nobby, Noblex, Nokia, Nomi, Nous, NUU Mobile, Nvidia, NYX Mobile, O+, O2, Obi, Odys, Onda, OnePlus, OPPO, Opsson, Orange, Ouki, OUYA, Overmax, Oysters, Palm, Panacom, Panasonic, Pantech, PCBOX, PCD, PCD Argentina, PEAQ, Pentagram, Philips, phoneOne, Pioneer, Pixus, Ployer, Plum, Point of View, Polaroid, PolyPad, Polytron, Pomp, Positivo, PPTV, Prestigio, Primepad, ProScan, PULID, Q-Touch, Qilive, QMobile, Qtek, Quantum, Quechua, R-TV, Ramos, RCA Tablets, Readboy, Rikomagic, RIM, Rinno, Ritmix, Riviera, Rokit, Roku, Rombica, Ross&Moor, Rover, RT Project, Safaricom, Sagem, Samsung, Sanei, Santin BiTBiZ, Sanyo, Savio, Sega, Selevision, Selfix, Sencor, Sendo, Senseit, Senwa, SFR, Sharp, Shuttle, Siemens, Sigma, Silent Circle, Simbans, Sky, Skyworth, Smart, Smartfren, Smartisan, Softbank, Sonim, Sony, Spice, Star, Starway, STF Mobile, STK, Stonex, Storex, Sumvision, SunVan, SuperSonic, Supra, SWISSMOBILITY, Symphony, Syrox, T-Mobile, TB Touch, TCL, TechniSat, TechnoTrend, TechPad, Teclast, Tecno Mobile, Telefunken, Telego, Telenor, Telit, Tesco, Tesla, teXet, ThL, Thomson, TIANYU, Timovi, TiPhone, Tolino, Tooky, Top House, Toplux, Toshiba, Touchmate, TrekStor, Trevi, True, Tunisie Telecom, Turbo-X, TVC, U.S. Cellular, Uhappy, Ulefone, UMIDIGI, Unimax, Uniscope, Unknown, Unnecto, Unonu, Unowhy, UTOK, UTStarcom, Vastking, Venso, Verizon, Vernee, Vertex, Vertu, Verykool, Vestel, VGO TEL, Videocon, Videoweb, ViewSonic, Vinsoc, Vitelcom, Vivax, Vivo, Vizio, VK Mobile, Vodafone, Vonino, Vorago, Voto, Voxtel, Vulcan, Walton, Weimei, WellcoM, Wexler, Wiko, Wileyfox, Wink, Wolder, Wolfgang, Wonu, Woo, Woxter, X-TIGI, X-View, Xiaolajiao, Xiaomi, Xion, Xolo, Yandex, Yarvik, Yes, Yezz, Ytone, Yu, Yuandao, Yusun, Zeemi, Zen, Zenek, Zonda, Zopo, ZTE, Zuum, Zync, ZYQ, öwn

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
