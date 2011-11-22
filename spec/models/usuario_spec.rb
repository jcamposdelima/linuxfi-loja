#encoding: utf-8
require File.join( File.dirname(__FILE__), '..', 'spec_helper' )

describe Usuario do

  context 'quando estiver validando senhas' do

    it 'deve requerer senha se senha_em_hash estiver vazio' do
      @usuario = Usuario.new
      @usuario.senha_necessaria?.should be_true
    end

    it 'não deve requerer se senha_em_hash estiver preenchido' do
      @usuario = Usuario.new( :senha_em_hash => 'minhasenha' )
      @usuario.senha_necessaria?.should be_false
    end

    it 'deve requerer senha se senha_em_hash e senha estiverem preenchidos' do
      @usuario = Usuario.new( :senha => 'minhasenha', :senha_em_hash => 'minhasenha' )
      @usuario.senha_necessaria?.should be_true
    end

  end

  context 'ao validar senhas' do

    before :each do
      @senha = '123456'
      @usuario = Usuario.new(
          :nome => 'test user',
          :email => 'email@gmail.com',
          :senha => @senha
      )

      @usuario.termos_e_condicoes = '1'

      @usuario.save!

    end

    it 'deve validar como senha correta' do

      @senha_final = Usuario.hashear_senha( @senha, @usuario.salt )
      @senha_final.should == @usuario.senha_em_hash

    end

    it 'deve aceitar a senha do usuário com e-mail' do
      @outro_usuario = Usuario.autenticar( @usuario.email, @senha )
      @outro_usuario.should == @usuario
    end

    it 'nao deve aceitar a senha do usuário se ela for inválida' do
      @outro_usuario = Usuario.autenticar( @usuario.email, "098765" )
      #Usuario.stub!( :autenticar ).and_return( nil )
      @outro_usuario.should be_nil
    end

    it 'nao deve aceitar a senha do usuário quando o email não existir' do
      @outro_usuario = Usuario.autenticar( 'fakemail@.com', "098765" )
      #Usuario.stub!( :autenticar ).and_return( nil )
      @outro_usuario.should be_nil
    end



  end

end