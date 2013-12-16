class SessionsController < ApplicationController

  skip_before_action :login_required, :only => [:new, :create]

  def new
  end

  def create
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      login(user.id)
      redirect_to videos_path
    else
      redirect_to login_path, alert: "Login Failed. Please try again." 
    end
  end

  # for bookmarklet
  def signed_in
    if current_user
      respond_to do |f|
        f.html {}
        f.js {}
      end
      render text: "HI THERE!" 
    else
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end

end
