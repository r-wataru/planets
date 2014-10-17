ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    seeded_models = [ Area, Prefecture ]
    seeded_tables = %w( areas_and_prefectures )

    if seeded_models.any? { |model| model.count.zero? }
      seeded_tables.each do |table_name|
        puts "Loading seed data into #{table_name} table..."
        load Rails.root.join('db', 'seeds', "#{table_name}.rb")
      end
    end
  end
end
