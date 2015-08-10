require 'spec_helper'
describe 'logstash_forwarder' do

  context 'with defaults for all parameters' do
    it { should contain_class('logstash_forwarder') }
  end
end
