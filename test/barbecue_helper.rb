class ActiveSupport::TestCase
  def json
    JSON.parse(response.body).deep_symbolize!
  end
end
