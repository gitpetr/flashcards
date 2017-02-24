require 'rails_helper'
require 'support/login_helper'

RSpec.feature 'Cards', type: :feature do
 
  before(:each) do 
    user = create(:user, email: 'test@test.test', password: 'test', password_confirmation: 'test') 
    pack =  create(:pack, user_id: user.id) 
    create(:card, user_id: user.id, pack_id: pack.id).update_attributes(review: -3.days.from_now)
    visit root_path
    login('test@test.test', 'test' )
   end

  feature 'field test' do 
    it 'field test' do
      fill_in :text, with: 'haus'
      click_button 'Update Card'
      expect(page).to have_content 'угадал'
    end
  end

  feature 'field test 2' do 
    it 'field test 2' do
      fill_in :text, with: 'стол'
      click_button 'Update Card'
      expect(page).to have_content 'извините, неправильно'
    end
  end
end
