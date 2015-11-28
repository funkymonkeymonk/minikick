require 'rspec'
require 'minikick'

def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end

  result
end

describe Minikick do
  describe "#project" do
    let(:project_name) { "Awesome_Sauce" }
    let(:target_amount) { 500 }

    context "when all data is valid" do
      let(:result) { "Added #{project_name} project with target of $#{target_amount}.\n" }
      specify { expect { subject.project project_name, target_amount }.to output(result).to_stdout }
    end
  end

  describe "#back" do
    let(:user_name) { "John" }
    let(:project_name) { "Awesome_Sauce" }
    let(:credit_card_number) { "4111111111111111" }
    let(:backing_amount) { 50 }

    context "when all data is valid" do
      let(:result) { "#{user_name} backed project #{project_name} for $#{backing_amount}.\n" }
      specify { expect { subject.back user_name, project_name, credit_card_number, backing_amount }.to output(result).to_stdout }
    end
  end

  describe "#list" do
    let(:project_name) { "Awesome_Sauce" }

    context "when project is not completely funded" do
      let(:first_backer) { /-- John backed for $50/ }
      let(:second_backer) { /-- Jane backed for $50/ }
      let(:remaining) { "#{project_name} needs $400 more dollars to be successful.\n" }
      # specify { expect { subject.list project_name}.to output(first_backer).to_stdout }
      # specify { expect { subject.list project_name}.to output(second_backer).to_stdout }
      specify { expect { subject.list project_name}.to output(end_with(remaining)).to_stdout }
    end
  end
  #
  describe "#backer" do
    let(:user_name) { "John" }
    let(:backed) { "-- Backed Awesome_Sauce for $50" }
    specify { expect { subject.backer user_name}.to output(backed).to_stdout }
  end
end
