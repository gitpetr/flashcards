require 'rails_helper'

RSpec.describe Card, type: :model do

  let(:card){create(:card, original: "haus", translated: "hause")}

  it 'method of verification comparison of original = true' do
     expect(card.comparison("haus")).to be true
  end

  it 'method of verification comparison of original = false' do
     expect(card.comparison("hause")).to be false
  end
 
  it 'check the automatic creation review' do 
    expect(card.review).to eq ( 3.days.from_now).to_date
  end
  
end

# it 'method of verification comparison of original' do
  #   card = create(:card, {original: "haus", translated: "haus"})
  # end


  # it 'method of verification comparison of original' do
  #   card = Card.new(original: "hause", translated: "hause")
  #   expect(card.comparison("hause")).to be false
  # end

 
  # it 'method2 of verification comparison of original' do
  #     card1 = Card.new(original: "hause", translated: "haus")
  #     expect(card1.comparison("hause")).to be true
  # end
 

  # it 'check1 of on_review' do 
  #   card5 = Card.create!(original: "hause", translated: "haus")
  #   expect(card5.review).to eq ( 3.days.from_now).to_date 
  # end

  # it 'check error in no_equal' do
  #   card6 = Card.create(original: "hause", translated: "haus") 
  #   expect(card6).not_to be false
  # end

  # it 'check1 error in no_equal' do
  #   card7 = Card.create(original: "hause", translated: "hause") 
  #   expect(card7).not_to be true
  # end