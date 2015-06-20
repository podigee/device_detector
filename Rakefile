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

desc 'update regex database from piwik project'
task :update_regexes do
  top = File.expand_path('..', __FILE__)
  system "curl -s -L https://api.github.com/repos/piwik/device-detector/tarball/master | tar xzvf - --strip-components 1 --include */regexes/*.yml -C #{top}"
end
