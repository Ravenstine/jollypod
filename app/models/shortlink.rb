require 'digest/sha1'

BadPlaylistLinkError = Class.new StandardError

class Shortlink
  attr_accessor :url
  def initialize url
    @url = url
    @id = parse_playlist_id @url
    @guid = playlist_id_to_guid @id
    @cache = ActiveSupport::Cache::RedisStore.new
  end
  def to_s
    shortlink_from_guid @guid
  end
  def save
    @cache.write @guid, @id
  end
  private
  def parse_playlist_id url
    /[&?]list=([a-z0-9_\-]+)/i.match(url)[1]
  rescue
    raise BadPlaylistLinkError
  end
  def playlist_id_to_guid playlist_id
    (Digest::SHA1.hexdigest(playlist_id)[0..6] + playlist_id[2..5] rescue nil)
  end
  def shortlink_from_guid guid
    "http://#{DOMAIN}/#{guid}"
  end
end