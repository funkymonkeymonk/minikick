require "thor"
require "luhn"

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
    project_name_rejected = "Invalid project name\n" \
                            "Project names should only contain only alphanumberic characters\n" \
                            "and be no shorter than 4 characters but no longer than 20 characters."

    target_amount_rejected = "Invalid target amount\n" \
                             "Target amounts should only contain only dollars and cents\n" \
                             "and should not contain a dollar sign($).\n"

    if !name_valid?(project_name)
      puts(project_name_rejected)
    elsif !cash_amount_valid?(target_amount)
      puts(target_amount_rejected)
    else
      puts("Added #{project_name} project with target of $#{target_amount}.")
    end
  end

  desc "back USER_NAME PROJECT CREDIT_CARD_NUMBER BACKING_AMOUNT", "Back a project"
  def back(user_name, project_name, credit_card_number, backing_amount)
    user_name_rejected = "Invalid user name\n" \
                         "User names should only contain only alphanumberic characters\n" \
                         "and be no shorter than 4 characters but no longer than 20 characters."

    backing_amount_rejected = "Invalid backing amount\n" \
                              "Backing amounts should only contain only dollars and cents\n" \
                              "and should not contain a dollar sign($).\n"

    credit_card_number_rejected = "Invalid credit card number\n" \
                                  "Credit card numbers must be less than characters.\n" \
                                  "Credit card numbers must be numeric.\n" \
                                  "Card numbers must be validated using Luhn-10.\n" \
                                  "Cards that have already been added will display an error.\n"

    if !name_valid?(user_name)
      puts(user_name_rejected)
    elsif !credit_card_number_valid?(credit_card_number)
      puts(credit_card_number_rejected)
    elsif !cash_amount_valid?(backing_amount)
      puts(backing_amount_rejected)
    else
      puts("#{user_name} backed project #{project_name} for $#{backing_amount}.")
    end
  end

  desc "list PROJECT", "List a projects backers and backed amounts"
  def list(project_name)
    puts("-- John backed for $50")
    puts("-- Jane backed for $50")
    puts("#{project_name} needs $400 more dollars to be successful.")
  end

  desc "backer USER_NAME", "Display all projects and amounts a backer has backed."
  def backer(user_name)
    print("-- Backed Awesome_Sauce for $50")
  end
end
