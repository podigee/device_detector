# frozen_string_literal: true

require_relative '../spec_helper'

describe DeviceDetector do
  subject { described_class.new(user_agent, headers) }

  fixture_dir = File.expand_path('../fixtures/parser', __dir__)
  fixture_files = Dir["#{fixture_dir}/oss.yml"]

  raise 'invalid fixture load path specified' if fixture_files.empty?

  fixture_files.each do |fixture_file|
    describe File.basename(fixture_file) do
      fixtures = YAML.load_file(fixture_file)
      fixtures.each do |f|
        describe f['user_agent'] do
          let(:fixture) { f }

          let(:user_agent) { f['user_agent'] }
          let(:headers) { f['headers'] }
          let(:os) { f['os'] }
          let(:os_result) { subject.send(:os_result) }

          it 'should have the expected OS name' do
            expect(subject.os_name).to eq os['name']
          end

          it 'should have the expected OS version', if: os_version?(f) do
            expect(subject.os_full_version).to eq os['version']
          end

          it 'should have the expected OS family' do
            expect(subject.os_family).to eq os['family']
          end

          it 'should have the expected OS platform', if: os_platform?(f) do
            expect(os_result[:platform]).to eq os['platform']
          end
        end
      end
    end
  end
end
