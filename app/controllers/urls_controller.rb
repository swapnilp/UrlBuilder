class UrlsController < ApplicationController

  def index
    @urls = Url.all.order("hits desc")
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.find_or_initialize_by(url_params)
    if @url.save
      redirect_to urls_path
    else
      render :new
    end
  end

  def show
    @url = Url.where(id: params[:id]).first
  end
  
  def edit
    @url = Url.where(id: params[:id]).first
    
  end

  def update
    @url = Url.where(id: params[:id]).first
  end

  def update_count
    
  end

  def redirected
    @url = Url.where(short_url: params[:id]).first
    if @url.present?
      @url.increase_hit
      redirect_to "#{'http://' unless @url.url.include?('http://') || @url.url.include?('https://')}#{@url.url}"
    else
      redirect_to urls_path
    end
  end

private

  def url_params
    params.require(:url).permit(:url)
  end
end
