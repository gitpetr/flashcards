class HomeController < ApplicationController

  def index
    if current_user
      @packs = current_user.packs
      if params[:pack_id].blank?
        @card = current_user.cards.for_review.take
      else 
        @pack = Pack.find(params[:pack_id])
        @card = @pack.cards.for_review.take
      end
    end
  end
  
  def update 
    @card = Card.find(params[:id])
    if @card.comparison(params[:text])
      @card.right_answer!
      redirect_back(fallback_location: root_path,  success: 'угадал')
    else
      @card.wrong_answer!
      redirect_back(fallback_location: root_path, danger: 'извините, неправильно')
    end
  end
end
 
