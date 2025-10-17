# frozen_string_literal: true

require_relative '../spec_helper'

describe DeviceDetector do
  subject { described_class.new(user_agent, headers) }

  fixture_dir = File.expand_path('../fixtures/client', __dir__)
  fixture_files = Dir["#{fixture_dir}/*.yml"]

  raise 'invalid fixture load path specified' if fixture_files.empty?

  fixture_files.each do |fixture_file|
    describe File.basename(fixture_file) do
      fixtures = YAML.load_file(fixture_file).first(40)
      fixtures.each do |f|
        describe f['user_agent'] do
          let(:fixture) { f }

          let(:user_agent) { f['user_agent'] }
          let(:headers) { f['headers'] }
          let(:client) { f['client'] }
          let(:client_result) { subject.send(:client_result) }

          it 'should be known' do
            expect(subject.known?).to eq true
          end

          it 'should have expected name' do
            expect(subject.name).to eq client['name']
          end
        end
      end
    end
  end
end
