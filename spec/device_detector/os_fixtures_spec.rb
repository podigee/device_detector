require_relative '../spec_helper'

describe DeviceDetector::OS do
  fixture_dir = File.expand_path('../fixtures/parser', __dir__)
  fixture_files = Dir["#{fixture_dir}/oss.yml"]
  fixture_files.each do |fixture_file|
    describe File.basename(fixture_file) do
      fixtures = YAML.load(File.read(fixture_file))
      fixtures.each do |f|
        user_agent = f['user_agent']
        headers = f['headers']

        describe user_agent do
          it 'should have the expected name' do
            device = DeviceDetector.new(user_agent, headers)
            assert_equal f['os']['name'], device.os_name, 'failed OS name detection'
          end
        end
      end
    end
  end
end
