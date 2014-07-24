require 'rspec'
require 'rspec/its'

require './lib/custom_editor'
require './lib/image_editor'

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end
