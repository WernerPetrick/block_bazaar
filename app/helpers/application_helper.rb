module ApplicationHelper
  
  def title 
    return t("block bazaar") unless content_for?(:title)
    
    "#{content_for(:title)} | #{t("block bazaar")}"
  end
  
end
