# frozen_string_literal: true

module ConditionalHelper
  def client_engine?(fixture)
    extract_and_check(fixture, 'client', 'engine')
  end

  def client_engine_version?(fixture)
    extract_and_check(fixture, 'client', 'engine_version')
  end

  def client_family?(fixture)
    extract_and_check(fixture, 'client', 'family')
  end

  def client_version?(fixture)
    extract_and_check(fixture, 'client', 'version')
  end

  def device_model?(fixture)
    extract_and_check(fixture, 'device', 'model')
  end

  def os_platform?(fixture)
    extract_and_check(fixture, 'os', 'platform')
  end

  def os_version?(fixture)
    extract_and_check(fixture, 'os', 'version')
  end

  private

  def extract_and_check(fixture, *path)
    value = fixture.dig(*path)
    !value.to_s.empty?
  end
end
