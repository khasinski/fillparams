require 'spec_helper'
describe ParameterFiller do

  def sample_dist_data
    YAML.load(<<-EOF
      NAME: ABC
    EOF
    )
  end

  let(:pf) { ParameterFiller.new('', '', '') }
  context 'when the data is the same as sample data' do
    let(:data){ sample_dist_data }
    it 'returns the same config' do
      expect(pf.fill_parameters(data, sample_dist_data)).to eq sample_dist_data
    end
  end
end
