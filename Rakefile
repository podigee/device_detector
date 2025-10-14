# frozen_string_literal: true

require 'rake'
require 'rake/testtask'
require 'rspec/core/rake_task'
require 'parallel_rspec'
require 'etc'

$LOAD_PATH.unshift 'lib'
require 'device_detector'

RSpec::Core::RakeTask.new(:spec)

ParallelRSpec::RakeTask.new(:prspec) do |_t|
  ENV['WORKERS'] = Etc.nprocessors.to_s
  puts "Running Rspec with #{ENV.fetch('WORKERS', nil)} workers..."
  # t.pattern = "spec/**/*_spec.rb"
  # t.rspec_opts = "--tag parallel"
end

desc 'generate detectable names output for README'
task :detectable_names do
  require 'date'

  bot_names = DeviceDetector::Bot.new('').send(:regexes)
                                 .map { |r| r[:name] }.uniq.sort_by(&:downcase)
  bot_names.delete('$1')
  client_names = DeviceDetector::Client.new('').send(:regexes)
                                       .map { |r| r[:name] }.uniq.sort_by(&:downcase)
  client_names.delete('$1')
  device = DeviceDetector::Device.new('')
  device_paths = device.send(:filepaths)
  device_regexes = device.send(:load_regexes, device_paths)
  device_names = device_regexes.flat_map { |dn| dn[1].keys }.uniq.sort_by(&:downcase)

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

MATOMO_REPO_URL = 'https://github.com/matomo-org/device-detector'
MATOMO_REPO_TAG = 'master'
MATOMO_CHECKOUT_LOCATION = '/tmp/matomo_device_detector'

def matomo_checkout!
  if File.exist?(MATOMO_CHECKOUT_LOCATION)
    system "cd #{MATOMO_CHECKOUT_LOCATION}; git fetch origin; git reset --hard #{MATOMO_REPO_TAG}"
  else
    system "git clone --depth 100 #{MATOMO_REPO_URL} -b #{MATOMO_REPO_TAG} #{MATOMO_CHECKOUT_LOCATION}"
  end
end

desc 'update regex database from matomo project'
task :update_regexes do
  top = File.expand_path(__dir__)
  matomo_checkout!
  Dir.glob("#{top}/regexes/**/*.yml").each do |f|
    File.unlink(f)
  end
  system "cp -R #{MATOMO_CHECKOUT_LOCATION}/regexes/* #{top}/regexes"
end

desc 'update fixtures from matomo project'
task :update_fixtures do
  top = File.expand_path(__dir__)
  matomo_checkout!

  fixture_mappings = [
    { target_path: "#{top}/spec/fixtures/detector", source_path: 'Tests/fixtures/*.yml' },
    { target_path: "#{top}/spec/fixtures/client",
      source_path: 'Tests/Parser/Client/fixtures/*.yml' },
    { target_path: "#{top}/spec/fixtures/parser", source_path: 'Tests/Parser/fixtures/*.yml' },
    { target_path: "#{top}/spec/fixtures/device",
      source_path: 'Tests/Parser/Device/fixtures/*.yml' }
  ]

  Dir.glob("#{top}/spec/fixtures/**/*.yml").each do |f|
    File.unlink(f)
  end

  fixture_mappings.each do |mapping|
    source_path = mapping.fetch(:source_path)
    target_path = mapping.fetch(:target_path)
    system "cp -R #{MATOMO_CHECKOUT_LOCATION}/#{source_path} #{target_path}"
  end
end
