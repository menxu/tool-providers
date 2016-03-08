Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  # config.active_record.migration_error = :page_load #add mongoid delete

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # ActionMailer::Base.delivery_method = :smtp
  # config.action_mailer.perform_deliveries = true
  # config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.default :charset => "utf-8"
  # config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { :host => '127.0.0.1:3000' }
  # config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  ActionMailer::Base.smtp_settings = {  
    :address => "smtp.163.com",
    :port => 25,
    :domain => "163.com",
    :authentication => :login,
    :user_name => "mxbeijingmi@163.com",
    :password => "menxu0725"
  }
  # config.action_mailer.smtp_settings = {
  #   address: ENV["MAIL_ADDRESS"] || "smtp.163.com",
  #   port: ENV["MAIL_PORT"] || 25,
  #   domain: ENV["DOMAIN_NAME"],
  #   authentication: ENV["MAIL_AUTH"] || :login,
  #   user_name: ENV["MAIL_USERNAME"],
  #   password: ENV["MAIL_PASSWORD"]
  # }
  # Send email in development mode.
  config.action_mailer.perform_deliveries = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  SERVICES = YAML.load_file(Rails.root.join("config", "service.yml")).fetch(Rails.env)
  Weibo2::Config.api_key = SERVICES['weibo']['api_key']
  Weibo2::Config.api_secret = SERVICES['weibo']['api_secret']
  Weibo2::Config.redirect_uri = SERVICES['weibo']['redirect_uri']

  # config.middleware.use Rack::LiveReload, host: 'localhost', port: 33333
end
