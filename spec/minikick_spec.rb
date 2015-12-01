require 'rspec'
require 'minikick'
require 'database_cleaner'

DatabaseCleaner.strategy = :transaction

describe Minikick do
  let(:user_name) { "John" }
  let(:project_name) { "Awesome_Sauce" }
  let(:credit_card_number) { "4111111111111111" }
  let(:backing_amount) { 50 }
  let(:target_amount) { 1000000 }

  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  describe "#project" do
    context "when all data is valid" do
      let(:result) { "Added #{project_name} project with target of $#{target_amount}.\n" }
      specify { expect { subject.project project_name, target_amount }.to output(result).to_stdout }
    end

    context "when project name is invalid" do
      let(:result) { "ERROR: Project name is invalid.\n"}
      project_names = ["*light*bright", "abcdefghijklmnopqrstuvwxyz", "hod"]

      project_names.each do |project_name|
        specify { expect { subject.project project_name, target_amount }.to output(result).to_stdout }
      end
    end

    context "when target amount is invalid" do
      let(:result) { "ERROR: Target amount is invalid.\n"}
      target_amounts = ["10.1.1", 50.111, "$1001.11"]

      target_amounts.each do |target_amount|
        specify { expect { subject.project project_name, target_amount }.to output(result).to_stdout }
      end
    end
  end

  describe "#back" do
    context "when all data is valid" do
      let(:result) { "#{user_name} backed project #{project_name} for $#{backing_amount}.\n" }
      it 'backs the project' do
        expect { subject.back(user_name, project_name, credit_card_number, backing_amount) }.to \
            output(result).to_stdout
      end
    end

    context "when user name is invalid" do
      let(:result) { "ERROR: User name is invalid.\n" }
      user_names = ["*light*bright", "abcdefghijklmnopqrstuvwxyz", "hod"]

      user_names.each do |user_name|
        specify { expect { subject.back user_name, project_name, credit_card_number, backing_amount }.to output(result).to_stdout }
      end
    end

    context "when credit card number is invalid" do
      let(:result) { "ERROR: This card is invalid.\n"}
      credit_card_numbers = [41111111111111111111, "sunshine", 123456789]

      credit_card_numbers.each do |credit_card_number|
        specify { expect { subject.back user_name, project_name, credit_card_number, backing_amount }.to output(result).to_stdout }
      end
    end

    context "when backing amount is invalid" do
      let(:result) { "ERROR: Backing amount is invalid.\n" }

      backing_amounts = ["10.1.1", 50.111, "$1001.11"]

      backing_amounts.each do |backing_amount|
        specify { expect { subject.back user_name, project_name, credit_card_number, backing_amount }.to output(result).to_stdout }
      end
    end
  end

  describe "#list" do
    context "when project is not completely funded" do
      let(:result) { "-- John backed for $50\n" \
                     "-- Jane backed for $50\n" \
                     "#{project_name} needs $400 more dollars to be successful.\n" }
      specify { expect { subject.list project_name}.to output(end_with(result)).to_stdout }
    end
  end
  #
  describe "#backer" do
    let(:backed) { "-- Backed Awesome_Sauce for $50" }
    specify { expect { subject.backer user_name}.to output(backed).to_stdout }
  end
end
