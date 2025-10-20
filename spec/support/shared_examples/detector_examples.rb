# frozen_string_literal: true

shared_examples 'detector bot examples' do
  let(:bot) { fixture['bot'] }

  it 'should detect bot' do
    expect(subject.bot?).to eq true
  end

  it 'should detect bot name' do
    expect(subject.bot_name).to eq bot['name']
  end
end

shared_examples 'detector client examples' do
  let(:client_result) { subject.send(:client_result) }
  let(:client) { normalize_fixture(fixture['client']) }

  it 'should detect client name' do
    expect(subject.name).to eq client[:name]
  end

  it 'should have client as in fixture' do
    expect(client_result).to include(client)
  end
end

shared_examples 'detector OS examples' do
  let(:os_result) { subject.send(:os_result) }
  let(:os) { normalize_fixture(fixture['os']) }

  it 'should detect expected OS name' do
    expect(subject.os_name).to eq os[:name]
  end

  it 'should have OS as in fixture' do
    expect(os_result).to include(os)
  end
end

shared_examples 'detector device examples' do
  let(:device) { normalize_fixture(fixture['device']) }

  it 'should detect expected device type' do
    expect(subject.device_type).to eq device[:type]
  end

  it 'should detect expected device brand' do
    expect(subject.device_brand).to eq device[:brand]
  end

  it 'should detect expected device model' do
    expect(subject.device_name).to eq device[:model]
  end
end
