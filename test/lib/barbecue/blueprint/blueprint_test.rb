require 'test_helper'

module Barbecue
  class BlueprintTest < ActiveSupport::TestCase
    test 'uses' do
      @zoo = Blueprint.create do
	model :animal do
          string :name, translated: true
	  image :photo
        end
      end

      assert @zoo.uses?(:images), 'images not detected'
      assert_equal @zoo.models.first.name, :animal
    end
  end
end
