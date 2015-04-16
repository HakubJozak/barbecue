require 'test_helper'

module Barbecue
  class ImageTest < ActiveSupport::TestCase
    setup do
      @url = 'http://media.bu2r.cz.s3.amazonaws.com/development/loremipsum/9k=.jpg'
    end

    test "thumbnail" do
      i = Image.create!(source_url: @url)
      assert_not_nil i.photo_uid
    end

    test 'thumbnail_sizes' do
      image = Image.create!(source_url: @url)
      t = image.thumb('220x300')
      assert_equal 220,t.width
      assert_equal 127,t.height
    end
  end
end
