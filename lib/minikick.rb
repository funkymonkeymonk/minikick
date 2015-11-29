require "thor"

class Minikick < Thor
  desc "project PROJECT TARGET_AMOUNT", "Create a new project"
  def project(project_name, target_amount)
    project_name_regex = /\A[\w-]{4,20}\z/

    rejected = "Invalid project name\n" \
               "Project names should only contain only alphanumberic characters\n" \
               "and be no shorter than 4 characters but no longer than 20 characters."

    if project_name =~ project_name_regex
      puts("Added #{project_name} project with target of $#{target_amount}.")
    else
      puts(rejected)
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
