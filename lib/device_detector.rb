require 'yaml'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'device_detector/version'
require 'device_detector/version_extractor'
require 'device_detector/parser'
require 'device_detector/client'
require 'device_detector/os'

class DeviceDetector

  ROOT = Pathname.new(File.expand_path('../..', __FILE__))

  attr_reader :user_agent

  def initialize(user_agent)
    @user_agent = user_agent
  end

  def name
    client.name
  end

  def full_version
    client.full_version
  end

  def os_name
    os.name
  end

  def os_full_version
    os.full_version
  end

  def known?
    client.known?
  end

  private

  def client
    @client ||= Client.new(user_agent)
  end

  def os
    @os ||= OS.new(user_agent)
  end

end
