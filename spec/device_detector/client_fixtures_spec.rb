# frozen_string_literal: true

require_relative '../spec_helper'

describe DeviceDetector do
  fixture_dir = File.expand_path('../fixtures/client', __dir__)
  fixtures = load_fixtures(Dir["#{fixture_dir}/*.yml"])

  subject { described_class.new(user_agent, headers) }

  fixtures.each do |f|
    let(:user_agent) { f['user_agent'] }
    let(:headers) { f['headers'] }

    let(:client) { f['client'] }
    let(:client_result) { subject.send(:client_result) }

    describe f['user_agent'] do
      it 'should be known' do
        expect(subject.known?).to eq true
      end

      it 'should have expected name' do
        expect(subject.name).to eq client['name']
      end

      it 'should have expected version' do
        expect(subject.full_version).to eq client['version']
      end

      it 'should have expected type' do
        expect(client_result[:type]).to eq client['type']
      end
    end
  end
end
