# encoding: UTF-8
require 'konf'

class ConfigManager
  def initialize
    @pub_config = {}
  end

  def load yml_file
    @pub_config = YAML.load(ERB.new(File.read(File.expand_path("../../#{yml_file}", __FILE__))).result)
  end
end

