require "thor"
require "luhn"
require "minikick/models"

def display_currency num
  i = num.to_i
  i == num ? "$#{i}" : format("$%.2f",num)
end

def name_valid?(name)
  name_regex = /\A[\w-]{4,20}\z/
  name.to_s =~ name_regex
end

def cash_amount_valid?(amount)
  amount_regex = /\A\d+.?\d{0,2}\z/
  amount.to_s =~ amount_regex
end

def credit_card_number_valid?(credit_card_number)
  credit_card_number_regex = /\A\d{0,19}\z/
  credit_card_number.to_s =~ credit_card_number_regex and credit_card_number.valid_luhn?
end

class Minikick < Thor
  desc "project PROJECT TARGET_AMOUNT", "Create a new project"
  def project(project_name, target_amount)
    project_name_rejected = "ERROR: Project name is invalid.\n"
    target_amount_rejected = "ERROR: Target amount is invalid.\n"

    if !name_valid?(project_name)
      puts(project_name_rejected)
    elsif !cash_amount_valid?(target_amount)
      puts(target_amount_rejected)
    else
      project = Project.create(
        :name      => project_name,
        :target_amount => target_amount
      )
      puts("Added #{project_name} project with target of $#{target_amount}.")
    end
  end

  desc "back USER_NAME PROJECT CREDIT_CARD_NUMBER BACKING_AMOUNT", "Back a project"
  def back(user_name, project_name, credit_card_number, backing_amount)
    user_name_rejected = "ERROR: User name is invalid.\n"
    backing_amount_rejected = "ERROR: Backing amount is invalid.\n"
    credit_card_number_rejected = "ERROR: This card is invalid.\n"

    if !name_valid?(user_name)
      puts(user_name_rejected)
    elsif !credit_card_number_valid?(credit_card_number)
      puts(credit_card_number_rejected)
    elsif !cash_amount_valid?(backing_amount)
      puts(backing_amount_rejected)
    else
      # This assumes that project names are unique which is not being strictly
      # enforced
      project_id = Project.first(:name => project_name).id
      pledge = Pledge.create(
        :project_id => project_id,
        :name       => user_name,
        :amount     => backing_amount,
        :ccn        => credit_card_number
      )
      puts("#{user_name} backed project #{project_name} for $#{backing_amount}.")
    end
  end

  desc "list PROJECT", "List a projects backers and backed amounts"
  def list(project_name)
    pledges = Pledge.all(:project => { :name => project_name })
    target_amount = Project.first(:name => project_name).target_amount
    total_pledged = BigDecimal.new(0)

    pledges.each do |pledge|
      total_pledged += pledge.amount
      puts "-- #{pledge.name} backed for #{display_currency(pledge.amount)}"
    end

    if total_pledged < target_amount
      puts("#{project_name} needs #{display_currency(target_amount - total_pledged)} more dollars to be successful.")
    else
      puts("#{project_name} is successful!")
    end
  end

  desc "backer USER_NAME", "Display all projects and amounts a backer has backed."
  def backer(user_name)
    pledges = Pledge.all(:name => user_name)
    pledges.each  do |pledge|
      # TODO: This is horribly inefficent and I should rework my table structure
      project_name = Project.first(:pledges => pledge).name
      puts "-- Backed #{project_name} for #{display_currency(pledge.amount)}"
    end
  end
end
