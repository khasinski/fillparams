# encoding: UTF-8
require 'konf'

class ConfigManager
  attr_reader :init_files

  def initialize init_yml_file
    @init_files = load init_yml_file
  end

  def load yml_file
    YAML.load(ERB.new(File.read(File.expand_path("../../#{yml_file}", __FILE__))).result)
  end
end

