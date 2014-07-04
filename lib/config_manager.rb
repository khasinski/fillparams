# encoding: UTF-8
require 'yaml'

class ConfigManager
  attr_reader :init_file

  def initialize(init_yml_file)
    @init_file = load init_yml_file
  end

  def load yml_file
    YAML.load_file(yml_file)
  end

  def get_config_files
    @init_file && @init_file.has_key?('files') ? @init_file['files'] : []
  end
end

