require 'rspec'
require 'minikick/models/pledge'

describe Pledge do
  it { should have_property :id         }
  it { should have_property :project_id }
  it { should have_property :name       }
  it { should have_property :amount     }
  it { should have_property :ccn        }
end
