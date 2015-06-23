require 'test_helper'

class GeneratedAttributeTest < ActiveSupport::TestCase
  test 'integer' do
    attr = Barbecue::Generators::GeneratedAttribute.parse 'title:integer'
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


end
