# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_PUCS_session',
  :secret      => 'd2686642f1472f51781f247af76d63d66ce9cb76e5c16b9122bdac897b8ad2cb5d7dd78c2f63c784db3878ebde678a77c5bfdd49e1b25c05d892e65298547306'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
