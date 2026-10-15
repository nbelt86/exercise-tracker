class Users::SessionsController < Devise::SessionsController
  def destroy
    guest_user = current_user if current_user&.guest?
    super
    guest_user&.destroy
  end
end
