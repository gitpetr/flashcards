class HomeController < ApplicationController

  def index
    @take_card = Card.for_review
  end

  
  def update 
    @card = Card.find(params[:id])
    @take_card = params[:text]
    if @card.comparison(@take_card)
      flash.now[:success] = 'угадал'
      redirect_to :back, success: 'угадал'

    else
       flash.now[:danger] = 'извините, не правильно'
       redirect_to :back, danger: 'извините, не правильно'
    end
     
  end
 
end
