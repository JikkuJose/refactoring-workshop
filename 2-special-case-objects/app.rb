require_relative 'setup'

class NullSubscription
  def cancel
  end

  def name
    "none"
  end

  def status
    "-"
  end

  def trial_days
    "-"
  end
end

class User
  def last_subscription
    subscriptions.last || NullSubscription.new
  end

  def cancel_subscription
    last_subscription.cancel
  end
end

class StatusReportJob
  def perform
    users = {}
    User.all.map do |user|
      users[user.name] = {
        name: last_name(user),
        status: last_status(user),
        trial_days: last_trial_days(user)
      }
    end
    users
  end

  private

  def last_name(user)
    user.last_subscription.name
  end

  def last_status(user)
    user.last_subscription.status
  end

  def last_trial_days(user)
    user.last_subscription.trial_days
  end
end
