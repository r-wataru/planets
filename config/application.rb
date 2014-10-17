require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Planets
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('config', 'constraints')
    config.time_zone = 'Tokyo'
    config.i18n.load_path +=
      Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [ :ja ]
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :ja
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      %Q(<div class="has-error has-feedback">#{html_tag}</div>).html_safe
    }
    config.generators do |g|
      g.helper false
      g.assets false
      g.test_framework :rspec
      g.controller_specs false
      g.view_specs false
    end
  end
end