class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :authenticate_current_user, only: [:show]
  def show
    @profil = User.find(params['id'])
    @events = Event.showall
  end

private

def authenticate_current_user
  @profil = User.find(params['id'])
  unless current_user.id == @profil.id
    flash[:danger] = "Vous n'avez pas acces a cette page"
   redirect_to '/'
  end
end

end
