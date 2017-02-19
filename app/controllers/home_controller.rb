class HomeController < ApplicationController

  def index
    @card = Card.for_review.take
  end
  
  def update 
    @card = Card.find(params[:id])
    if @card.comparison(params[:text])
      @card.update_date_review
      flash.now[:success] = 'угадал'
      redirect_back(fallback_location: root_path,  success: 'угадал')

    else
       flash.now[:danger] = 'извините, неправильно'
       redirect_back(fallback_location: root_path, danger: 'извините, неправильно')
    end
     
  end

end
 
