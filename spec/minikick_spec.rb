require 'rspec'
require 'minikick'
require 'database_cleaner'

DatabaseCleaner.strategy = :transaction

describe Minikick do
  let(:user_name) { "John" }
  let(:project_name) { "Awesome_Sauce" }
  let(:credit_card_number) { "4111111111111111" }
  let(:backing_amount) { 50 }
  let(:target_amount) { 550 }


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
      target_amounts = [550, 50.10, 45.11]

      target_amounts.each do |target_amount|
        it "backs the project at #{target_amount}" do
          subject.project(project_name, target_amount)
          expect { subject.back(user_name, project_name, credit_card_number, backing_amount) }.to \
              output(result).to_stdout
        end
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
                     "-- Jane backed for $99.10\n" \
                     "#{project_name} needs $400.90 more dollars to be successful.\n" }

      it 'will list all backers for a project' do
        subject.project(project_name, target_amount)
        subject.back('John', project_name, 4111111111111111, 50)
        subject.back('Jane', project_name, 378282246310005, 99.10)

        expect { subject.list project_name}.to output(eq(result)).to_stdout
      end
    end
  end
  #
  describe "#backer" do
    it 'will list the projects a backer has backed' do
      result = "-- Backed Awesome_Sauce for $50\n"
      subject.project(project_name, target_amount)
      subject.back(user_name, project_name, credit_card_number, backing_amount)

      subject.back('Jane', project_name, 378282246310005, 99.10)

      expect { subject.backer user_name}.to output(result).to_stdout
    end
  end
end
