require 'test_helper'
require 'generators/barbecue/media/media_generator'

module Barbecue
  class Barbecue::MediaGeneratorTest < Rails::Generators::TestCase
    tests Barbecue::MediaGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
