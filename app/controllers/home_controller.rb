class HomeController < ApplicationController

  def index
  end

  def link
    @shortlink = Shortlink.new params[:url]
    @shortlink.save
    @url = @shortlink.to_s
    @qr = RQRCode::QRCode.new @url, size: 4, level: :l 
    render "link"
  rescue
    flash[:alert] = "There was a problem with the URL you entered.  Try again with a different one."
    redirect_to root_path
  end

  def faq
  end

end
