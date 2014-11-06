class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_auth

  def do_login(oauth_account)
    session[:account_id] = oauth_account.id
    redirect_to users_url
  end

  def do_logout
    session[:account_id] = nil
    redirect_to login_oauth_accounts_url
  end

  def account
    OauthAccount.where(id: session[:account_id]).first
  end

  def check_auth
    if !account
      redirect_to login_oauth_accounts_url
    end
  end

end
