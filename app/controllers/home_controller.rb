class HomeController < ApplicationController

  def index
    @take_card = Card.atrandom
  end

  
  def update 
    @cards = Card.find(params[:id])
    @take_card = params[:text]
     if @cards.original == @take_card 
        @cards.update_attributes(review: 3.days.from_now)
        redirect_to :back, success: 'угадал'
      else
        flash.now[:danger] = 'Извините, не правильно'
        redirect_to :back, danger: 'Извините, не правильно'
     end
        
  end
 
end
