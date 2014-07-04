require 'yaml'

class ParameterFiller

  attr_reader :config_files
  attr_reader :verbose
  attr_reader :interactive

  def initialize(files_list, verbose, interactive)
    @config_files = files_list
    @verbose = verbose
    @interactive = interactive
  end

  def fill_file_list
    puts @config_files
    @config_files.each do |file_name|
      if verbose
        puts 'Filling ' + file_name + '...'
      end
      fill_file file_name
    end
  end

  def fill_file(file_name)
    dist_file_name = file_name + '.dist'
    setup_files(file_name, dist_file_name)
    config_data = load_yaml_file file_name
    dist_data = load_yaml_file dist_file_name
    config_data = fill_parameters(config_data, dist_data)
    File.write(file_name, config_data.to_yaml)
  end

  def fill_parameters(config_data, dist_data)
    params_to_fill = get_missing_data(config_data, dist_data)
    if !params_to_fill.empty?
      if interactive
        puts 'Please provide values for missing parameters:'
      end
      params_to_fill.each do |key, default|
        config_data[key] = ask_for_param(key, default)
      end
    end
  end

  def load_yaml_file(file_name)
    begin
      data = YAML.load_file(file_name)
    rescue Exception => e
      raise ArgumentError, 'Invalid YAML in config file ' + file_name unless data
    end
    data
  end

  def setup_files(file_name, dist_file_name)
    raise ArgumentError, 'Dist file not found for ' + file_name unless File.file?(dist_file_name)
    unless File.file?(file_name)
      File.write(file_name, '{}') # TODO: remove this {}
    end
    return
  end

  def get_missing_data(data, dist_data)
    to_fill = {}
    dist_data.each do |key, value|
      if(!data.has_key?(key))
        to_fill[key] = value
      end
    end
    to_fill
  end

  def ask_for_param(key, default)
    print "Key \"#{key}\" (default: #{default}): " if interactive
    param = gets.chomp
    if param.empty? || !interactive
      param = default
    else
      param = YAML.load(param)
    end
    param
  end
end

