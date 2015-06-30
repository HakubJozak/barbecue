require 'dragonfly'

Dragonfly.logger = Rails.logger
Rails.application.middleware.use Dragonfly::Middleware


# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
