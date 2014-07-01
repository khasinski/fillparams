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
    # for each file in file list
    # run fill_file
  end

  def fill_file file_name

    dist_file_name = file_name + '.dist'

    setup_files(file_name, dist_file_name)

    config_data = load_yaml_file file_name
    dist_data = load_yaml_file dist_file_name
    params_to_fill = get_missing_data(config_data, dist_data)

    # ask about missing params
    # save original file
  end

  def load_yaml_file file_name

  end

  def setup_files(file_name, dist_file_name)
    raise ArgumentError, 'Dist file not found' unless File.file?(dist_file_name)
    if File.file?(file_name)
      File.write(file_name, "")
    end
    return
  end

  def get_missing_data(config_data, dist_data)

  end
end

