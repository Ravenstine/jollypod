require 'rails_helper'

describe "shortlink" do
  context "a valid playlist link" do
    it "returns a shortlink" do
      shortlink = Shortlink.new "https://www.youtube.com/watch?v=E8dkWQVFAoF&list=PL8dPyyaLjXtNdTKZkV_GiIYXpV9w4WxbX"
      expect(shortlink.to_s.class).to eq(String)
    end
  end
  context "an invalid playlist link" do
    it "raises an error" do
      expect{Shortlink.new "garbage"}.to raise_error(BadPlaylistLinkError)
    end
  end
end