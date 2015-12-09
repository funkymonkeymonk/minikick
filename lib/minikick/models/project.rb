class Project
  include DataMapper::Resource

  property :id,             Serial,   :key => true
  property :name,           String
  # TODO: Change target_amount to a BigDecimal
  property :target_amount,  Float,  :lazy => true
  has n,   :pledges
end
