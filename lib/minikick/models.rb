require "data_mapper"
require "require_all"

# Get database setup from the environment
# Set environment to be test in the tests
# add environment = dev to the container

db_path = "sqlite3://#{Dir.home}/.minikick.db"

if db_path == 'in_mem'
  DataMapper.setup(:default, 'sqlite::memory:')
else
  DataMapper.setup(:default, db_path)
end

require_rel "models"

DataMapper.finalize
DataMapper.auto_upgrade!
