require 'rails_helper'

RSpec.describe Card, type: :model do
    let!(:user){ create(:user, email: 'test', password: 'test', password_confirmation: 'test') }
    
  describe 'complex spec for right_answer' do 
    let(:card){ create(:card, original: "Стол", translated: "Table", user: user) }
    it 'method right_answer!' do
      card.right_answer!
      expect(card.term_review).to eq 1
      expect(card.counter_review).to eq 0
      expect(card.review).to eq (Time.now + 12.hour).to_date

      card.right_answer!
      expect(card.term_review).to eq 2
      expect(card.counter_review).to eq 0
      expect(card.review).to eq (3.days.from_now).to_date

      card.right_answer!
      expect(card.term_review).to eq 3
      expect(card.counter_review).to eq 0
      expect(card.review).to eq (7.days.from_now).to_date

      card.right_answer!
      expect(card.term_review).to eq 4
      expect(card.counter_review).to eq 0
      expect(card.review).to eq (14.days.from_now).to_date

      card.right_answer!
      expect(card.term_review).to eq 5
      expect(card.counter_review).to eq 0
      expect(card.review).to eq (30.days.from_now).to_date

      card.right_answer!
      expect(card.term_review).to eq 6
      expect(card.counter_review).to eq 0
      expect(card.review).to eq (30.days.from_now).to_date
    end
  end

  describe  'complex spec for wrong_answer' do
    let(:card){ create(:card, original: "Name", translated: "Имя", user: user, term_review: 6) }

    it 'method wrong_answer!' do
      card.wrong_answer!
      expect(card.term_review).to eq 6
      expect(card.counter_review).to eq 1

      card.wrong_answer!
      expect(card.term_review).to eq 6
      expect(card.counter_review).to eq 2

      card.wrong_answer!
      expect(card.term_review).to eq 6
      expect(card.counter_review).to eq 3

      card.wrong_answer!
      expect(card.term_review).to eq 0
      expect(card.counter_review).to eq 4

      card.wrong_answer!
      expect(card.term_review).to eq 0
      expect(card.counter_review).to eq 5
    end
  end

  describe 'check after 7 try' do 
    let(:card){ create(:card, original: "barrel", translated: "бочка", user: user, term_review: 0, counter_review: 7) }

    it 'method right_answer! after mistake' do
      card.right_answer!
      expect(card.term_review).to eq 1
      expect(card.counter_review).to eq 0
      expect(card.review).to eq (Time.now + 12.hour).to_date
    end
  end
end
 