module HomeHelper
  def take_card
    Card.where('review <= current_date').take
  end
end


 # @cards = 
