require "data_mapper"

# Get database setup from the environment
# Set environment to be test in the tests
# add environment = dev to the container

db_path = "sqlite3://#{Dir.home}/.minikick.db"

if db_path == 'in_mem'
  DataMapper.setup(:default, 'sqlite::memory:')
else
  DataMapper.setup(:default, db_path)
end

class Projects
  include DataMapper::Resource

  property :id,             Serial,   :key => true
  property :name,           String,   :key => true
  property :target_amount,  Decimal,  :lazy => true
end

DataMapper.finalize
DataMapper.auto_upgrade!
