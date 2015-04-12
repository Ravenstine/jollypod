class PodcastController < ApplicationController
  def redirect
    decoder = ShortcodeDecoder.new params[:guid]
    redirect_to decoder.to_podcast
  rescue
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end
end