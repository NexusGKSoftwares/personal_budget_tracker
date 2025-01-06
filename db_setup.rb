require 'active_record'

# Database connection setup
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'budget_tracker.db'
)

# Log SQL queries to the console (optional)
ActiveRecord::Base.logger = Logger.new(STDOUT)
