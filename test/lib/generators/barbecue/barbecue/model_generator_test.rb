require 'test_helper'
require 'generators/barbecue/model/model_generator'

module Barbecue
  class Barbecue::ModelGeneratorTest < Rails::Generators::TestCase
    tests Barbecue::ModelGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
