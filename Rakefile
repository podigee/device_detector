require 'rake'
require 'rake/testtask'

$:.unshift 'lib'
require 'device_detector'

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs.push 'spec'
end

task default: :test

task :detectable_names do
  bot_names = DeviceDetector::Bot.new.send(:regexes).map { |r| r['name'] }.uniq.sort_by { |n| n.downcase }
  bot_names.delete('$1')
  client_names = DeviceDetector::Client.new.send(:regexes).map { |r| r['name'] }.uniq.sort_by { |n| n.downcase }
  client_names.delete('$1')
  device_regexes = DeviceDetector::Device.new.send(:load_regexes)
  device_names = device_regexes.flat_map { |dn| dn.keys }.uniq.sort_by { |n| n.downcase }

  today = Date.today.strftime

  puts '## Detectable clients, bots and devices'
  puts
  puts "Updated on #{today}"
  puts
  puts '### Bots'
  puts
  puts bot_names.join(', ')
  puts
  puts '### Clients'
  puts
  puts client_names.join(', ')
  puts
  puts '### Devices'
  puts
  puts device_names.join(', ')
  puts
end

PIWIK_TARBALL_LOCATION = '/tmp/piwik_device_detector.tar.gz'.freeze

def get_latest_piwik_tarball
  system "curl -s -L https://api.github.com/repos/piwik/device-detector/tarball/master -o #{PIWIK_TARBALL_LOCATION}"
end

desc 'update regex database from piwik project'
task :update_regexes do
  top = File.expand_path('..', __FILE__)
  get_latest_piwik_tarball
  system "tar xzvf #{PIWIK_TARBALL_LOCATION} --strip-components 1 --include */regexes/*.yml -C #{top}"
end

desc 'update fixtures from piwik project'
task :update_fixtures do
  top = File.expand_path('..', __FILE__)
  get_latest_piwik_tarball

  fixture_mappings = [
    # tablet.yml from the detector fixtures is broken: https://github.com/piwik/device-detector/issues/5355
    #{ local_path: "#{top}/spec/fixtures/detector", archive_path: '*/Tests/fixtures/*.yml', strip_components: 3 },
    { local_path: "#{top}/spec/fixtures/client", archive_path: '*/Tests/Parser/Client/fixtures/*.yml', strip_components: 5 },
    { local_path: "#{top}/spec/fixtures/parser", archive_path: '*/Tests/Parser/fixtures/*.yml', strip_components: 4 },
    { local_path: "#{top}/spec/fixtures/device", archive_path: '*/Tests/Parser/Devices/fixtures/*.yml', strip_components: 5 },
  ]

  fixture_mappings.each do |mapping|
    strip_components = mapping.fetch(:strip_components)
    archive_path = mapping.fetch(:archive_path)
    local_path = mapping.fetch(:local_path)
    system "tar xzvf #{PIWIK_TARBALL_LOCATION} --strip-components #{strip_components} --include #{archive_path} -C #{local_path}"
  end
end
