require_relative 'setup'

class SubscriptionService
  def initialize(user)
    @user = user
  end

  def subscribe
    api_result = try_api { PaymentGateway.subscribe }
    if api_result == :success
      @user.subscription = :monthly_plan
    end
    api_result
  end

  def unsubscribe
    api_result = try_api { PaymentGateway.unsubscribe }
    if api_result == :success
      @user.subscription = nil
    end
    api_result
  end

  private

  def try_api
    yield
  rescue SystemCallError => e
    :network_error
  end
end

class User
  attr_accessor :subscription

  def initialize
    @subscription_service ||= SubscriptionService.new(self)
    super
  end

  def subscribe
    @subscription_service.subscribe
  end

  def unsubscribe
    @subscription_service.unsubscribe
  end
end
