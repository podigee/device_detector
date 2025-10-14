# frozen_string_literal: true

require_relative '../spec_helper'

describe DeviceDetector do
  fixture_dir = File.expand_path('../fixtures/parser', __dir__)
  fixtures = load_fixtures(Dir["#{fixture_dir}/oss.yml"])

  subject { described_class.new(user_agent, headers) }

  fixtures.each do |f|
    let(:user_agent) { f['user_agent'] }
    let(:headers) { f['headers'] }
    let(:os) { f['os'] }
    let(:os_result) { subject.send(:os_result) }

    describe f['user_agent'] do
      it 'should have the expected OS name' do
        expect(subject.os_name).to eq os['name']
      end

      it 'should have the expected OS version' do
        expect(subject.os_full_version).to eq os['version']
      end

      it 'should have the expected OS family' do
        expect(subject.os_family).to eq os['family']
      end

      it 'should have the expected OS short name' do
        expect(os_result[:short_name]).to eq os['short_name']
      end

      it 'should have the expected OS platform' do
        expect(os_result[:platform]).to eq str_or_nil(os['platform'])
      end
    end
  end
end
