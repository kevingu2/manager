# README #

### How do I get set up? ###

For Windows machines install RailsInstaller at http://railsinstaller.org/en
We are currently using Ruby 2.1.5, Python 2.7.10

Once everything is installed and all files are pulled up-to-date type "bundle install" to install necessary gems.
Windows machines will need to add the following to the bottom of their Gemfile 
##########################################################
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]

gem 'execjs'

gem 'coffee-script-source', '1.8.0'
##########################################################
and then after running bundle install, run "bundle update coffee-script-source" to force coffee-script to run 1.8.0

Run "rails server" to start the server, and connect at localhost:3000 by default