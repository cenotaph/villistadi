class Admin::AuthenticationsController <  ApplicationController
  layout 'admin'

  before_filter :authenticate_user!
  
  def destroy

    auth = Authentication.find_by(id: params[:id])

    user = auth.user
    auth.destroy!
    redirect_to edit_admin_user_path(user)
  end
  
end