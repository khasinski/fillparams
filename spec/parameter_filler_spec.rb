require 'spec_helper'

describe ParameterFiller do
  describe '#fill_parameters' do
    context 'simple input yml' do
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

    context 'nested input yml' do
      def sample_dist_data
        YAML.load(<<-EOF
          key01: val01
          key02:
            key11: val11
            key12:
              key20: val20
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
        context 'on zero level of nesting' do
          let(:data){ sample_dist_data.merge('new_key'=> 'new_val') }
          it 'returns the same config as data' do
            expect(pf.fill_parameters(data, sample_dist_data)).to eq data
          end
        end
        context 'on first level of nesting' do
          let(:data){ sample_dist_data.merge('key02' => sample_dist_data['key02'].merge('new_key'=> 'new_val')) }
          it 'returns the same config as data' do
            expect(pf.fill_parameters(data, sample_dist_data)).to eq data
          end
        end
      end
      context 'when the dist data has additional key' do
        context 'on zero level of nesting' do
          let(:dist_data){ sample_dist_data.merge('new_key'=> 'new_val') }
          let(:data){ sample_dist_data }
          it 'returns the same config as dist_data' do
            expect(pf.fill_parameters(data, dist_data)).to eq dist_data
          end
        end
        context 'on first level of nesting' do
          let(:dist_data){ sample_dist_data.merge('key02' => sample_dist_data['key02'].merge('new_key'=> 'new_val')) }
          let(:data){ sample_dist_data }
          it 'returns the same config as dist_data' do
            expect(pf.fill_parameters(data, dist_data)).to eq dist_data
          end
        end
      end
      context 'when both data and dist data have additional keys' do
        context 'dist data on zero level of nesting and data on first level of nesting' do
          let(:dist_data){ sample_dist_data.merge('new_key'=> 'new_val') }
          let(:data){ sample_dist_data.merge('key02' => sample_dist_data['key02'].merge('new_key2'=> 'new_val2')) }
          it 'returns data with this keys' do
            expect(pf.fill_parameters(data, dist_data)).to eq data.merge('new_key'=> 'new_val')
          end
        end
        context 'dist data on first level of nesting and data on zero level of nesting' do
          let(:dist_data){ sample_dist_data.merge('key02' => sample_dist_data['key02'].merge('new_key'=> 'new_val')) }
          let(:data){ sample_dist_data.merge('new_key2'=> 'new_val2') }
          it 'returns data with this keys' do
            expect(pf.fill_parameters(data, dist_data)).to eq dist_data.merge('new_key2'=> 'new_val2')
          end
        end
        context 'when both data and dist data on first level of nesting' do
          let(:dist_data){ sample_dist_data.merge('key02' => sample_dist_data['key02'].merge('new_key'=> 'new_val')) }
          let(:data){ sample_dist_data.merge('key02' => sample_dist_data['key02'].merge('new_key2'=> 'new_val2')) }
          it 'returns data with this keys' do
            expect(pf.fill_parameters(data, dist_data)).to eq dist_data.merge('key02' => dist_data['key02'].merge('new_key2'=> 'new_val2'))
          end
        end
      end
    end

    context 'yml with anchors and aliases' do
      def sample_dist_data
        YAML.load(<<-EOF
          defaults: &defaults
            adapter:  postgres
            host:     localhost

          development:
            database: myapp_development
            <<: *defaults

          test:
            database: myapp_test
            <<: *defaults
        EOF
        )
      end

      def data_results
        YAML.load(<<-EOF
          defaults:
            adapter:  postgres
            host:     localhost

          development:
            database: myapp_development
            adapter:  postgres
            host:     localhost

          test:
            database: myapp_test
            adapter:  postgres
            host:     localhost
        EOF
        )
      end

      let(:pf) { ParameterFiller.new('', false, false) }
      context 'when the data is nil' do
        let(:data){ nil }
        it 'returns data_results' do
          expect(pf.fill_parameters(data, sample_dist_data)).to eq data_results
        end
      end
      context 'when the dist data is nil' do
        let(:dist_data){ nil }
        let(:data){ sample_dist_data }
        it 'returns data_results' do
          expect(pf.fill_parameters(data, sample_dist_data)).to eq data_results
        end
      end
    end
  end
end
