class Produto < ActiveRecord::Base

  validates_presence_of :nome, :preco, :descricao
  validates_length_of :nome, :minimum => 4
  validates_numericality_of :preco, :greater_than => 0, :allow_blank => true

  belongs_to :categoria


end