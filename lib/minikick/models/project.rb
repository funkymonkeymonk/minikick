class Project
  include DataMapper::Resource

  property :id,             Serial,   :key => true
  property :name,           String
  property :target_amount,  Decimal,  :lazy => true
  has n,   :pledges
end
