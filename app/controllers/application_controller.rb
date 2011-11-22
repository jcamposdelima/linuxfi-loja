class ApplicationController < ActionController::Base
  protect_from_forgery

  include AutorizacaoControllerHelper

  helper_method :pedido_atual

  before_filter :selecionar_linguas

  protected

  def selecionar_linguas
    I18n.locale = session[:lingua] ||= 'pt-BR'
=begin
    I18n.current_locale = if session[:lingua].blank?
                            'pt-br'
                          else
                            session[:lingua]
                          end
=end
  end

  def pedido_atual
    @pedido_atual ||= if  !session[:pedido_id].blank?
                        Pedido.find(session[:pedido_id])
                      else
                        Pedido.new( :estado => 'carrinho' )
                      end
  end

  def carregar_pagina
    @page = params[:page] ||1
    @per_page = params[:per_page] ||3
  end

  def paginate( scope )
    carregar_pagina
    scope.paginate( :per_page => @per_page, :page => @page )

  end

end