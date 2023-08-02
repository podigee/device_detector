require_relative '../spec_helper'

describe DeviceDetector::Device do
  fixture_dir = File.expand_path('../fixtures/devices', __dir__)
  fixture_files = Dir["#{fixture_dir}/*.yml"]
  fixture_files.each do |fixture_file|
    describe File.basename(fixture_file) do
      fixtures = YAML.load_file(fixture_file)
      fixtures.each do |f|
        user_agent = f['user_agent']
        headers = f['headers']

        device = DeviceDetector::Device.new(user_agent, headers)

        describe user_agent do
          it 'should be known' do
            assert device.known?, "isn't known as a device"
          end

          it 'should have the expected model' do
            assert_equal f['device']['model'], device.name, 'failed model detection'
          end

          it 'should have the expected brand' do
            assert_equal f['device']['brand'], device.brand, 'failed brand detection'
          end

          it 'should have the expected type' do
            expected_device_type = DeviceDetector::Device::DEVICE_NAMES[f['device']['type']]
            assert_equal expected_device_type, device.type, 'failed device name detection'
          end
        end
      end
    end
  end
end
