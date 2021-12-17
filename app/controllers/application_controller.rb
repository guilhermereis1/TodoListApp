class ApplicationController < ActionController::Base

 before_action :set_locale
 before_action :set_colors

 def set_colors
  @selected_color = ['#7B68EE', '#6A5ACD', '#800000', '#2F4F4F'].sample
 end

 def set_locale_en
  cookies[:locale] = :en
  redirect_to_current_path
 end

 def set_locale_pt
  cookies[:locale] = :'pt-BR'
  redirect_to_current_path
 end

 private

 def set_locale
  if cookies[:locale]
   I18n.locale = cookies[:locale]
  else
   I18n.locale = I18n.default_locale
  end
 end

 def redirect_to_current_path
  redirect_back fallback_location: root_path
 end
end
