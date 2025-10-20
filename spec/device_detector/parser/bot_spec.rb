# frozen_string_literal: true

describe DeviceDetector::Parser::Bot do
  subject(:parser) { described_class.new }

  let(:user_agent) { 'AdsBot-Google (+http://www.google.com/adsbot.html)' }

  before do
    parser.use(user_agent, nil)
  end

  after do
    described_class.reset_custom_fixtures!
    DeviceDetector.reset_cache!
  end

  describe '.add_fixture_path' do
    it 'adds new fixture path to class instancevar' do
      expect { described_class.add_fixture_path('some/path/to/fixture.yaml') }
        .to change(described_class, :custom_fixture_paths)
        .from([]).to(['some/path/to/fixture.yaml'])
    end
  end

  describe '.reset_custom_fixtures!' do
    before do
      described_class.add_fixture_path('some/path/to/fixture.yaml')
    end

    it 'resets fixture paths to class to default' do
      expect { described_class.reset_custom_fixtures! }
        .to change(described_class, :custom_fixture_paths)
        .from(['some/path/to/fixture.yaml']).to([])
    end
  end

  describe '#parser_type' do
    it 'returns bot symbol' do
      expect(parser.parser_type).to eq :bot
    end
  end

  describe '#parse' do
    let(:fixture) do
      { name: 'Googlebot',
        category: 'Search bot',
        url: 'https://developers.google.com/search/docs/crawling-indexing/overview-google-crawlers',
        producer: { name: 'Google Inc.', url: 'https://www.google.com/' } }
    end

    context 'when known user agent set' do
      it 'returns expected parsed result' do
        expect(parser.parse).to include(fixture)
      end
    end

    context 'when unknown user agent set' do
      let(:user_agent) { 'ChromeBrother/1.2.3' }

      it 'returns expected parsed result' do
        expect(parser.parse).to be_nil
      end
    end

    context 'when custom regex has been added to parser' do
      let(:user_agent) { 'ChromeBrother/1.2.3' }
      let(:fixture) do
        { category: 'Spec bot', name: 'My custom User-Agent Bot',
          producer: { name: 'Nick Kugaevsky', url: 'https://github.com/kugaevsky' } }
      end

      before do
        path = File.expand_path('../../fixtures/custom_regexes/custom_bot.yml', __dir__)
        described_class.add_fixture_path(path)
      end

      it 'returns expected parsed result' do
        expect(parser.parse).to include(fixture)
      end
    end
  end
end
