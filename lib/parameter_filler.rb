class ParameterFiller

  attr_reader :config_files

  def initialize files_list
    @config_files = files_list
  end

  def fill_file_list
    # for each file in file list
    # run fill_file
  end

  def fill_file file_name
    original_file = load_yaml_file file_name
    dist_file = load_yaml_file file_name + '.dist'
    # if dist file does not exist -> error
    # if original file does not exist -> touch it
    # compare data from two files
    # ask about missing params
    # save original file
  end

  def load_yaml_file file_name

  end
end

