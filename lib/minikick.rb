require "thor"

def project_name_valid?(project_name)
  project_name_regex = /\A[\w-]{4,20}\z/
  project_name.to_s =~ project_name_regex
end

def target_amount_valid?(target_amount)
  target_amount_regex = /\A\d+.?\d{0,2}\z/
  target_amount.to_s =~ target_amount_regex
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

    if !project_name_valid?(project_name)
      puts(project_name_rejected)
    elsif !target_amount_valid?(target_amount)
      puts(target_amount_rejected)
    else
      puts("Added #{project_name} project with target of $#{target_amount}.")
    end
  end

  desc "back USER_NAME PROJECT CREDIT_CARD_NUMBER BACKING_AMOUNT", "Back a project"
  def back(user_name, project_name, credit_card_number, backing_amount)
    puts("#{user_name} backed project #{project_name} for $#{backing_amount}.")
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
