require 'test_helper'

class Barbecue::UploadsControllerTest < ActionController::TestCase
  tests Barbecue::UploadsController

  setup do
    @routes = Barbecue::Engine.routes
    Dotenv.load
  end


  test 'show' do
    get :show, name: 'my new image.png', type: 'video/mov'
    assert_response :success
    assert_match %r{test/video/source/.*/my-new-image-png},json[:key]
  end

  # TODO: test invalid arguments
  # test 'show' do
  #   get :show
  #   assert_response 400
  # end

end
