require 'test_helper'
require 'generators/barbecue/blueprint/blueprint_generator'

module Barbecue
  class Barbecue::BlueprintGeneratorTest < Rails::Generators::TestCase
    tests Barbecue::BlueprintGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
