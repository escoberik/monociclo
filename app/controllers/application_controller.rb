class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :basic_authentication, if: Proc.new { Rails.env == 'staging' }

  def basic_authentication
    authenticate_or_request_with_http_basic do |user, password|
      user == 'sergio' && password == 'glenn_jade'
    end
  end
end
