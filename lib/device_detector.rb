require 'yaml'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'device_detector/version'
require 'device_detector/version_extractor'
require 'device_detector/os'
require 'device_detector/client'
require 'device_detector/os_detector'
require 'device_detector/client_detector'

class DeviceDetector

  ROOT = Pathname.new(File.expand_path('../..', __FILE__))

  attr_reader :user_agent

  def initialize(user_agent)
    @user_agent = user_agent
  end

  def os
    @os ||= OSDetector.new(user_agent).call
  end

  def client
    @client ||= ClientDetector.new(user_agent).call
  end

end
