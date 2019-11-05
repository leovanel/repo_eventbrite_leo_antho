class EventsController < ApplicationController
  def index
    @events = Event.showall
  end
  
  def show
    @detail = Event.find(params[:id])
    @events = Event.showall
  end

  def new
    @detail = Event.new
    user=current_user
  end

  def create
    user=current_user
    
    @detail = Event.new( user_id: user.id,
                          'title' => params[:title],
                          'description' => params[:description],
                          'start_date' => params[:start_date],
                          'duration' => params[:duration],
                          'price' => params[:price],
                          'location' => params[:location]
                        ) # avec xxx qui sont les données obtenues à partir du formulaire
    
      if @detail.save # essaie de sauvegarder en base @gossip
      @events = Event.showall
      
      redirect_to event_path(@detail.id) # si ça marche, il redirige vers la page d'index du site
    else
      render new_event_path  # sinon, il render la view new (qui est celle sur laquelle on est déjà)
    end
  end
    
  

end
