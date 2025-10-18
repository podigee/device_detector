# frozen_string_literal: true

require_relative '../../support/shared_examples/detector_examples'

describe DeviceDetector do
  subject { described_class.new(user_agent, headers) }

  paths = Dir.glob("#{fixtures_dir}/detector/*.yml").reject do |path|
    path.start_with?("#{fixtures_dir}/detector/smartphone-") ||
      path.start_with?("#{fixtures_dir}/detector/tv") ||
      path.start_with?("#{fixtures_dir}/detector/tablet")
  end

  fixtures = load_fixtures(paths)
  fixtures.each do |f|
    describe [f['user_agent'], f['headers']].compact.join(' / ') do
      let(:fixture) { f }

      let(:user_agent) { f['user_agent'] }
      let(:headers) { f['headers'] }

      context 'when it is a bot', if: f['bot'] do
        it_behaves_like 'detector bot examples'
      end

      context 'when it has a client', if: f['client'] do
        it_behaves_like 'detector client examples'
      end

      context 'when it has an OS', if: f['os'].is_a?(Hash) do
        it_behaves_like 'detector OS examples'
      end

      context 'when it has a device', if: f['device'] do
        it_behaves_like 'detector device examples'
      end
    end
  end
end
