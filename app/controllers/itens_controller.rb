class ItensController < ApplicationController

  def index

  end

  def atualizar_quantidades

    pedido_atual.update_attributes(params[:pedido])

    respond_to do |format|
      format.html do
    flash[:success] = 'Quantidades atualizadas com sucesso !!!'
    redirect_to itens_url
    end
  end

  end

  def create
    if pedido_atual.new_record?
        pedido_atual.save
        session[:pedido_id] = pedido_atual.id
    end
       produto = Produto.find( params[:produto_id] )
       pedido_atual.adicionar_produto( produto, params[:quantidade] )

    respond_to do |format|
      format.html do
        flash[:success] = 'Pedido adicionado com sucesso'
        redirect_to produto_url( produto)
      end
    end
  end
end