module SessionsHelper

  def sign_in(user)
    session[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    session[:remember_token] = nil
    self.current_user = nil
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def current_user?(user)
    user == current_user
  end

  def deny_access
    store_location
    flash[:notice] = "Please sign in to access this page."
    redirect_to signin_path unless signed_in? 
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or(default)
    redirect_to session[:return_to] || default
    clear_return_to
  end

  def clear_return_to
    session[:return_to] = nil
  end

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find params[:id]

    # redirecting to the settings page results in a infinate redirect.  Redirecting
    # to the root path prevents that
    redirect_to(root_path) unless current_user?(@user) 
  end

  private

  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end

  def remember_token
    session[:remember_token] || [nil, nil]
  end

end
