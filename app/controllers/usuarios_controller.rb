#encoding: utf-8
class UsuariosController < ApplicationController

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new( params[:usuario])
    if @usuario.save
      self.usuario_atual = @usuario
      flash[:success] = 'Seu Usuário foi criado com Sucesso !!!'
      redirect_to produtos_url
    else
      render :action => 'new'
    end
  end

end