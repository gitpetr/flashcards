class HomeController < ApplicationController

  def index
    if current_user
      @packs = current_user.packs || nil
      if params[:pack_id].blank?
        @card = current_user.cards.for_review.take || nil
      else 
        @pack = Pack.find(params[:pack_id])
        @card = @pack.cards.for_review.take || nil
      end
    end
  end
  
  def update 
    @card = Card.find(params[:id])
    if @card.comparison(params[:text])
      @card.update_attributes(term_review: @card.term_review += 1 )
      @card.update_date_review
      @card.update_attributes(counter_review: 0 )
      redirect_back(fallback_location: root_path,  success: 'угадал')
    else
      @card.update_attributes(counter_review: @card.counter_review +=1 )
      @card.update_attributes(term_review: 0 ) if @card.counter_review > 3
      redirect_back(fallback_location: root_path, danger: 'извините, неправильно' )
    end
  end
end
 
