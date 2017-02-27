require 'rails_helper'
RSpec.describe Card, type: :model do
    let!(:user){ create(:user, email: 'test', password: 'test', password_confirmation: 'test') }
    let(:card){ create(:card, original: "Стол", translated: "Table", user: user) }

    describe 'method right_answer! first review' do
      it 'first day term_review eq 1' do
        card.right_answer!
        expect(card.term_review).to eq 1
      end
      it 'first day counter_review eq 0' do 
        card.right_answer!
        expect(card.counter_review).to eq 0
      end
      it 'first day date review eq Time.now + 12.hour' do
        card.right_answer!
        expect(card.review).to eq (Time.now + 12.hour).to_date
      end
    end

    describe 'method right_answer! twoth review' do
      it 'term_review update of 1 to 2' do
        card = create(:card, original: "barrel", translated: "бочка", user: user, term_review: 1)
        card.right_answer!
        expect(card.term_review).to eq 2
      end
      it 'counter_review eq 0' do
        card = create(:card, original: "barrel", translated: "бочка", user: user, term_review: 1, counter_review: 2)
        card.right_answer!
        expect(card.counter_review).to eq 0
      end
      it 'date review eq 3.days.from_now' do
        card = create(:card, original: "barrel", translated: "бочка", user: user, term_review: 1)
        card.right_answer!
        expect(card.review).to eq (3.days.from_now).to_date
      end
    end

    describe 'third review' do
      it 'date review  eq 7.days.from_now' do
        card = create(:card, original: "barrel", translated: "бочка", user: user, term_review: 2)
        card.right_answer!
        expect(card.review).to eq (7.days.from_now).to_date
      end
    end

    describe 'fourth review ' do 
      it 'date review eq 14.days.from_now' do
        card = create(:card, original: "barrel", translated: "бочка", user: user, term_review: 3)
        card.right_answer!
        expect(card.review).to eq (14.days.from_now).to_date
      end
    end

    describe 'fifth review' do 
      it 'date review eq 30.days.from_now' do
        card = create(:card, original: "barrel", translated: "бочка", user: user, term_review: 4)
        card.right_answer!
        expect(card.review).to eq (30.days.from_now).to_date
      end
    end

    describe 'sixth review' do 
      it 'date review eq 30.days.from_now' do
        card = create(:card, original: "barrel", translated: "бочка", user: user, term_review: 5)
        card.right_answer!
        expect(card.review).to eq (30.days.from_now).to_date
      end
    end

  describe  'complex spec for wrong_answer' do
    let(:card){ create(:card, original: "Name", translated: "Имя", user: user) }
      it 'check increment counter, counter_review eq 1' do
        card.wrong_answer!
        expect(card.counter_review).to eq 1
      end
      it 'reset term_review if counter==3 term_review eq 0' do
        card = create(:card, original: "Name", translated: "Имя", user: user, term_review: 5, counter_review: 3) 
        card.wrong_answer!
        expect(card.term_review).to eq 0
      end
  end

  describe 'check after 7 try, method right_answer! after mistake' do 
    let!(:user){ create(:user, email: 'test', password: 'test', password_confirmation: 'test') }
    let(:card){ create(:card, original: "barrel", translated: "бочка", user: user, term_review: 0, counter_review: 7) }
    it 'term_review eq 1' do
      card.right_answer!
      expect(card.term_review).to eq 1
    end
    it 'counter_review eq 0' do 
      card.right_answer!
      expect(card.counter_review).to eq 0
    end
    it 'date review to eq Time.now + 12.hour' do 
      card.right_answer!
      expect(card.review).to eq (Time.now + 12.hour).to_date
    end
  end
end
 