# Running: $ ruby app.rb
# Testing:
# # $ gem install rspec
# # $ rspec spec

require_relative './lib/array'
require_relative './lib/baseball_data'
require_relative './lib/display'
require_relative './lib/player_batting_statistic'
require_relative './lib/command'

Display.app_intro
Display.load_files
Display.loop_through_options
Display.app_goodbye

# Improve by:
# # Add validation for all inputs
# # Allow for blank lines at bottom of CSVs