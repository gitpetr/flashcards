require 'rails_helper'

RSpec.describe Card, type: :model do

  let!(:user){ create(:user)}#, email: "test@test.test", password: "test", password_confirmation: "test") }
  let!(:pack){ create(:pack, user_id: user.id) }
  let(:card){ create(:card, user_id: user.id, pack_id: pack.id) } 

  it 'method of verification comparison of original = true' do
     expect(card.comparison("haus")).to be true
  end

  it 'method of verification comparison of original = false' do
     expect(card.comparison("hause")).to be false
  end
 
  it 'check the automatic creation review' do 
    expect(card.review).to eq ( 3.days.from_now).to_date
  end

  it 'original not to be eq translated' do
    expect(Card.new(original: "hause", translated: "Hause" )).not_to be_valid
  end

  it 'catching errors if original eq translated' do
    card = Card.new(original: "hause", translated: "Hause")
    card.valid?
    expect(card.errors[:original]).to include('Оригинальный и переведённый тексты не должны быть равны друг другу')
  end

  describe do 

    let(:card){create(:card, original: "Стол", translated: "Table", user_id: user.id, pack_id: pack.id)}

    it 'method of verification comparison of original = true for russian ' do
      expect(card.comparison("Стол")).to be true
    end

  end
end
 