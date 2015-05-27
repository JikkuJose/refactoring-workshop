require_relative 'setup'

class User
  def signed_up_in_a_week?
    created_at < a_week_before
  end

  def a_week_before
    Time.now - 7 * 24 * 3600
  end
end

class ProjectsController
  def index
    if recent_user?
      @projects = current_user.active_projects
    else
      set_signup_flash_message if member?
      @projects = Project.featured
    end
  end

  def recent_user?
    current_user.signed_up_in_a_week?
  end

  def member?
    !!current_user
  end

  def set_signup_flash_message
    @flash_msg = 'Sign up for having your own projects, and see promo ones!'
  end
end
