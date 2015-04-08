require 'test_helper'
require 'generators/ember_controller/ember_controller_generator'

module Barbecue
  class EmberControllerGeneratorTest < Rails::Generators::TestCase
    tests EmberControllerGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
