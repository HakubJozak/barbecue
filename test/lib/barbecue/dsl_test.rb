require 'test_helper'

class Barbecue::DslTest < ActiveSupport::TestCase

  test '#scaffold' do
    Barbecue::Dsl.scaffold do
      uses :media_items
      uses :media_placements

      model :project do
        translated :title
        # translated :meta_title
        # translated :perex
        # translated :content
        string :slug
        # has_images :screenshots

        # acts_as_list
      end
    end
  end
end
