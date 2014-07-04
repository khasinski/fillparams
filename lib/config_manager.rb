# encoding: UTF-8
require 'konf'

class ConfigManager
  attr_reader :init_file

  def initialize(init_yml_file)
    @init_file = load init_yml_file
  end

  def load yml_file
    YAML.load(ERB.new(File.read(File.expand_path("../../#{yml_file}", __FILE__))).result)
  end

  def get_config_files
    @init_file && @init_file.has_key?('files') ? @init_file['files'] : []
  end
end

