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
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true
  config.assets.precompile += %w( jquery.knob.js)
  config.assets.precompile += %w( jquery.ui.widget.js)
  config.assets.precompile += %w( jquery.iframe-transport.js)
  config.assets.precompile += %w( jquery.fileupload.js)
  config.assets.precompile += %w( amcharts.js)
  config.assets.precompile += %w( serial.js)
  config.assets.precompile += %w( light.js)
  config.assets.precompile += %w( chart.js)
  config.assets.precompile += %w( dataloader.min.js)
  config.assets.precompile +=   %w( bootstrap-notify.min.js)
  config.assets.precompile += %w( jquery.growl.js)
  config.assets.precompile += %w( Sortable.js)
  config.assets.precompile += %w( updateStatus.js)
  config.assets.precompile += %w( tasks.js)
  config.assets.precompile += %w( jquery.slimscroll.min.js)
  config.assets.precompile += %w( allocated_tasks.js)
  config.assets.precompile += %w( assign.js)
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end
