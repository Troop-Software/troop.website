module ApplicationHelper

  def gravatar_for(user, options = {size: 80})
    if user.class == String
      gravatar_id = Digest::MD5::hexdigest(user.downcase)
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: 'user image', class: 'img-circle')
    else
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: user.username, class: 'img-circle')
    end
  end

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : nil

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def date_for_display(date)
      fsdate = (date == nil)? date :  I18n.l( Date.parse(date.to_s), :format => :default)
  end

  def datetime_for_display(datetime)
    fsdatetime = (datetime == nil)? datetime :  I18n.l( DateTime.parse(datetime.to_s), :format => :default)
  end
end
