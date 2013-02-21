module ApplicationHelper
  def twitterized_type(type)
    case type
      when :alert
        "alert alert-error"
      when :notice
        "alert alert-success"
      else
        type.to_s
    end
  end

  def menu_class(actual_menu_name)
    menus = {
      :film => ["/front/collections/film"],
      :commercial => ["/front/collections/commercial"],
      :brand => ["/front/collections/brand"]
    }

    path = request.fullpath.gsub(/\?.*/, "")

    return "active" if menus[actual_menu_name].any? { |e| path =~ /^#{e}$/ }
    return "no-active"
  end
end
