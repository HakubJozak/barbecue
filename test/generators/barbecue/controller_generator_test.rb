require "test_helper"
require "generators/barbecue/controller/controller_generator"
require 'pathname'


class Barbecue::ControllerGeneratorTest < Rails::Generators::TestCase
  tests Barbecue::ControllerGenerator
  destination File.expand_path("tmp", File.dirname(__FILE__))

  def setup
    prepare_destination
    prepare_rails
  end
  
  def test_defaults
    run_generator %w(animal)
    assert_file 'app/controllers/animals_controller.rb' do |controller|
      assert_instance_method :find_animal, controller do |finder|
        assert_equal '@animal = Animal.find(params[:id])',finder.strip
      end
    end

    assert_file 'app/serializers/animal_serializer.rb'
    assert_file 'test/controllers/animals_controller_test.rb'
  end

  private

  def prepare_rails
    system `cp -R test/dummy/* #{root_dir}`
  end

  def root_dir
    root = Pathname.new(destination_root)
  end

end


