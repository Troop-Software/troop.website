module ApplicationHelper

  def active_positions(scout)
    positions = []
    scout.scout_positions.each do |scout_position|
      positions << scout_position.position.name if scout_position.current_position?
    end
    positions.join(', ')
  end

  def google_map(location)
    "https://www.google.com/maps/embed/v1/place?key=#{ENV.fetch('GOOGLE_MAPS_API_KEY')}&q='#{location}'"
  end

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

  def days_between(start_date, end_date)
    end_date = Date.today if end_date.nil?
    (end_date - start_date).to_i
  end

  def date_for_display(date)
      fsdate = (date == nil)? date :  I18n.l( Date.parse(date.to_s), :format => :default)
    if fsdate == '01/01/1111'
      return 'Unknown'
    else
      return fsdate
    end
  end

  def datetime_for_display(datetime)
    fsdatetime = (datetime == nil)? datetime :  I18n.l( DateTime.parse(datetime.to_s), :format => :default)
  end
end
