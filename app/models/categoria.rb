class Categoria < ActiveRecord::Base

  validates_presence_of :nome
  validates_uniqueness_of :nome, :allow_blank => true
  validates_length_of :nome, :minimum => 4

  has_many :produtos

end