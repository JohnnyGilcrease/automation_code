require 'pg'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  'postgresql', # or 'postgresql' or 'sqlite3' or 'oracle_enhanced'
  database: 'codepilot'
)
