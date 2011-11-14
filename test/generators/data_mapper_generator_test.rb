require "test_helper"

if [:data_mapper, :data_mapper_active_model].include?(DEVISE_ORM)
  require "generators/data_mapper/devise_generator"

  class DataMapperGeneratorTest < Rails::Generators::TestCase
    tests DataMapper::Generators::DeviseGenerator
    destination File.expand_path("../../tmp", __FILE__)
    setup :prepare_destination

    test "all files are properly created" do
      run_generator %w(monster)
      assert_file "app/models/monster.rb", /devise/
    end

    test "all files are properly deleted" do
      run_generator %w(monster)
      run_generator %w(monster), :behavior => :revoke
      assert_no_file "app/models/monster.rb"
    end
  end
end
