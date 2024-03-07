# frozen_string_literal: true

class DeviceDetector
  class Browser
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
      'BW' => 'AdBlock Browser',
      'A7' => 'Adult Browser',
      'A9' => 'Airfind Secure Browser',
      'AF' => 'ANT Fresco',
      'AG' => 'ANTGalio',
      'AL' => 'Aloha Browser',
      'AH' => 'Aloha Browser Lite',
      'A8' => 'ALVA',
      'AM' => 'Amaya',
      'A3' => 'Amaze Browser',
      'A5' => 'Amerigo',
      'AO' => 'Amigo',
      'AN' => 'Android Browser',
      'AE' => 'AOL Desktop',
      'AD' => 'AOL Shield',
      'A4' => 'AOL Shield Pro',
      'A6' => 'AppBrowzer',
      'AP' => 'APUS Browser',
      'AR' => 'Arora',
      'AX' => 'Arctic Fox',
      'AV' => 'Amiga Voyager',
      'AW' => 'Amiga Aweb',
      'PN' => 'APN Browser',
      'RA' => 'Arc',
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
      'BA' => 'Beaker Browser',
      'BM' => 'Beamrise',
      'F7' => 'BF Browser',
      'BB' => 'BlackBerry Browser',
      'H1' => 'BrowseHere',
      'B8' => 'Browser Hup Pro',
      'BD' => 'Baidu Browser',
      'BS' => 'Baidu Spark',
      'B9' => 'Bangla Browser',
      'BI' => 'Basilisk',
      'BV' => 'Belva Browser',
      'B5' => 'Beyond Private Browser',
      'BE' => 'Beonex',
      'B2' => 'Berry Browser',
      'BT' => 'Bitchute Browser',
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
      '4B' => 'BrowsBit',
      'BY' => 'Biyubi',
      'BF' => 'Byffox',
      'B4' => 'BXE Browser',
      'CA' => 'Camino',
      '0C' => 'Cave Browser',
      'CL' => 'CCleaner',
      'C8' => 'CG Browser',
      'CJ' => 'ChanjetCloud',
      'C6' => 'Chedot',
      'C9' => 'Cherry Browser',
      'C0' => 'Centaury',
      'CC' => 'Coc Coc',
      'C4' => 'CoolBrowser',
      'C2' => 'Colibri',
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
      'CN' => 'CoolNovo',
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
      'RC' => 'Crow Browser',
      'CT' => 'Crusta',
      'CG' => 'Craving Explorer',
      'CZ' => 'Crazy Browser',
      'CU' => 'Cunaguaro',
      'CV' => 'Chrome Webview',
      'YC' => 'CyBrowser',
      'DB' => 'dbrowser',
      'PD' => 'Peeps dBrowser',
      'D1' => 'Debuggable Browser',
      'DC' => 'Decentr',
      'DE' => 'Deepnet Explorer',
      'DG' => 'deg-degan',
      'DA' => 'Deledao',
      'DT' => 'Delta Browser',
      'D0' => 'Desi Browser',
      'DS' => 'DeskBrowse',
      'D2' => 'DoCoMo',
      'DF' => 'Dolphin',
      'DZ' => 'Dolphin Zero',
      'DO' => 'Dorado',
      'DR' => 'Dot Browser',
      'DL' => 'Dooble',
      'DI' => 'Dillo',
      'DU' => 'DUC Browser',
      'DD' => 'DuckDuckGo Privacy Browser',
      'EC' => 'Ecosia',
      'EW' => 'Edge WebView',
      'EV' => 'Every Browser',
      'EI' => 'Epic',
      'EL' => 'Elinks',
      'EN' => 'EinkBro',
      'EB' => 'Element Browser',
      'EE' => 'Elements Browser',
      'EX' => 'Explore Browser',
      'EZ' => 'eZ Browser',
      'EU' => 'EUI Browser',
      'EP' => 'GNOME Web',
      'G1' => 'G Browser',
      'ES' => 'Espial TV Browser',
      'FG' => 'fGet',
      'FA' => 'Falkon',
      'FX' => 'Faux Browser',
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
      'GE' => 'Google Earth',
      'GP' => 'Google Earth Pro',
      'GO' => 'GOG Galaxy',
      'GR' => 'GoBrowser',
      'G2' => 'GO Browser',
      'HB' => 'Harman Browser',
      'HS' => 'HasBrowser',
      'HA' => 'Hawk Turbo Browser',
      'HQ' => 'Hawk Quick Browser',
      'HE' => 'Helio',
      'HX' => 'Hexa Web Browser',
      'HI' => 'Hi Browser',
      'HO' => 'hola! Browser',
      'H4' => 'Holla Web Browser',
      'H5' => 'HotBrowser',
      'HJ' => 'HotJava',
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
      'I1' => 'Iridium',
      'I3' => 'Iron Mobile',
      'I4' => 'IceCat',
      'ID' => 'IceDragon',
      'IV' => 'Isivioo',
      'I8' => 'IVVI Browser',
      'IW' => 'Iceweasel',
      'N3' => 'Incognito Browser',
      'IN' => 'Inspect Browser',
      'I9' => 'Insta Browser',
      'IE' => 'Internet Explorer',
      'I7' => 'Internet Browser Secure',
      'I5' => 'Indian UC Mini Browser',
      'Z0' => 'InBrowser',
      'IM' => 'IE Mobile',
      'IR' => 'Iron',
      'JB' => 'Japan Browser',
      'JS' => 'Jasmine',
      'JA' => 'JavaFX',
      'JL' => 'Jelly',
      'JI' => 'Jig Browser',
      'JP' => 'Jig Browser Plus',
      'JO' => 'JioSphere',
      'KB' => 'K.Browser',
      'KF' => 'Keepsafe Browser',
      'KS' => 'Kids Safe Browser',
      'KI' => 'Kindle Browser',
      'KM' => 'K-meleon',
      'KO' => 'Konqueror',
      'KP' => 'Kapiko',
      'KN' => 'Kinza',
      'KW' => 'Kiwi',
      'KD' => 'Kode Browser',
      'KT' => 'KUTO Mini Browser',
      'KY' => 'Kylo',
      'KZ' => 'Kazehakase',
      'LB' => 'Cheetah Browser',
      'LA' => 'Lagatos Browser',
      'LR' => 'Lexi Browser',
      'LV' => 'Lenovo Browser',
      'LF' => 'LieBaoFast',
      'LG' => 'LG Browser',
      'LH' => 'Light',
      'L1' => 'Lilo',
      'LI' => 'Links',
      'LC' => 'LogicUI TV Browser',
      'IF' => 'Lolifox',
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
      'M5' => 'MarsLab Web Browser',
      'M1' => 'mCent',
      'MB' => 'MicroB',
      'MC' => 'NCSA Mosaic',
      'MZ' => 'Meizu Browser',
      'ME' => 'Mercury',
      'M2' => 'Me Browser',
      'MF' => 'Mobile Safari',
      'MI' => 'Midori',
      'M3' => 'Midori Lite',
      'MO' => 'Mobicip',
      'MU' => 'MIUI Browser',
      'MS' => 'Mobile Silk',
      'MN' => 'Minimo',
      'MT' => 'Mint Browser',
      'MX' => 'Maxthon',
      'M4' => 'MaxTube Browser',
      'MA' => 'Maelstrom',
      'MM' => 'Mmx Browser',
      'NM' => 'MxNitro',
      'MY' => 'Mypal',
      'MR' => 'Monument Browser',
      'MW' => 'MAUI WAP Browser',
      'NW' => 'Navigateur Web',
      'NK' => 'Naked Browser',
      'NA' => 'Naked Browser Pro',
      'NR' => 'NFS Browser',
      'NB' => 'Nokia Browser',
      'NO' => 'Nokia OSS Browser',
      'NV' => 'Nokia Ovi Browser',
      'N2' => 'Norton Private Browser',
      'NX' => 'Nox Browser',
      'N1' => 'NOMone VR Browser',
      'NE' => 'NetSurf',
      'NF' => 'NetFront',
      'NL' => 'NetFront Life',
      'NP' => 'NetPositive',
      'NS' => 'Netscape',
      'WR' => 'NextWord Browser',
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
      'OE' => 'ONE Browser',
      'N4' => 'Onion Browser',
      'Y1' => 'Opera Crypto',
      'OX' => 'Opera GX',
      'OG' => 'Opera Neon',
      'OH' => 'Opera Devices',
      'OI' => 'Opera Mini',
      'OM' => 'Opera Mobile',
      'OP' => 'Opera',
      'ON' => 'Opera Next',
      'OO' => 'Opera Touch',
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
      'O7' => 'Open TV Browser',
      'OW' => 'OmniWeb',
      'OT' => 'Otter Browser',
      'PL' => 'Palm Blazer',
      'PM' => 'Pale Moon',
      'PY' => 'Polypane',
      'PP' => 'Oppo Browser',
      'P6' => 'Opus Browser',
      'PR' => 'Palm Pre',
      'PU' => 'Puffin',
      '2P' => 'Puffin Web Browser',
      'PW' => 'Palm WebPro',
      'PA' => 'Palmscape',
      'P7' => 'Pawxy',
      'PE' => 'Perfect Browser',
      'P1' => 'Phantom.me',
      'PH' => 'Phantom Browser',
      'PX' => 'Phoenix',
      'PB' => 'Phoenix Browser',
      'P8' => 'PICO Browser',
      'PF' => 'PlayFree Browser',
      'PK' => 'PocketBook Browser',
      'PO' => 'Polaris',
      'PT' => 'Polarity',
      'LY' => 'PolyBrowser',
      'PI' => 'PrivacyWall',
      'P4' => 'Privacy Explorer Fast Safe',
      'P3' => 'Private Internet Browser',
      'P5' => 'Proxy Browser',
      'P2' => 'Pi Browser',
      'P0' => 'PronHub Browser',
      'PC' => 'PSI Secure Browser',
      'RW' => 'Reqwireless WebViewer',
      'PS' => 'Microsoft Edge',
      'QA' => 'Qazweb',
      'Q3' => 'Qmamu',
      'Q4' => 'Quick Search TV',
      'Q2' => 'QQ Browser Lite',
      'Q1' => 'QQ Browser Mini',
      'QQ' => 'QQ Browser',
      'QS' => 'Quick Browser',
      'QT' => 'Qutebrowser',
      'QU' => 'Quark',
      'QZ' => 'QupZilla',
      'QM' => 'Qwant Mobile',
      'QW' => 'QtWebEngine',
      'R2' => 'Raspbian Chromium',
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
      'SY' => 'Sizzy',
      'K3' => 'Skye',
      'SK' => 'Skyfire',
      'SS' => 'Seraphic Sraf',
      'KK' => 'SiteKiosk',
      'SL' => 'Sleipnir',
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
      'SG' => 'Stargon',
      'S0' => 'START Internet Browser',
      'S4' => 'Steam In-Game Overlay',
      'ST' => 'Streamy',
      'SX' => 'Swiftfox',
      'SZ' => 'Seznam Browser',
      'W1' => 'Sweet Browser',
      '2X' => 'SX Browser',
      'TP' => 'T+Browser',
      'TR' => 'T-Browser',
      'TO' => 't-online.de Browser',
      'TA' => 'Tao Browser',
      'TH' => 'Thor',
      '1T' => 'Tor Browser',
      'TF' => 'TenFourFox',
      'TB' => 'Tenta Browser',
      'TE' => 'Tesla Browser',
      'TZ' => 'Tizen Browser',
      'TI' => 'Tint Browser',
      'TC' => 'TUC Mini Browser',
      'TU' => 'Tungsten',
      'TG' => 'ToGate',
      'TS' => 'TweakStyle',
      'TV' => 'TV Bro',
      'U0' => 'U Browser',
      'UB' => 'UBrowser',
      'UC' => 'UC Browser',
      'UH' => 'UC Browser HD',
      'UM' => 'UC Browser Mini',
      'UT' => 'UC Browser Turbo',
      'UI' => 'Ui Browser Mini',
      'UR' => 'UR Browser',
      'UZ' => 'Uzbl',
      'UE' => 'Ume Browser',
      'V0' => 'vBrowser',
      'VA' => 'Vast Browser',
      'V3' => 'VD Browser',
      'VE' => 'Venus Browser',
      'WD' => 'Vewd Browser',
      'N0' => 'Nova Video Downloader Pro',
      'VS' => 'Viasat Browser',
      'VI' => 'Vivaldi',
      'VV' => 'vivo Browser',
      'V2' => 'Vivid Browser Mini',
      'VB' => 'Vision Mobile Browser',
      'V4' => 'Vertex Surf',
      'VM' => 'VMware AirWatch',
      'WI' => 'Wear Internet Browser',
      'WP' => 'Web Explorer',
      'W3' => 'Web Browser & Explorer',
      'WE' => 'WebPositive',
      'WF' => 'Waterfox',
      'WB' => 'Wave Browser',
      'WA' => 'Wavebox',
      'WH' => 'Whale Browser',
      'WO' => 'wOSBrowser',
      'WT' => 'WeTab Browser',
      '1W' => 'World Browser',
      'WL' => 'Wolvic',
      'YG' => 'YAGI',
      'YJ' => 'Yahoo! Japan Browser',
      'YA' => 'Yandex Browser',
      'YL' => 'Yandex Browser Lite',
      'YN' => 'Yaani Browser',
      'Y2' => 'Yo Browser',
      'YB' => 'Yolo Browser',
      'YO' => 'YouCare',
      'YZ' => 'Yuzu Browser',
      'XR' => 'xBrowser',
      'XB' => 'X Browser Lite',
      'X0' => 'X-VPN',
      'X1' => 'xBrowser Pro Super Fast',
      'XN' => 'XNX Browser',
      'XT' => 'XtremeCast',
      'XS' => 'xStand',
      'XI' => 'Xiino',
      'XO' => 'Xooloo Internet',
      'XV' => 'Xvast',
      'ZE' => 'Zetakey',
      'ZV' => 'Zvu',
      'ZI' => 'Zirco Browser',
      'ZR' => 'Zordo Browser'

      # detected browsers in older versions
      # 'IA' => 'Iceape',  => pim
      # 'SM' => 'SeaMonkey',  => pim
    }.freeze

    BROWSER_FULL_TO_SHORT = AVAILABLE_BROWSERS.invert.freeze

    MOBILE_ONLY_BROWSERS = Set.new(
      %w[
        36 AH AI BL C1 C4 CB CW DB
        DD DT EU EZ FK FM FR FX GH
        GI GR HA HU IV JB KD M1 MF
        MN MZ NX OC OI OM OZ PU PI
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
        H5 V3 G2
      ]
    ).freeze

    def self.mobile_only_browser?(name)
      return true if MOBILE_ONLY_BROWSERS.include?(name)

      short = BROWSER_FULL_TO_SHORT[name]
      MOBILE_ONLY_BROWSERS.include?(short)
    end
  end
end
