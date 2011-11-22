# encoding: utf-8
class SessionsController < ApplicationController

  def new
    @usuario = Usuario.new
    render :action => 'new'

  end

  def create
    @usuario = Usuario.autenticar(
        params[:usuario][:email] ,
        params[:usuario][:senha] )

    if @usuario
      self.usuario_atual = @usuario
      flash[:success] = 'Bem vindo a Loja !'
      redirect_to produtos_url
    else
      flash.now[:error] = 'Não foi possivel fazer o login com os dados enviados'
      new
    end
  end

  def destroy
    reset_session
    flash[:success]= 'Você saiu com sucesso da aplicação'
    redirect_to produtos_url
  end

end