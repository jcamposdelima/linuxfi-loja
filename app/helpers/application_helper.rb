module ApplicationHelper
  def t(key, options = {})
    I18n.translate( key, options )
  end
end
