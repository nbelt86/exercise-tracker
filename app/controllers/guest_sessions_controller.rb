class GuestSessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    user = User.create_guest!
    sign_in(user)
    redirect_to workouts_path, notice: "You're browsing as a guest — sign out to end this session."
  end
end
