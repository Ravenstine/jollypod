require 'rails_helper'

describe "shortlink decoder" do
  context "a shortcode that is stored in Redis" do
    it "returns a podcast feed link" do
      cache = ActiveSupport::Cache::RedisStore.new
      cache.write "testshortlink", "12345678"
      decoder = ShortcodeDecoder.new "testshortlink"
      expect(decoder.to_podcast).to eq("http://#{PODCAST_DOMAIN}/?id=12345678")
      cache.delete "testshortlink"
    end
  end
  context "an invalid shortcode" do
    it "raises an error" do
      expect{ShortcodeDecoder.new "garbage"}.to raise_error(InvalidShortcodeError)
    end
  end
end