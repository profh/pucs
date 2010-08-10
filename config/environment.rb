# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  config.gem 'will_paginate'  # there are other paginators to choose from
  config.gem 'authlogic'      # used with nifty_authentication
  config.gem 'searchlogic'    # adds lots of named_scopes automatically
  config.gem 'cancan'         # authorization gem to track permissions
  config.gem 'chronic'        # use chronic for date handling
  config.gem 'formtastic'     # makes forms easier to code
  config.gem 'hpricot'      
 # config.gem 'paperclip'      # gem to handle uploads of photos (plugin also available)
  # config.gem 'acts_as_ferret' # full-text searching tool

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'Eastern Time (US & Canada)'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
end

# require 'lib/error_correction'

# Set up some array constants to be used throughout the application
RACE_LIST = [["African American", 1], ["American Indian", 2], ["Asian American", 3], ["Hispanic", 4], ["Mixed Race", 5],["White", 6]]
RELATIONSHIP_LIST = [["Mother", 1],["Father", 2],["Grandmother", 3],["Grandfather", 4],["Aunt", 5],["Uncle", 6],["Other", 7]]
HOUSEHOLD_STATUS_LIST = [["Single Parent", 1],["Two Parent", 2]]
STATES_LIST = [['Ohio', 'OH'],['Pennsylvania', 'PA'],['West Virginia', 'WV']]
GRADE_LIST = [['Kindergarten', 0], ['1st Grade', 1], ['2nd Grade', 2], ['3rd Grade', 3], ['4th Grade', 4], ['5th Grade', 5], ['6th Grade', 6], ['7th Grade', 7], ['8th Grade', 8]]
