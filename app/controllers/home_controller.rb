class HomeController < ApplicationController

  def index
    @card = Card
    @card = @card.for_review.count > 0 ? @card = @card.for_review : @card  = @card.for_all
    @card = @card.one_card 
  end
  
  def update 
    @card = Card.find(params[:id])
    if @card.comparison(params[:text])
      @card.update_date_review
      flash.now[:success] = 'угадал'
      redirect_to :back, success: 'угадал'

    else
       flash.now[:danger] = 'извините, не правильно'
       redirect_to :back, danger: 'извините, не правильно'
    end
     
  end

end
 
