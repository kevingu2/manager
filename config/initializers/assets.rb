# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( bootstrap.min.css )
Rails.application.config.assets.precompile += %w( html5shiv.min.js )
Rails.application.config.assets.precompile += %w( respond.min.js )
Rails.application.config.assets.precompile += %w( jquery-ui.css )
Rails.application.config.assets.precompile += %w( jquery-1.10.2.js )
Rails.application.config.assets.precompile += %w( jquery-ui.js )
Rails.application.config.assets.precompile += %w( jquery.slimscroll.min.js )
Rails.application.config.assets.precompile += %w( updateStatus.js )
Rails.application.config.assets.precompile += %w( tasks.js )