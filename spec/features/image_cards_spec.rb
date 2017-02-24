require 'rails_helper'
require 'support/login_helper'

RSpec.feature "Cards", type: :feature do
 
  before(:each) do 
    @user = create(:user) 
    visit root_path
    login("test@test.com", "test" )
   end
 

   feature "upload image" do 
    it "image uploaded successfully" do 
      visit new_card_path
      fill_in :card_original, :with => "a"
      fill_in :card_translated, :with => "az"
      attach_file 'card_image', "#{Rails.root}/spec/images/ten.jpg"
      click_button "Create Card"
      Card.last.update_attributes(review: -3.days.from_now)
      visit root_path
      expect(page).to  have_css("img[src*='ten.jpg']")
    end
  end  

end