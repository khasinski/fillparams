require 'spec_helper'
describe ParameterFiller do

  def sample_dist_data
    YAML.load(<<-EOF
      NAME: value
      string: abc
      number: 1.23
    EOF
    )
  end

  let(:pf) { ParameterFiller.new('', false, false) }
  context 'when the data is nil' do
    let(:data){ nil }
    it 'returns the same config as sample_dist_data' do
      expect(pf.fill_parameters(data, sample_dist_data)).to eq sample_dist_data
    end
  end
  context 'when the dist data is nil' do
    let(:dist_data){ nil }
    let(:data){ sample_dist_data }
    it 'returns the same config as sample_dist_data' do
      expect(pf.fill_parameters(data, sample_dist_data)).to eq sample_dist_data
    end
  end
  context 'when the data is the same as sample data' do
    let(:data){ sample_dist_data }
    it 'returns the same config as sample_dist_data' do
      expect(pf.fill_parameters(data, sample_dist_data)).to eq sample_dist_data
    end
  end
  context 'when the data has additional key' do
    let(:data){ sample_dist_data.merge('new_key'=> 'new_val') }
    it 'returns the same config as data' do
      expect(pf.fill_parameters(data, sample_dist_data)).to eq data
    end
  end
  context 'when the dist data has additional key' do
    let(:dist_data){ sample_dist_data.merge('new_key'=> 'new_val') }
    let(:data){ sample_dist_data }
    it 'returns the same config as dist_data' do
      expect(pf.fill_parameters(data, dist_data)).to eq dist_data
    end
  end
  context 'when both data and dist data have additional keys' do
    let(:dist_data){ sample_dist_data.merge('new_key'=> 'new_val') }
    let(:data){ sample_dist_data.merge('new_key2'=> 'new_val2') }
    it 'returns data with this keys' do
      expect(pf.fill_parameters(data, dist_data)).to eq dist_data.merge('new_key2'=> 'new_val2')
    end
  end
end
