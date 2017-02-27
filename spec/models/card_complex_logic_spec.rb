require 'rails_helper'

RSpec.describe Card, type: :model do
 
  describe do 
    let!(:user){ create(:user, email: 'test', password: 'test', password_confirmation: 'test')}
    let(:card){create(:card, original: "Стол", translated: "Table", user: user)}

    it 'method update_term_counter_date_review' do
      card.update_term_counter_date_review
      expect(card.term_review).to eq 1
      expect(card.counter_review).to eq 0
      expect(card.review).to eq (Time.now + 12.hour).to_date

      card.update_term_counter_date_review
      expect(card.term_review).to eq 2
      expect(card.counter_review).to eq 0
      expect(card.review).to eq (3.days.from_now).to_date

      card.update_term_counter_date_review
      expect(card.term_review).to eq 3
      expect(card.counter_review).to eq 0
      expect(card.review).to eq (7.days.from_now).to_date

      card.update_term_counter_date_review
      expect(card.term_review).to eq 4
      expect(card.counter_review).to eq 0
      expect(card.review).to eq (14.days.from_now).to_date

      card.update_term_counter_date_review
      expect(card.term_review).to eq 5
      expect(card.counter_review).to eq 0
      expect(card.review).to eq (30.days.from_now).to_date

      card.update_term_counter_date_review
      expect(card.term_review).to eq 6
      expect(card.counter_review).to eq 0
      expect(card.review).to eq (30.days.from_now).to_date
    end
  end

  describe do
    let!(:user){ create(:user, email: 'test', password: 'test', password_confirmation: 'test')}
    let(:card){ create(:card, original: "Name", translated: "Имя", user: user, term_review: 6)}

    it 'method update_term_counter_when_comparison_false' do
      card.update_term_counter_when_comparison_false
      expect(card.term_review).to eq 6
      expect(card.counter_review).to eq 1

      card.update_term_counter_when_comparison_false
      expect(card.term_review).to eq 6
      expect(card.counter_review).to eq 2

      card.update_term_counter_when_comparison_false
      expect(card.term_review).to eq 6
      expect(card.counter_review).to eq 3

      card.update_term_counter_when_comparison_false
      expect(card.term_review).to eq 0
      expect(card.counter_review).to eq 4
      
      card.update_term_counter_when_comparison_false
      expect(card.term_review).to eq 0
      expect(card.counter_review).to eq 5
    end
  end

  describe do 
    let!(:user){ create(:user, email: 'test', password: 'test', password_confirmation: 'test')}
    let(:card){ create(:card, original: "barrel", translated: "бочка", user: user, term_review: 0, counter_review: 7)}

    it 'method update_term_counter_date_review after mistake' do
      card.update_term_counter_date_review
      expect(card.term_review).to eq 1
      expect(card.counter_review).to eq 0
      expect(card.review).to eq (Time.now + 12.hour).to_date
    end
  end
end
 