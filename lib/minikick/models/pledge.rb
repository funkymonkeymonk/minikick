class Pledge
  include DataMapper::Resource

  property :id,         Serial,   :key => true
  property :name,       String
  property :amount,     Decimal
  property :ccn,        Integer,  :lazy => true

  belongs_to :project, :key => true
end
