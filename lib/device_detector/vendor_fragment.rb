class DeviceDetector
  class VendorFragment < Parser


    def brand
      regex_meta[:brand] && regex_meta[:brand].to_s
    end

    private

    def filenames
      [
        'vendorfragments.yml',
      ]
    end

    def matching_regex
      # This is intentionally not cached.  This will only be called from Device,
      # which does its own caching.  Caching here as well would just cause
      # cache slots to be wasted
      regexes.find { |r| user_agent =~ r[:regex] }
    end

    def parse_regexes(path, raw_regexes)
      raw_regexes.flat_map do |brand, regex_list|
        regex_list.map do |r|
          {
            regex: build_regex(r),
            brand: brand,
          }
        end
      end
    end

  end
end
