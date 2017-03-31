require_relative '../spec_helper'

describe DeviceDetector do

  # This is from Parser/Device/DeviceParserAbstract.php in device-detector
  # For some reason they have all the brand names translated in the tests, so
  # we need to untranslate them.
  # This may need to get updated on occasion.  Luckily language syntax is
  # similar enough that its almost 100% copy&paste
  device_brands = {
    '3Q' => '3Q',
    'AC' => 'Acer',
    'AZ' => 'Ainol',
    'AI' => 'Airness',
    'AL' => 'Alcatel',
    'A2' => 'Allview',
    'A1' => 'Altech UEC',
    'AN' => 'Arnova',
    'KN' => 'Amazon',
    'AO' => 'Amoi',
    'AP' => 'Apple',
    'AR' => 'Archos',
    'AS' => 'ARRIS',
    'AT' => 'Airties',
    'AU' => 'Asus',
    'AV' => 'Avvio',
    'AX' => 'Audiovox',
    'AY' => 'Axxion',
    'BB' => 'BBK',
    'BE' => 'Becker',
    'BI' => 'Bird',
    'BL' => 'Beetel',
    'BM' => 'Bmobile',
    'BN' => 'Barnes & Noble',
    'BO' => 'BangOlufsen',
    'BQ' => 'BenQ',
    'BS' => 'BenQ-Siemens',
    'BU' => 'Blu',
    'BW' => 'Boway',
    'BX' => 'bq',
    'BV' => 'Bravis',
    'BR' => 'Brondi',
    'B1' => 'Bush',
    'CB' => 'CUBOT',
    'CF' => 'Carrefour',
    'CP' => 'Captiva',
    'CS' => 'Casio',
    'CA' => 'Cat',
    'CE' => 'Celkon',
    'CC' => 'ConCorde',
    'C2' => 'Changhong',
    'CH' => 'Cherry Mobile',
    'CK' => 'Cricket',
    'C1' => 'Crosscall',
    'CL' => 'Compal',
    'CN' => 'CnM',
    'CM' => 'Crius Mea',
    'CR' => 'CreNova',
    'CT' => 'Capitel',
    'CQ' => 'Compaq',
    'CO' => 'Coolpad',
    'CW' => 'Cowon',
    'CU' => 'Cube',
    'CY' => 'Coby Kyros',
    'DA' => 'Danew',
    'DT' => 'Datang',
    'DE' => 'Denver',
    'DS' => 'Desay',
    'DB' => 'Dbtel',
    'DC' => 'DoCoMo',
    'DI' => 'Dicam',
    'DL' => 'Dell',
    'DN' => 'DNS',
    'DM' => 'DMM',
    'DO' => 'Doogee',
    'DV' => 'Doov',
    'DP' => 'Dopod',
    'DU' => 'Dune HD',
    'EB' => 'E-Boda',
    'EA' => 'EBEST',
    'EC' => 'Ericsson',
    'ES' => 'ECS',
    'EI' => 'Ezio',
    'EL' => 'Elephone',
    'EP' => 'Easypix',
    'E1' => 'Energy Sistem',
    'ER' => 'Ericy',
    'EN' => 'Eton',
    'ET' => 'eTouch',
    'EV' => 'Evertek',
    'EX' => 'Explay',
    'EZ' => 'Ezze',
    'FA' => 'Fairphone',
    'FL' => 'Fly',
    'FO' => 'Foxconn',
    'FU' => 'Fujitsu',
    'GM' => 'Garmin-Asus',
    'GA' => 'Gateway',
    'GD' => 'Gemini',
    'GI' => 'Gionee',
    'GG' => 'Gigabyte',
    'GS' => 'Gigaset',
    'GC' => 'GOCLEVER',
    'GL' => 'Goly',
    'GO' => 'Google',
    'GR' => 'Gradiente',
    'GU' => 'Grundig',
    'HA' => 'Haier',
    'HS' => 'Hasee',
    'HI' => 'Hisense',
    'HL' => 'Hi-Level',
    'HM' => 'Homtom',
    'HO' => 'Hosin',
    'HP' => 'HP',
    'HT' => 'HTC',
    'HU' => 'Huawei',
    'HX' => 'Humax',
    'HY' => 'Hyrican',
    'HN' => 'Hyundai',
    'IA' => 'Ikea',
    'IB' => 'iBall',
    'IJ' => 'i-Joy',
    'IY' => 'iBerry',
    'IK' => 'iKoMo',
    'IM' => 'i-mate',
    'I1' => 'iOcean',
    'IW' => 'iNew',
    'IF' => 'Infinix',
    'IN' => 'Innostream',
    'II' => 'Inkti',
    'IX' => 'Intex',
    'IO' => 'i-mobile',
    'IQ' => 'INQ',
    'IT' => 'Intek',
    'IV' => 'Inverto',
    'IZ' => 'iTel',
    'JI' => 'Jiayu',
    'JO' => 'Jolla',
    'KA' => 'Karbonn',
    'KD' => 'KDDI',
    'K1' => 'Kiano',
    'KI' => 'Kingsun',
    'KO' => 'Konka',
    'KM' => 'Komu',
    'KB' => 'Koobee',
    'KT' => 'K-Touch',
    'KH' => 'KT-Tech',
    'KP' => 'KOPO',
    'KR' => 'Koridy',
    'KU' => 'Kumai',
    'KY' => 'Kyocera',
    'KZ' => 'Kazam',
    'LV' => 'Lava',
    'LA' => 'Lanix',
    'LC' => 'LCT',
    'L1' => 'LeEco',
    'LE' => 'Lenovo',
    'LN' => 'Lenco',
    'LP' => 'Le Pan',
    'LG' => 'LG',
    'LI' => 'Lingwin',
    'LO' => 'Loewe',
    'LM' => 'Logicom',
    'LX' => 'Lexibook',
    'MJ' => 'Majestic',
    'MA' => 'Manta Multimedia',
    'MB' => 'Mobistel',
    'M3' => 'Mecer',
    'MD' => 'Medion',
    'M2' => 'MEEG',
    'M1' => 'Meizu',
    'ME' => 'Metz',
    'MX' => 'MEU',
    'MI' => 'MicroMax',
    'M5' => 'MIXC',
    'MC' => 'Mediacom',
    'MK' => 'MediaTek',
    'MO' => 'Mio',
    'MM' => 'Mpman',
    'M4' => 'Modecom',
    'MF' => 'Mofut',
    'MR' => 'Motorola',
    'MS' => 'Microsoft',
    'MZ' => 'MSI',
    'MU' => 'Memup',
    'MT' => 'Mitsubishi',
    'ML' => 'MLLED',
    'MQ' => 'M.T.T.',
    'MY' => 'MyPhone',
    'NE' => 'NEC',
    'NA' => 'Netgear',
    'NG' => 'NGM',
    'NO' => 'Nous',
    'NI' => 'Nintendo',
    'N1' => 'Noain',
    'NK' => 'Nokia',
    'NM' => 'Nomi',
    'NN' => 'Nikon',
    'NW' => 'Newgen',
    'NX' => 'Nexian',
    'NT' => 'NextBook',
    'OD' => 'Onda',
    'ON' => 'OnePlus',
    'OP' => 'OPPO',
    'OR' => 'Orange',
    'OT' => 'O2',
    'OK' => 'Ouki',
    'OU' => 'OUYA',
    'OO' => 'Opsson',
    'PA' => 'Panasonic',
    'PE' => 'PEAQ',
    'PG' => 'Pentagram',
    'PH' => 'Philips',
    'PI' => 'Pioneer',
    'PL' => 'Polaroid',
    'PM' => 'Palm',
    'PO' => 'phoneOne',
    'PT' => 'Pantech',
    'PY' => 'Ployer',
    'PV' => 'Point of View',
    'PP' => 'PolyPad',
    'P2' => 'Pomp',
    'PS' => 'Positivo',
    'PR' => 'Prestigio',
    'P1' => 'ProScan',
    'PU' => 'PULID',
    'QI' => 'Qilive',
    'QT' => 'Qtek',
    'QM' => 'QMobile',
    'QU' => 'Quechua',
    'OV' => 'Overmax',
    'OY' => 'Oysters',
    'RA' => 'Ramos',
    'RC' => 'RCA Tablets',
    'RB' => 'Readboy',
    'RI' => 'Rikomagic',
    'RM' => 'RIM',
    'RK' => 'Roku',
    'RO' => 'Rover',
    'SA' => 'Samsung',
    'SD' => 'Sega',
    'SE' => 'Sony Ericsson',
    'S1' => 'Sencor',
    'SF' => 'Softbank',
    'SX' => 'SFR',
    'SG' => 'Sagem',
    'SH' => 'Sharp',
    'SI' => 'Siemens',
    'SN' => 'Sendo',
    'S6' => 'Senseit',
    'SK' => 'Skyworth',
    'SC' => 'Smartfren',
    'SO' => 'Sony',
    'SP' => 'Spice',
    'SU' => 'SuperSonic',
    'S5' => 'Supra',
    'SV' => 'Selevision',
    'SY' => 'Sanyo',
    'SM' => 'Symphony',
    'SR' => 'Smart',
    'S7' => 'Smartisan',
    'S4' => 'Star',
    'ST' => 'Storex',
    'S2' => 'Stonex',
    'S3' => 'SunVan',
    'SZ' => 'Sumvision',
    'TA' => 'Tesla',
    'T5' => 'TB Touch',
    'TC' => 'TCL',
    'TE' => 'Telit',
    'T4' => 'ThL',
    'TH' => 'TiPhone',
    'TB' => 'Tecno Mobile',
    'TD' => 'Tesco',
    'TI' => 'TIANYU',
    'TL' => 'Telefunken',
    'T2' => 'Telenor',
    'TM' => 'T-Mobile',
    'TN' => 'Thomson',
    'T1' => 'Tolino',
    'TO' => 'Toplux',
    'TS' => 'Toshiba',
    'TT' => 'TechnoTrend',
    'T3' => 'Trevi',
    'TU' => 'Tunisie Telecom',
    'TR' => 'Turbo-X',
    'TV' => 'TVC',
    'TX' => 'TechniSat',
    'TZ' => 'teXet',
    'UN' => 'Unowhy',
    'US' => 'Uniscope',
    'UT' => 'UTStarcom',
    'VA' => 'Vastking',
    'VD' => 'Videocon',
    'VE' => 'Vertu',
    'VI' => 'Vitelcom',
    'VK' => 'VK Mobile',
    'VS' => 'ViewSonic',
    'VT' => 'Vestel',
    'VV' => 'Vivo',
    'V1' => 'Voto',
    'VO' => 'Voxtel',
    'VF' => 'Vodafone',
    'VZ' => 'Vizio',
    'VW' => 'Videoweb',
    'WA' => 'Walton',
    'WE' => 'WellcoM',
    'WY' => 'Wexler',
    'WI' => 'Wiko',
    'WL' => 'Wolder',
    'WO' => 'Wonu',
    'WX' => 'Woxter',
    'XI' => 'Xiaomi',
    'XO' => 'Xolo',
    'YA' => 'Yarvik',
    'YU' => 'Yuandao',
    'YS' => 'Yusun',
    'YT' => 'Ytone',
    'ZE' => 'Zeemi',
    'ZO' => 'Zonda',
    'ZP' => 'Zopo',
    'ZT' => 'ZTE',

    # // legacy brands, might be removed in future versions
    'WB' => 'Web TV',
    'XX' => 'Unknown'
  }

  fixture_dir = File.expand_path('../../fixtures/detector', __FILE__)
  fixture_files = Dir["#{fixture_dir}/*.yml"]
  fixture_files.each do |fixture_file|

    describe File.basename(fixture_file) do

      fixtures = nil
      begin
        fixtures = YAML.load(File.read(fixture_file))
      rescue Psych::SyntaxError => e
        fail "Failed to parse #{fixture_file}, reason: #{e}"
      end

      fixtures.each do |f|

        user_agent = f["user_agent"]
        detector = DeviceDetector.new(user_agent)
        os = detector.send(:os)

        describe user_agent do
          it "should be detected" do
            if detector.bot?
              assert_equal f["bot"]["name"], detector.bot_name, "failed bot name detection"
            else
              if f["client"]
                assert_equal f["client"]["name"], detector.name, "failed client name detection"
              end
              if f["os_family"] != "Unknown"
                assert_equal f["os_family"], os.family, "failed os family detection"
                assert_equal f["os"]["name"], os.name, "failed os name detection"
                assert_equal f["os"]["short_name"], os.short_name, "failed os short name detection"
                if f["os"]["version"].nil?
                  assert_nil os.full_version, "failed os version detection"
                else
                  assert_equal f["os"]["version"], os.full_version, "failed os version detection"
                end
              end
              if f["device"]
                expected_type = f["device"]["type"]
                actual_type = detector.device_type
                if expected_type != actual_type
                  # puts "\n", f.inspect, expected_type, actual_type, detector.device_name, regex_meta.inspect
                  # debugger
                  # detector.device_type
                end
                if expected_type.nil?
                  assert_nil actual_type, "failed device type detection"
                else
                  assert_equal expected_type, actual_type, "failed device type detection"
                end
                model = f["device"]["model"]
                if model.nil?
                  assert_nil detector.device_name, "failed device name detection"
                else
                  assert_equal model.to_s, detector.device_name, "failed device name detection"
                end

                if f['device']['brand'].nil?
                  assert_nil detector.device_brand, 'failed device brand detection'
                else
                  assert_equal device_brands[f['device']['brand']], detector.device_brand, 'failed device brand detection'
                end
              end
            end
          end
        end
      end

    end

  end

end
