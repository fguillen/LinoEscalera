class Admin::AdminController < ApplicationController
  before_filter :authenticate

  layout "/admin/admin"

  helper_method :current_admin_user, :namespace

  private

  def authenticate
    return if Rails.env.test?

    authenticate_or_request_with_http_basic do |username, password|
      username == APP_CONFIG[:login]["user"] && password == APP_CONFIG[:login]["pass"]
    end
  end
end