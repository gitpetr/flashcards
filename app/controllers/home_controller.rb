class HomeController < ApplicationController

  def index
    if current_user
      @packs = current_user.packs.all || nil
      if params[:pack_id].blank?
        @card = current_user.cards.for_review.take || nil
      else 
        @pack = Pack.find(params[:pack_id])
        #k = Pack.where(pack_id: @pack_id) 
        @card = @pack.cards.for_review.take || nil
      end
    end
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
 
