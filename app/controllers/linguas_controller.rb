class LinguasController < ApplicationController

  def index
    session[:lingua] = params[:lang]
    redirect_to :back
  end

end