class BannersController < ApplicationController

  respond_to :html
  
  def visit
    @banner = Banner.find(params[:id])
    return redirect_to "/404", :layout => false if @banner == nil
    
    @banner.number_of_clicks = @banner.number_of_clicks + 1
    @banner.save
    
    redirect_to @banner.link
  end

end