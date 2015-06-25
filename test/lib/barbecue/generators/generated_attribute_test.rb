require 'test_helper'

module Barbecue::Generators
  class GeneratedAttributeTest < ActiveSupport::TestCase
    test 'integer' do
      attr = GeneratedAttribute.parse 'title:integer'
      assert_equal :integer, attr.type
      assert_equal false, attr.required?
      assert_equal false, attr.translated?
    end

    test 'required' do
      attr = Barbecue::Generators::GeneratedAttribute.parse 'title:string,required'
      assert attr.required?, 'not required'
      assert_equal :string, attr.type
    end

    test 'translated' do
      attr = Barbecue::Generators::GeneratedAttribute.parse 'lat:decimal,translated'
      assert attr.translated?, 'not translated'
      assert_equal false, attr.required?
      assert_equal :decimal, attr.type
      assert_equal [:lat_en,:lat_cs], attr.to_raw
    end

    test 'image' do
      attr = Barbecue::Generators::GeneratedAttribute.parse 'photo:image'
      assert_equal attr.type, :image
      assert_equal 'photo_id:integer' , attr.to_rails_cli
    end

    test 'images' do
      attr = Barbecue::Generators::GeneratedAttribute.parse 'screenshots:images'
      assert_equal :images, attr.type
      assert_equal nil, attr.to_rails_cli
    end

  end
end
