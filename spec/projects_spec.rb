require 'rspec'
require 'minikick'

describe Projects do
  it { should have_property :id             }
  it { should have_property :name           }
  it { should have_property :target_amount  }
end
