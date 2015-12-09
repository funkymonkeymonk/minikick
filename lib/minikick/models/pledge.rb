class Pledge
  include DataMapper::Resource

  property :id,         Serial,   :key => true
  property :name,       String
  # TODO: Change amount to a BigDecimal
  property :amount,     Float
  property :ccn,        Integer,  :lazy => true

  belongs_to :project, :key => true
end
