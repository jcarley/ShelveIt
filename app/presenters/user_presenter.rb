class UserPresenter < PresenterBase
    
    def user
      @user ||= User.new
    end
    
    def authenticate
      @user = User.authenticate(@user.username, @user.password)
      !@user.nil?
    end
          
end