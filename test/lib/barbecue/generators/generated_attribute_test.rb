require 'test_helper'

class GeneratedAttributeTest < ActiveSupport::TestCase
  test 'required' do
    attr = Barbecue::Generators::GeneratedAttribute.parse 'title:string,required'
    assert attr.required?, 'not required'
    assert_equal :string, attr.type
  end

  test 'translated' do
    attr = Barbecue::Generators::GeneratedAttribute.parse 'lat:decimal,translated'
    assert attr.translated?, 'not translated'
    refute attr.required?
    assert_equal :decimal, attr.type
    assert_equal [:lat_en,:lat_cs], attr.to_raw
  end  


end
