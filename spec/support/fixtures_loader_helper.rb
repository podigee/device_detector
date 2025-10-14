# spec/support/yaml_loader.rb
require 'yaml'
require 'etc'
require 'parallel'
require 'oj'
require 'fileutils'

module FixturesLoaderHelper
  CACHE_PATH = File.expand_path('../../tmp/cache/fixtures.json', __dir__)
  FIXTURES_DIR = File.expand_path('../fixtures', __dir__)

  def load_fixtures(paths = "#{FIXTURES_DIR}/**/*.yml")
    file_list =
      case paths
      when String then Dir.glob(paths)
      when Array then paths
      else
        raise ArgumentError, "Expected String or Array, got #{paths.class}"
      end

    raise ArgumentError, "No files found within these paths: #{paths}" if file_list.empty?

    yaml_data.slice(*file_list).values.flatten
  end

  private

  def yaml_data
    @yaml_data ||= load_with_cache.freeze
  end

  def load_with_cache
    if cache_valid?
      warn "[YAML Loader] Using json cache: #{CACHE_PATH}"
      return Oj.load_file(CACHE_PATH)
    end

    warn '[YAML Loader] Cache not found or outdated. Rebuilding...'

    data = load_all_yaml(FIXTURES_DIR)
    ensure_cache_dir!
    Oj.to_file(CACHE_PATH, data, mode: :compat, indent: 2)
    data
  end

  def cache_valid?
    return false unless File.exist?(CACHE_PATH)

    cache_mtime = File.mtime(CACHE_PATH)
    yaml_files = Dir.glob(File.join(FIXTURES_DIR, '**/*.yml'))
    latest_yaml_mtime = yaml_files.map { |f| File.mtime(f) }.max

    latest_yaml_mtime && cache_mtime > latest_yaml_mtime
  end

  def load_all_yaml(base_dir)
    paths = Dir.glob(File.join(base_dir, '**/*.yml'))
    warn "[YAML Loader] Loading #{paths.size} YAML-files from #{base_dir}..."

    results = Parallel.map(paths, in_processes: Etc.nprocessors) do |path|
      [path, YAML.load_file(path)]
    rescue StandardError => e
      warn "[YAML Loader] Error parsing #{path}: #{e.message}"
      [path, {}]
    end

    results.to_h
  end

  def ensure_cache_dir!
    dir = File.dirname(CACHE_PATH)
    FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
  end
end
