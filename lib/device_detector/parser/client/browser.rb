# frozen_string_literal: true

require 'device_detector/parser/client/hint/browser_hints'

class DeviceDetector
  module Parser
    module Client
      class Browser < AbstractClientParser
        def initialize
          super
          @browser_hints = Hint::BrowserHints.new
          @engine_parser = BrowserModule::Engine.new
          @engine_version_parser = BrowserModule::EngineVersion.new
        end

        def use(uas, hints)
          super
          @browser_hints.use(uas, hints)
          @engine_parser.use(uas, hints)
        end

        def self.client_hint_mapping
          BROWSER_CLIENT_HINT_MAPPING
        end

        def self.mobile_only_browser?(browser)
          MOBILE_ONLY_BROWSERS.include?(browser) ||
            MOBILE_ONLY_BROWSERS.include?(
              DOWNCASED_AVAILABLE_BROWSERS[browser.downcase]
            )
        end

        BROWSER_CLIENT_HINT_MAPPING = {
          'Chrome' => ['Google Chrome'],
          'Chrome Webview' => ['Android WebView'],
          'DuckDuckGo Privacy Browser' => ['DuckDuckGo'],
          'Edge WebView' => ['Microsoft Edge WebView2'],
          'Mi Browser' => ['Miui Browser', 'XiaoMiBrowser'],
          'Microsoft Edge' => ['Edge'],
          'Norton Private Browser' => ['Norton Secure Browser'],
          'Vewd Browser' => ['Vewd Core']
        }.freeze

        AVAILABLE_BROWSERS = {
          'V1' => 'Via',
          '1P' => 'Pure Mini Browser',
          '4P' => 'Pure Lite Browser',
          '1R' => 'Raise Fast Browser',
          'R1' => 'Rabbit Private Browser',
          'FQ' => 'Fast Browser UC Lite',
          'FJ' => 'Fast Explorer',
          '1L' => 'Lightning Browser',
          '1C' => 'Cake Browser',
          '1I' => 'IE Browser Fast',
          '1V' => 'Vegas Browser',
          '1O' => 'OH Browser',
          '3O' => 'OH Private Browser',
          '1X' => 'XBrowser Mini',
          '1S' => 'Sharkee Browser',
          '2L' => 'Lark Browser',
          '3P' => 'Pluma',
          '1A' => 'Anka Browser',
          'AZ' => 'Azka Browser',
          '1D' => 'Dragon Browser',
          '1E' => 'Easy Browser',
          'DW' => 'Dark Web Browser',
          'D6' => 'Dark Browser',
          '18' => '18+ Privacy Browser',
          '1B' => '115 Browser',
          'DM' => '1DM Browser',
          '1M' => '1DM+ Browser',
          '2B' => '2345 Browser',
          '3B' => '360 Secure Browser',
          '36' => '360 Phone Browser',
          '7B' => '7654 Browser',
          'AA' => 'Avant Browser',
          'AB' => 'ABrowse',
          '4A' => 'Acoo Browser',
          'BW' => 'AdBlock Browser',
          'A7' => 'Adult Browser',
          '8A' => 'Ai Browser',
          'A9' => 'Airfind Secure Browser',
          'AF' => 'ANT Fresco',
          'AG' => 'ANTGalio',
          'AL' => 'Aloha Browser',
          'AH' => 'Aloha Browser Lite',
          'A8' => 'ALVA',
          '9A' => 'AltiBrowser',
          'AM' => 'Amaya',
          'A3' => 'Amaze Browser',
          'A5' => 'Amerigo',
          'AO' => 'Amigo',
          'AN' => 'Android Browser',
          '3A' => 'AOL Explorer',
          'AE' => 'AOL Desktop',
          'AD' => 'AOL Shield',
          'A4' => 'AOL Shield Pro',
          '2A' => 'Aplix',
          'A6' => 'AppBrowzer',
          '0A' => 'AppTec Secure Browser',
          'AP' => 'APUS Browser',
          'AR' => 'Arora',
          'AX' => 'Arctic Fox',
          'AV' => 'Amiga Voyager',
          'AW' => 'Amiga Aweb',
          'PN' => 'APN Browser',
          '6A' => 'Arachne',
          'RA' => 'Arc Search',
          'R5' => 'Armorfly Browser',
          'AI' => 'Arvin',
          'AK' => 'Ask.com',
          'AU' => 'Asus Browser',
          'A0' => 'Atom',
          'AT' => 'Atomic Web Browser',
          'A2' => 'Atlas',
          'AS' => 'Avast Secure Browser',
          'VG' => 'AVG Secure Browser',
          'AC' => 'Avira Secure Browser',
          'A1' => 'AwoX',
          '7A' => 'Awesomium',
          '5B' => 'Basic Web Browser',
          'BA' => 'Beaker Browser',
          'BM' => 'Beamrise',
          'F7' => 'BF Browser',
          'BB' => 'BlackBerry Browser',
          '6B' => 'Bluefy',
          'H1' => 'BrowseHere',
          'B8' => 'Browser Hup Pro',
          'BD' => 'Baidu Browser',
          'BS' => 'Baidu Spark',
          'BG' => 'Bang',
          'B9' => 'Bangla Browser',
          'BI' => 'Basilisk',
          'BV' => 'Belva Browser',
          'B5' => 'Beyond Private Browser',
          'BE' => 'Beonex',
          'B2' => 'Berry Browser',
          'BT' => 'Bitchute Browser',
          '9B' => 'BizBrowser',
          'BH' => 'BlackHawk',
          'B0' => 'Bloket',
          'BJ' => 'Bunjalloo',
          'BL' => 'B-Line',
          'B6' => 'Black Lion Browser',
          'BU' => 'Blue Browser',
          'BO' => 'Bonsai',
          'BN' => 'Borealis Navigator',
          'BR' => 'Brave',
          'BK' => 'BriskBard',
          'K2' => 'BroKeep Browser',
          'B3' => 'Browspeed Browser',
          'BX' => 'BrowseX',
          'BZ' => 'Browzar',
          'B7' => 'Browlser',
          'M9' => 'Browser Mini',
          '4B' => 'BrowsBit',
          'BY' => 'Biyubi',
          'BF' => 'Byffox',
          'B4' => 'BXE Browser',
          'CA' => 'Camino',
          '5C' => 'Catalyst',
          'XP' => 'Catsxp',
          '0C' => 'Cave Browser',
          'CL' => 'CCleaner',
          'C8' => 'CG Browser',
          'CJ' => 'ChanjetCloud',
          'C6' => 'Chedot',
          'C9' => 'Cherry Browser',
          'C0' => 'Centaury',
          'CQ' => 'Cliqz',
          'CC' => 'Coc Coc',
          'C4' => 'CoolBrowser',
          'C2' => 'Colibri',
          '6C' => 'Columbus Browser',
          'CD' => 'Comodo Dragon',
          'C1' => 'Coast',
          'CX' => 'Charon',
          'CE' => 'CM Browser',
          'C7' => 'CM Mini',
          'CF' => 'Chrome Frame',
          'HC' => 'Headless Chrome',
          'CH' => 'Chrome',
          'CI' => 'Chrome Mobile iOS',
          'CK' => 'Conkeror',
          'CM' => 'Chrome Mobile',
          '3C' => 'Chowbo',
          '7C' => 'Classilla',
          'CN' => 'CoolNovo',
          '4C' => 'Colom Browser',
          'CO' => 'CometBird',
          '2C' => 'Comfort Browser',
          'CB' => 'COS Browser',
          'CW' => 'Cornowser',
          'C3' => 'Chim Lac',
          'CP' => 'ChromePlus',
          'CR' => 'Chromium',
          'C5' => 'Chromium GOST',
          'CY' => 'Cyberfox',
          'CS' => 'Cheshire',
          '8C' => 'Cromite',
          'RC' => 'Crow Browser',
          'CT' => 'Crusta',
          'CG' => 'Craving Explorer',
          'CZ' => 'Crazy Browser',
          'CU' => 'Cunaguaro',
          'CV' => 'Chrome Webview',
          'YC' => 'CyBrowser',
          'DB' => 'dbrowser',
          'PD' => 'Peeps dBrowser',
          'DK' => 'Dark Web',
          'DP' => 'Dark Web Private',
          'D1' => 'Debuggable Browser',
          'DC' => 'Decentr',
          'DE' => 'Deepnet Explorer',
          'DG' => 'deg-degan',
          'DA' => 'Deledao',
          'DT' => 'Delta Browser',
          'D0' => 'Desi Browser',
          'DS' => 'DeskBrowse',
          'D3' => 'Dezor',
          'II' => 'Diigo Browser',
          'D2' => 'DoCoMo',
          'DF' => 'Dolphin',
          'DZ' => 'Dolphin Zero',
          'DO' => 'Dorado',
          'DR' => 'Dot Browser',
          'DL' => 'Dooble',
          'DI' => 'Dillo',
          'DU' => 'DUC Browser',
          'DD' => 'DuckDuckGo Privacy Browser',
          'E1' => 'East Browser',
          'EC' => 'Ecosia',
          'EW' => 'Edge WebView',
          'EV' => 'Every Browser',
          'EI' => 'Epic',
          'EL' => 'Elinks',
          'EN' => 'EinkBro',
          'EB' => 'Element Browser',
          'EE' => 'Elements Browser',
          'EO' => 'Eolie',
          'EX' => 'Explore Browser',
          'EZ' => 'eZ Browser',
          'E2' => 'EudoraWeb',
          'EU' => 'EUI Browser',
          'EP' => 'GNOME Web',
          'G1' => 'G Browser',
          'ES' => 'Espial TV Browser',
          'FG' => 'fGet',
          'FA' => 'Falkon',
          'FX' => 'Faux Browser',
          'F8' => 'Fire Browser',
          'F4' => 'Fiery Browser',
          'F1' => 'Firefox Mobile iOS',
          'FB' => 'Firebird',
          'FD' => 'Fluid',
          'FE' => 'Fennec',
          'FF' => 'Firefox',
          'FK' => 'Firefox Focus',
          'FY' => 'Firefox Reality',
          'FR' => 'Firefox Rocket',
          '1F' => 'Firefox Klar',
          'F0' => 'Float Browser',
          'FL' => 'Flock',
          'FP' => 'Floorp',
          'FO' => 'Flow',
          'F2' => 'Flow Browser',
          'FM' => 'Firefox Mobile',
          'FW' => 'Fireweb',
          'FN' => 'Fireweb Navigator',
          'FH' => 'Flash Browser',
          'FS' => 'Flast',
          'F5' => 'Flyperlink',
          'F9' => 'FOSS Browser',
          'FU' => 'FreeU',
          'F6' => 'Freedom Browser',
          'FT' => 'Frost',
          'F3' => 'Frost+',
          'FI' => 'Fulldive',
          'GA' => 'Galeon',
          'G8' => 'Gener8',
          'GH' => 'Ghostery Privacy Browser',
          'GI' => 'GinxDroid Browser',
          'GB' => 'Glass Browser',
          'GD' => 'Godzilla Browser',
          'G3' => 'Good Browser',
          'GE' => 'Google Earth',
          'GP' => 'Google Earth Pro',
          'GO' => 'GOG Galaxy',
          'GR' => 'GoBrowser',
          'GK' => 'GoKu',
          'G2' => 'GO Browser',
          'RN' => 'GreenBrowser',
          'HW' => 'Habit Browser',
          'H7' => 'Halo Browser',
          'HB' => 'Harman Browser',
          'HS' => 'HasBrowser',
          'HA' => 'Hawk Turbo Browser',
          'HQ' => 'Hawk Quick Browser',
          'HE' => 'Helio',
          'HN' => 'Herond Browser',
          'HX' => 'Hexa Web Browser',
          'H8' => 'HeyTapBrowser',
          'HI' => 'Hi Browser',
          'HO' => 'hola! Browser',
          'H4' => 'Holla Web Browser',
          'H5' => 'HotBrowser',
          'HJ' => 'HotJava',
          'H6' => 'HONOR Browser',
          'HT' => 'HTC Browser',
          'HU' => 'Huawei Browser Mobile',
          'HP' => 'Huawei Browser',
          'H3' => 'HUB Browser',
          'IO' => 'iBrowser',
          'IS' => 'iBrowser Mini',
          'IB' => 'IBrowse',
          'I6' => 'iDesktop PC Browser',
          'IC' => 'iCab',
          'I2' => 'iCab Mobile',
          '4I' => 'iNet Browser',
          'I1' => 'Iridium',
          'I3' => 'Iron Mobile',
          'I4' => 'IceCat',
          'ID' => 'IceDragon',
          'IV' => 'Isivioo',
          'I8' => 'IVVI Browser',
          'IW' => 'Iceweasel',
          '2I' => 'Impervious Browser',
          'N3' => 'Incognito Browser',
          'IN' => 'Inspect Browser',
          'I9' => 'Insta Browser',
          'IE' => 'Internet Explorer',
          'I7' => 'Internet Browser Secure',
          '5I' => 'Internet Webbrowser',
          '3I' => 'Intune Managed Browser',
          'I5' => 'Indian UC Mini Browser',
          'Z0' => 'InBrowser',
          'IG' => 'Involta Go',
          'IM' => 'IE Mobile',
          'IR' => 'Iron',
          'JB' => 'Japan Browser',
          'JS' => 'Jasmine',
          'JA' => 'JavaFX',
          'JL' => 'Jelly',
          'JI' => 'Jig Browser',
          'JP' => 'Jig Browser Plus',
          'JO' => 'JioSphere',
          'JZ' => 'JUZI Browser',
          'KB' => 'K.Browser',
          'KF' => 'Keepsafe Browser',
          'K7' => 'KeepSolid Browser',
          'KS' => 'Kids Safe Browser',
          'KI' => 'Kindle Browser',
          'KM' => 'K-meleon',
          'KJ' => 'K-Ninja',
          'KO' => 'Konqueror',
          'KP' => 'Kapiko',
          'KE' => 'Keyboard Browser',
          'KN' => 'Kinza',
          'K4' => 'Kitt',
          'KW' => 'Kiwi',
          'KD' => 'Kode Browser',
          'KU' => 'KUN',
          'KT' => 'KUTO Mini Browser',
          'KY' => 'Kylo',
          'KZ' => 'Kazehakase',
          'LB' => 'Cheetah Browser',
          'LD' => 'Ladybird',
          'LA' => 'Lagatos Browser',
          'GN' => 'Legan Browser',
          'LR' => 'Lexi Browser',
          'LV' => 'Lenovo Browser',
          'LF' => 'LieBaoFast',
          'LG' => 'LG Browser',
          'LH' => 'Light',
          'L4' => 'Lightning Browser Plus',
          'L1' => 'Lilo',
          'LI' => 'Links',
          'RI' => 'Liri Browser',
          'LC' => 'LogicUI TV Browser',
          'IF' => 'Lolifox',
          'L3' => 'Lotus',
          'LO' => 'Lovense Browser',
          'LT' => 'LT Browser',
          'LU' => 'LuaKit',
          'LJ' => 'LUJO TV Browser',
          'LL' => 'Lulumi',
          'LS' => 'Lunascape',
          'LN' => 'Lunascape Lite',
          'LX' => 'Lynx',
          'L2' => 'Lynket Browser',
          'MD' => 'Mandarin',
          'MP' => 'Maple',
          'M5' => 'MarsLab Web Browser',
          'M7' => 'MaxBrowser',
          'M1' => 'mCent',
          'MB' => 'MicroB',
          'MC' => 'NCSA Mosaic',
          'MZ' => 'Meizu Browser',
          'ME' => 'Mercury',
          'M2' => 'Me Browser',
          'MF' => 'Mobile Safari',
          'MI' => 'Midori',
          'M3' => 'Midori Lite',
          'M6' => 'MixerBox AI',
          'MO' => 'Mobicip',
          'MU' => 'Mi Browser',
          'MS' => 'Mobile Silk',
          'MK' => 'Mogok Browser',
          'M8' => 'Motorola Internet Browser',
          'MN' => 'Minimo',
          'MT' => 'Mint Browser',
          'MX' => 'Maxthon',
          'M4' => 'MaxTube Browser',
          'MA' => 'Maelstrom',
          '3M' => 'Mises',
          'MM' => 'Mmx Browser',
          'NM' => 'MxNitro',
          'MY' => 'Mypal',
          'MR' => 'Monument Browser',
          'MW' => 'MAUI WAP Browser',
          'N7' => 'Naenara Browser',
          'NW' => 'Navigateur Web',
          'NK' => 'Naked Browser',
          'NA' => 'Naked Browser Pro',
          'NR' => 'NFS Browser',
          'N5' => 'Ninetails',
          'NB' => 'Nokia Browser',
          'NO' => 'Nokia OSS Browser',
          'NV' => 'Nokia Ovi Browser',
          'N2' => 'Norton Private Browser',
          'NX' => 'Nox Browser',
          'N1' => 'NOMone VR Browser',
          'N6' => 'NOOK Browser',
          'NE' => 'NetSurf',
          'NF' => 'NetFront',
          'NL' => 'NetFront Life',
          'NP' => 'NetPositive',
          'NS' => 'Netscape',
          'WR' => 'NextWord Browser',
          'N8' => 'Ninesky',
          'NT' => 'NTENT Browser',
          'NU' => 'Nuanti Meta',
          'NI' => 'Nuviu',
          'O9' => 'Ocean Browser',
          'OC' => 'Oculus Browser',
          'O6' => 'Odd Browser',
          'O1' => 'Opera Mini iOS',
          'OB' => 'Obigo',
          'O2' => 'Odin',
          '2O' => 'Odin Browser',
          'H2' => 'OceanHero',
          'OD' => 'Odyssey Web Browser',
          'OF' => 'Off By One',
          'O5' => 'Office Browser',
          'HH' => 'OhHai Browser',
          'OL' => 'OnBrowser Lite',
          'OE' => 'ONE Browser',
          'N4' => 'Onion Browser',
          '1N' => 'ONIONBrowser',
          'Y1' => 'Opera Crypto',
          'OX' => 'Opera GX',
          'OG' => 'Opera Neon',
          'OH' => 'Opera Devices',
          'OI' => 'Opera Mini',
          'OM' => 'Opera Mobile',
          'OP' => 'Opera',
          'ON' => 'Opera Next',
          'OO' => 'Opera Touch',
          'OU' => 'Orbitum',
          'OA' => 'Orca',
          'OS' => 'Ordissimo',
          'OR' => 'Oregano',
          'O0' => 'Origin In-Game Overlay',
          'OY' => 'Origyn Web Browser',
          'O8' => 'OrNET Browser',
          'OV' => 'Openwave Mobile Browser',
          'O3' => 'OpenFin',
          'O4' => 'Open Browser',
          '4U' => 'Open Browser 4U',
          '5G' => 'Open Browser fast 5G',
          '5O' => 'Open Browser Lite',
          'O7' => 'Open TV Browser',
          'OW' => 'OmniWeb',
          'OT' => 'Otter Browser',
          '4O' => 'Owl Browser',
          'JR' => 'OJR Browser',
          'PL' => 'Palm Blazer',
          'PM' => 'Pale Moon',
          'PY' => 'Polypane',
          '8P' => 'Prism',
          'PP' => 'Oppo Browser',
          'P6' => 'Opus Browser',
          'PR' => 'Palm Pre',
          '2E' => 'Pocket Internet Explorer',
          '7I' => 'Puffin Cloud Browser',
          '6I' => 'Puffin Incognito Browser',
          'PU' => 'Puffin Secure Browser',
          '2P' => 'Puffin Web Browser',
          'PW' => 'Palm WebPro',
          'PA' => 'Palmscape',
          'P7' => 'Pawxy',
          '0P' => 'Peach Browser',
          'PE' => 'Perfect Browser',
          'K6' => 'Perk',
          'P1' => 'Phantom.me',
          'PH' => 'Phantom Browser',
          'PX' => 'Phoenix',
          'PB' => 'Phoenix Browser',
          '5P' => 'Photon',
          'N9' => 'Pintar Browser',
          'P9' => 'PirateBrowser',
          'P8' => 'PICO Browser',
          'PF' => 'PlayFree Browser',
          'PK' => 'PocketBook Browser',
          'PO' => 'Polaris',
          'PT' => 'Polarity',
          'LY' => 'PolyBrowser',
          '9P' => 'Presearch',
          'BP' => 'Privacy Browser',
          'PI' => 'PrivacyWall',
          'P4' => 'Privacy Explorer Fast Safe',
          'X5' => 'Privacy Pioneer Browser',
          'P3' => 'Private Internet Browser',
          'P5' => 'Proxy Browser',
          '7P' => 'Proxyium',
          '6P' => 'Proxynet',
          '2F' => 'ProxyFox',
          '2M' => 'ProxyMax',
          'P2' => 'Pi Browser',
          'P0' => 'PronHub Browser',
          'PC' => 'PSI Secure Browser',
          'RW' => 'Reqwireless WebViewer',
          'RO' => 'Roccat',
          'PS' => 'Microsoft Edge',
          'QA' => 'Qazweb',
          'QI' => 'Qiyu',
          'QJ' => 'QJY TV Browser',
          'Q3' => 'Qmamu',
          'Q4' => 'Quick Search TV',
          'Q2' => 'QQ Browser Lite',
          'Q1' => 'QQ Browser Mini',
          'QQ' => 'QQ Browser',
          'QS' => 'Quick Browser',
          'QT' => 'Qutebrowser',
          'QU' => 'Quark',
          'Q6' => 'QuarkPC',
          'Q7' => 'Quetta',
          'QZ' => 'QupZilla',
          'QM' => 'Qwant Mobile',
          'Q5' => 'QtWeb',
          'QW' => 'QtWebEngine',
          'R3' => 'Rakuten Browser',
          'R4' => 'Rakuten Web Search',
          'R2' => 'Raspbian Chromium',
          'RT' => 'RCA Tor Explorer',
          'RE' => 'Realme Browser',
          'RK' => 'Rekonq',
          'RM' => 'RockMelt',
          'RB' => 'Roku Browser',
          'SB' => 'Samsung Browser',
          '3L' => 'Samsung Browser Lite',
          'SA' => 'Sailfish Browser',
          'R0' => 'SberBrowser',
          'S8' => 'Seewo Browser',
          'SC' => 'SEMC-Browser',
          'SE' => 'Sogou Explorer',
          'SO' => 'Sogou Mobile Browser',
          'RF' => 'SOTI Surf',
          '2S' => 'Soul Browser',
          'T0' => 'Soundy Browser',
          'SF' => 'Safari',
          'PV' => 'Safari Technology Preview',
          'S5' => 'Safe Exam Browser',
          'SW' => 'SalamWeb',
          'VN' => 'Savannah Browser',
          'SD' => 'SavySoda',
          'S9' => 'Secure Browser',
          'SV' => 'SFive',
          'SH' => 'Shiira',
          'K1' => 'Sidekick',
          'S1' => 'SimpleBrowser',
          '3S' => 'SilverMob US',
          'ZB' => 'Singlebox',
          'SY' => 'Sizzy',
          'K3' => 'Skye',
          'SK' => 'Skyfire',
          'KL' => 'SkyLeap',
          'SS' => 'Seraphic Sraf',
          'KK' => 'SiteKiosk',
          'SL' => 'Sleipnir',
          '8B' => 'SlimBoat',
          'S6' => 'Slimjet',
          'S7' => 'SP Browser',
          '9S' => 'Sony Small Browser',
          '8S' => 'Secure Private Browser',
          'X2' => 'SecureX',
          'T1' => 'Stampy Browser',
          '7S' => '7Star',
          'SQ' => 'Smart Browser',
          '6S' => 'Smart Search & Web Browser',
          'LE' => 'Smart Lenovo Browser',
          'OZ' => 'Smooz',
          'SN' => 'Snowshoe',
          'K5' => 'Spark',
          'B1' => 'Spectre Browser',
          'S2' => 'Splash',
          'SI' => 'Sputnik Browser',
          'SR' => 'Sunrise',
          '0S' => 'Sunflower Browser',
          'SP' => 'SuperBird',
          'SU' => 'Super Fast Browser',
          '5S' => 'SuperFast Browser',
          'HR' => 'Sushi Browser',
          'S3' => 'surf',
          '4S' => 'Surf Browser',
          'RY' => 'Surfy Browser',
          'SG' => 'Stargon',
          'S0' => 'START Internet Browser',
          '5A' => 'Stealth Browser',
          'S4' => 'Steam In-Game Overlay',
          'ST' => 'Streamy',
          'SX' => 'Swiftfox',
          'W7' => 'Swiftweasel',
          'SZ' => 'Seznam Browser',
          'W1' => 'Sweet Browser',
          '2X' => 'SX Browser',
          'TP' => 'T+Browser',
          'TR' => 'T-Browser',
          'TO' => 't-online.de Browser',
          'TT' => 'TalkTo',
          'TA' => 'Tao Browser',
          'T2' => 'tararia',
          'TH' => 'Thor',
          '1T' => 'Tor Browser',
          'TF' => 'TenFourFox',
          'TB' => 'Tenta Browser',
          'TE' => 'Tesla Browser',
          'TZ' => 'Tizen Browser',
          'TI' => 'Tint Browser',
          'TL' => 'TrueLocation Browser',
          'TC' => 'TUC Mini Browser',
          'TK' => 'TUSK',
          'TU' => 'Tungsten',
          'TG' => 'ToGate',
          'T3' => 'Total Browser',
          'TQ' => 'TQ Browser',
          'TS' => 'TweakStyle',
          'TV' => 'TV Bro',
          'T4' => 'TV-Browser Internet',
          'U0' => 'U Browser',
          'UB' => 'UBrowser',
          'UC' => 'UC Browser',
          'UH' => 'UC Browser HD',
          'UM' => 'UC Browser Mini',
          'UT' => 'UC Browser Turbo',
          'UI' => 'Ui Browser Mini',
          'UP' => 'UPhone Browser',
          'UR' => 'UR Browser',
          'UZ' => 'Uzbl',
          'UE' => 'Ume Browser',
          'V0' => 'vBrowser',
          'VA' => 'Vast Browser',
          'V3' => 'VD Browser',
          'VR' => 'Veera',
          'VE' => 'Venus Browser',
          'WD' => 'Vewd Browser',
          'V5' => 'VibeMate',
          'N0' => 'Nova Video Downloader Pro',
          'VS' => 'Viasat Browser',
          'VI' => 'Vivaldi',
          'VV' => 'vivo Browser',
          'V2' => 'Vivid Browser Mini',
          'VB' => 'Vision Mobile Browser',
          'V4' => 'Vertex Surf',
          'VM' => 'VMware AirWatch',
          'V6' => 'VMS Mosaic',
          'VK' => 'Vonkeror',
          'VU' => 'Vuhuv',
          'WI' => 'Wear Internet Browser',
          'WP' => 'Web Explorer',
          'W3' => 'Web Browser & Explorer',
          'W5' => 'Webian Shell',
          'W4' => 'WebDiscover',
          'WE' => 'WebPositive',
          'W6' => 'Weltweitimnetz Browser',
          'WX' => 'Wexond',
          'WF' => 'Waterfox',
          'WB' => 'Wave Browser',
          'WA' => 'Wavebox',
          'WH' => 'Whale Browser',
          'W2' => 'Whale TV Browser',
          'WO' => 'wOSBrowser',
          '3W' => 'w3m',
          'WT' => 'WeTab Browser',
          '1W' => 'World Browser',
          'WL' => 'Wolvic',
          'WK' => 'Wukong Browser',
          'WY' => 'Wyzo',
          'YG' => 'YAGI',
          'YJ' => 'Yahoo! Japan Browser',
          'YA' => 'Yandex Browser',
          'Y4' => 'Yandex Browser Corp',
          'YL' => 'Yandex Browser Lite',
          'YN' => 'Yaani Browser',
          'Y2' => 'Yo Browser',
          'YB' => 'Yolo Browser',
          'YO' => 'YouCare',
          'Y3' => 'YouBrowser',
          'YZ' => 'Yuzu Browser',
          'XR' => 'xBrowser',
          'X3' => 'MMBOX XBrowser',
          'XB' => 'X Browser Lite',
          'X0' => 'X-VPN',
          'X1' => 'xBrowser Pro Super Fast',
          'XN' => 'XNX Browser',
          'XT' => 'XtremeCast',
          'XS' => 'xStand',
          'XI' => 'Xiino',
          'X4' => 'XnBrowse',
          'XO' => 'Xooloo Internet',
          'XV' => 'Xvast',
          'ZE' => 'Zetakey',
          'ZV' => 'Zvu',
          'ZI' => 'Zirco Browser',
          'ZR' => 'Zordo Browser',
          'ZT' => 'ZTE Browser'

          # detected browsers in older versions
          # 'IA' => 'Iceape',  => pim
          # 'SM' => 'SeaMonkey',  => pim
        }.freeze

        DOWNCASED_AVAILABLE_BROWSERS = AVAILABLE_BROWSERS.each_with_object({}) do |(short, long), h|
          h[long.downcase] = short
        end.freeze

        # https://github.com/matomo-org/device-detector/blob/master/Parser/Client/Browser.php#L742
        BROWSER_FAMILIES = {
          'Android Browser' => ['AN'],
          'BlackBerry Browser' => ['BB'],
          'Baidu' => %w[BD BS H6],
          'Amiga' => %w[AV AW],
          'Chrome' => %w[
            CH 2B 7S A0 AC A4 AE AH AI
            AO AS BA BM BR C2 C3 C5 C4
            C6 CC CD CE CF CG 1B CI CL
            CM CN CP CR CV CW DA DD DG
            DR EC EE EU EW FA FS GB GI
            H2 HA HE HH HS I3 IR JB KN
            KW LF LL LO M1 MA MD MR MS
            MT MZ NM NR O0 O2 O3 OC PB
            PT QU QW RM S4 S6 S8 S9 SB
            SG SS SU SV SW SY SZ T1 TA
            TB TG TR TS TU TV UB UR VE
            VG VI VM WP WH XV YJ YN FH
            B1 BO HB PC LA LT PD HR HU
            HP IO TP CJ HQ HI PN BW YO
            DC G8 DT AP AK UI SD VN 4S
            2S RF LR SQ BV L1 F0 KS V0
            C8 AZ MM BT N0 P0 F3 VS DU
            D0 P1 O4 8S H3 TE WB K1 P2
            XO U0 B0 VA X0 NX O5 R1 I1
            HO A5 X1 18 B5 B6 TC A6 2X
            F4 YG WR NA DM 1M A7 XN XT
            XB W1 HT B8 F5 B9 WA T0 HC
            O6 P7 LJ LC O7 N2 A8 P8 RB
            1W EV I9 V4 H4 1T M5 0S 0C
            ZR D6 F6 RC WD P3 FT A9 X2
            N3 GD O9 Q3 F7 K2 P5 H5 V3
            K3 Q4 G2 R2 WX XP 3I BG R0
            JO OL GN W4 QI E1 RI 8B 5B
            K4 WK T3 K5 MU 9P K6 VR N9
            M9 F9 0P 0A JR D3 TK BP 2F
            2M K7 1N 8A H7 X3 T4 X4 5O
            8C 3M 6I 2P PU 7I X5 AL 3P
            W2 ZB HN Q6 Q7 H8
          ],
          'Firefox' => %w[
            FF BI BF BH BN C0 CU EI F1
            FB FE AX FM FR FY I4 IF 8P
            IW LH LY MB MN MO MY OA OS
            PI PX QA S5 SX TF TO WF ZV
            FP AD 2I P9 KJ WY VK W5
            7C N7 W7
          ],
          'Internet Explorer' => %w[IE CZ BZ IM PS 3A 4A RN 2E],
          'Konqueror' => ['KO'],
          'NetFront' => ['NF'],
          'NetSurf' => ['NE'],
          'Nokia Browser' => %w[NB DO NO NV],
          'Opera' => %w[OP OG OH OI OM ON OO O1 OX Y1],
          'Safari' => %w[SF S7 MF SO PV],
          'Sailfish Browser' => ['SA']
        }.freeze

        MOBILE_ONLY_BROWSERS = %w[
          36 AH AI BL C1 C4 CB CW DB
          3M DT EU EZ FK FM FR FX GH
          GI GR HA HU IV JB KD M1 MF
          MN MZ NX OC OI OM OZ 2P PI
          PE QU RE S0 S7 SA SB SG SK
          ST SU T1 UH UM UT VE VV WI
          WP YN IO IS HQ RW HI PN BW
          YO PK MR AP AK UI SD VN 4S
          RF LR SQ BV L1 F0 KS V0 C8
          AZ MM BT N0 P0 F3 DU D0 P1
          O4 XO U0 B0 VA X0 A5 X1 18
          B5 B6 TC A6 2X F4 YG WR NA
          DM 1M A7 XN XT XB W1 HT B7
          B9 T0 I8 O6 P7 O8 4B A8 P8
          1W EV Z0 I9 V4 H4 M5 0S 0C
          ZR D6 F6 P3 FT A9 X2 NI FG
          TH N3 GD O9 Q3 F7 K2 N4 P5
          H5 V3 G2 BG OL II TL M6 Y3
          M7 GN JR IG HW 4O OU 5P KE
          5A TT 6P G3 7P VU F8 L4 DK
          DP KL K4 N6 KU WK M8 UP ZT
          9P N8 VR N9 M9 F9 0P 0A 2F
          2M K7 1N 8A H7 X3 X4 5O 6I
          7I X5 3P 2E
        ].freeze

        def parse
          # TODO: https://github.com/matomo-org/device-detector/blob/master/Parser/Client/Browser.php#L971
          browser_from_client_hints = parse_browser_from_client_hints
          browser_from_ua = parse_browser_from_user_agent

          if browser_from_client_hints[:name] && browser_from_client_hints[:version]
            name = browser_from_client_hints[:name]
            version = browser_from_client_hints[:version]
            short = browser_from_client_hints[:short_name]
            engine = ''
            engine_version = ''

            if version =~ /^202[0-4]/
              name = 'Iridium'
              short = 'I1'
            end

            if version =~ /^15/ && browser_from_ua[:version] =~ /^114/
              name = '360 Secure Browser'
              short = '3B'
            end

            if browser_from_ua[:version] && %w[A0 AL HP JR MU OM OP VR].include?(short)
              version = browser_from_ua[:version]
            end

            if name == 'Vewd Browser'
              engine = browser_from_ua[:engine]
              engine_version = browser_from_ua[:engine_version]
            end

            if ['Chromium', 'Chrome Webview'].include?(name) \
              && !browser_from_ua[:name].empty? \
              && !%w[CR CV AN].include?(browser_from_ua[:short_name])
              name = browser_from_ua[:name]
              short = browser_from_ua[:short_name]
              version = browser_from_ua[:version]
            end

            if browser_from_ua[:name] == "#{name} Mobile"
              name = browser_from_ua[:name]
              short = browser_from_ua[:short_name]
            end

            # If user agent detects another browser, but the family matches, we use the detected engine from user agent
            if name != browser_from_ua[:name] && browser_family(name) == browser_family(browser_from_ua[:name])
              engine = browser_from_ua[:engine]
              engine_version = browser_from_ua[:engine_version]
            end

            if name == browser_from_ua[:name]
              engine = browser_from_ua[:engine]
              engine_version = browser_from_ua[:engine_version]
            end

            # TODO: more detailed version detection here
            # https://github.com/matomo-org/device-detector/blob/master/Parser/Client/Browser.php#L1044
            if browser_from_ua[:version] && !browser_from_ua[:version]&.empty? && browser_from_ua[:version].include?(version.to_s) && satisfied_by_version?(
              ">= #{version}", browser_from_ua[:version]
            )

              version = browser_from_ua[:version]
            end

            version = '' if name == 'DuckDuckGo Privacy Browser'

            if engine == 'Blink' && name != 'Iridium' && satisfied_by_version?(
              "> #{engine_version}", browser_from_client_hints[:version]
            )

              engine_version = browser_from_client_hints[:version]
            end
          else

            name = browser_from_ua[:name]
            short = browser_from_ua[:short_name]
            version = browser_from_ua[:version]
            engine = browser_from_ua[:engine]
            engine_version = browser_from_ua[:engine_version]
          end

          family = browser_family(short)

          # TODO: https://github.com/matomo-org/device-detector/blob/6.4.5/Parser/Client/Browser.php#L1066
          app_hash = @browser_hints.parse

          if app_hash&.fetch(:name, nil) != nil
            name = app_hash[:name]
            version ||= ''
            short = browser_short_name(name)

            if @user_agent.match?(%r{Chrome/.+ Safari/537.36}i)
              engine = 'Blink'
              family = browser_family(short) || 'Chrome'
              built_engine_version = build_engine_version(engine)
              if satisfied_by_version?(">= #{engine_version}", built_engine_version)
                engine_version = built_engine_version
              end
            end

            if short.nil?
              raise "Detected browser name '#{name}' was not found in AVAILABLE_BROWSERS. Tried to parse user agent: #{@user_agent}"
            end
          end

          return nil if (name.nil? || name == '') || @user_agent.match?(/Cypress|PhantomJS/)

          engine_version = '' if engine == 'Blink' && name == 'Flow Browser'

          if name == 'Every Browser'
            family = 'Chrome'
            engine = 'Blink'
            engine_version = ''
          end

          if name == 'TV-Browser Internet' && engine == 'Gecko'
            family = 'Chrome'
            engine = 'Blink'
            engine_version = ''
          end

          family = 'Chrome' if name == 'Wolvic' && engine == 'Blink'
          family = 'Firefox' if name == 'Wolvic' && engine == 'Gecko'

          {
            type: 'browser',
            name: name,
            # short_name: short,
            version: version,
            engine: engine,
            engine_version: engine_version,
            family: family
          }
        end

        protected

        def parse_browser_from_client_hints
          name = nil
          version = ''
          short = nil

          brands = @client_hints&.brand_list

          if brands
            brands.each do |info_hash|
              brand = info_hash[:brand]
              brand_version = info_hash[:version]
              brand = apply_client_hint_mapping(brand).to_s

              AVAILABLE_BROWSERS.each do |browser_short, browser_name|
                next unless fuzzy_compare(brand, browser_name) \
                  || fuzzy_compare("#{brand} Browser", browser_name) \
                  || fuzzy_compare(brand, "#{browser_name} Browser")

                name = browser_name
                short = browser_short
                version = brand_version
                break
              end

              break if !empty?(name) && name != 'Chromium' && name != 'Microsoft Edge'
            end

            version = @client_hints.brand_version unless @client_hints.brand_version.empty?
          end

          {
            name: name,
            short_name: short,
            version: build_version(version, [])
          }
        end

        # https://github.com/matomo-org/device-detector/blob/6.4.5/Parser/Client/Browser.php#L1183
        def parse_browser_from_user_agent
          regex, matches = regex_from_user_agent_cache do
            regexes.detect do |regex|
              match = match_user_agent_r(regex[:regex])
              break [regex, match] if match
            end
          end

          if regex.nil?
            return {
              name: '',
              short_name: '',
              version: '',
              engine: '',
              engine_version: ''
            }
          end

          name = build_by_match(regex[:name], matches)
          browser_short = browser_short_name(name)

          if browser_short
            version = build_version(regex[:version], matches)
            engine = build_engine(regex[:engine] || {}, version)
            engine_version = build_engine_version(engine)

            return {
              name: name,
              short_name: browser_short,
              version: version,
              engine: engine,
              engine_version: engine_version
            }
          end

          raise "Detected browser name #{name} was not found in AVAILABLE_BROWSERS. Tried to parse user agent: #{@user_agent}"
        end

        # https://github.com/matomo-org/device-detector/blob/master/Parser/Client/Browser.php#L1238
        def build_engine(engine_data, browser_version)
          engine = engine_data[:default]

          if engine_data[:versions]
            engine_data[:versions].each do |version, version_engine|
              engine = version_engine if !empty?(version) && satisfied_by_version?("> #{version}",
                                                                                   browser_version)
            end
          end

          return engine if engine && !engine.empty?

          @engine_parser.parse[:engine] || ''
        end

        def build_engine_version(engine)
          @engine_version_parser.use(@user_agent, engine)
          result = @engine_version_parser.parse
          result[:version] || ''
        end

        def more_detailed_version(*versions)
          versions.compact.inject do |result, version|
            version.to_s.split('.').size > result.to_s.split('.').size ? version : result
          end
        end

        # https://github.com/matomo-org/device-detector/blob/master/Parser/Client/Browser.php#L927-L945
        def browser_family(browser_label)
          return unless AVAILABLE_BROWSERS.keys.include?(browser_label)

          BROWSER_FAMILIES.find do |_family, browser_labels|
            browser_labels.include?(browser_label)
          end&.first
        end

        def browser_short_name(name)
          DOWNCASED_AVAILABLE_BROWSERS[name.downcase]
        end

        def fixture_file
          'client/browsers.yml'
        end

        def parser_name
          'browser'
        end
      end
    end
  end
end
