class Pledge
  include DataMapper::Resource

  property :id,         Serial,   :key => true
  property :project_id, Integer
  property :name,       String
  property :amount,     Decimal
  property :ccn,        Integer,  :lazy => true
end
