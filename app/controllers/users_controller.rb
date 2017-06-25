class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user, only: %i[edit profile update destroy get_email matches]

  def index
    @users = User.available_to_connect(current_user)
    if current_user.interest != 'Both'
      @users.select! { |o| o.gender == current_user.interest }
    end
    @users.uniq

    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    authorize! :update, @user
  end

  def update
    if @user.update(users_params)
      respond_to do |format|
        format.html { redirect_to users_path }
      end
    else
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    if @user.destroy
      session[:user_id] = nil
      session[:omniauth] = nil
      redirect_to root_path
    else
      redirect_to edit_user_path(@user)
    end
  end

  def profile; end

  def matches
    authorize! :read, @user
    @matches = current_user.friendships.where(state: 'ACTIVE').map(&:friend) + current_user.inverse_friendships.where(state: 'ACTIVE').map(&:user)
    @users = User.available_to_connect(current_user)
    if current_user.interest != 'Both'
      @users.select! { |o| o.gender == current_user.interest }
    end
    @users.uniq
  end

  def get_email
    respond_to do |format|
      format.js
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:interest, :bio, :avatar, :location, :date_of_birth, :gender)
  end
end
