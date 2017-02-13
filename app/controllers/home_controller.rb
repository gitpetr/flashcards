class HomeController < ApplicationController

  def index
    @take_card = Card.where('review <= current_date').take
  end

  
  def update 
    @cards = Card.find(params[:id])
    @take_card = params[:text]
     if @cards.original == @take_card 
        @cards.update_attributes(review: 3.days.from_now)
     end
        redirect_to :back
  end

  

  private

 

  def card_params 
    params.require(:card).permit(:original, :translated)
  end

end
