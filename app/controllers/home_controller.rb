class HomeController < ApplicationController

  def index
    # @take_card = Card.for_review
    @take_card = Card.for_review.review.present? ? Card.for_review : Card.for_all
  end
  
  def update 
    @card = Card.find(params[:id])
    if @card.comparison(params[:text])
      flash.now[:success] = 'угадал'
      redirect_to :back, success: 'угадал'

    else
       flash.now[:danger] = 'извините, не правильно'
       redirect_to :back, danger: 'извините, не правильно'
    end
     
  end

end
 
