InvalidShortcodeError = Class.new StandardError

class ShortcodeDecoder
  def initialize shortcode
    @code = shortcode
    @cache = ActiveSupport::Cache::RedisStore.new
    @id = @cache.read(@code)
    raise InvalidShortcodeError if !@id
  end
  def to_podcast
    "http://#{PODCAST_DOMAIN}/?id=#{@id}"
  end
end