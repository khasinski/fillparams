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

    # TODO - check if both files are valid YAML
    config_data = load_yaml_file file_name
    dist_data = load_yaml_file dist_file_name
    params_to_fill = get_missing_data(config_data, dist_data)
    puts params_to_fill

    if !params_to_fill.empty?
      puts 'Please provide values for missing params:'
      params_to_fill.each do |key, default|
        config_data[key] = ask_for_param(key, default)
      end
    end
    File.write(file_name, config_data.to_yaml)
  end

  def load_yaml_file file_name
    YAML.load_file(file_name)
  end

  def setup_files(file_name, dist_file_name)
    raise ArgumentError, 'Dist file not found for ' + file_name unless File.file?(dist_file_name)
    if !File.file?(file_name)
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
    print "Key \"#{key}\" (default: #{default}): "
    YAML.load(gets.chomp)
  end
end

