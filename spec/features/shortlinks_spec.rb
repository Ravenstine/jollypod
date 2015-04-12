require 'rails_helper'

describe "shortlinks", :type => :feature do
  context "a valid playlist link provided" do
    it "provides a shortlink" do
      visit '/'
      fill_in 'url', with: "https://www.youtube.com/watch?v=E8dkWQVFAoF&list=PL8dPyyaLjXtNdTKZkV_GiIYXpV9w4WxbX"
      click_button 'Podcast-it!'
      expect(page).to have_content 'Add the feed URL below to your favorite podcast reader.'
    end
  end
  context "an invalid playlist link" do
    it "gives back an error message" do
      visit '/'
      fill_in 'url', with: "garbage"
      click_button 'Podcast-it!'
      expect(page).to_not have_content 'Add the feed URL below to your favorite podcast reader.'
      expect(page).to have_content "There was a problem with the URL you entered."
    end
  end
end