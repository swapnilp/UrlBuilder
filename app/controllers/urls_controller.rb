class UrlsController < ApplicationController

  def index
    @urls = Url.all.order("hits desc")
  end

  def new
    @url = Url.new
  end

  # If urls is already present then just initialize else create new record
  def create
    @url = Url.find_or_initialize_by(url_params)
    if @url.save
      redirect_to urls_path, notice: "Url shortner is successfully created"
    else
      render :new
    end
  end

  # Using params[:id] serach urls and redirect to that url 
  # If params[:id] is not found then redirect to index with alert 
  def redirected
    @url = Url.where(short_url: params[:id]).first
    if @url.present?
      @url.increase_hit
      redirect_to "#{'http://' unless @url.url.include?('http://') || @url.url.include?('https://')}#{@url.url}"
    else
      redirect_to urls_path, alert: "URL not present. Please create new URL" 
    end
  end
  
  private
  
  def url_params
    params.require(:url).permit(:url)
  end
end
