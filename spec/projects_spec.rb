require 'rspec'
require 'minikick/models/project'

describe Project do
  it { should have_property :id             }
  it { should have_property :name           }
  it { should have_property :target_amount  }
  it { should have_many     :pledges        }
end
