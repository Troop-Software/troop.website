module ApplicationHelper

  def gravatar_for(user, options = {size: 80})
    if user.class == String
      gravatar_id = Digest::MD5::hexdigest(user.downcase)
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: 'user image', class: 'rounded-circle')
    else
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: user.username, class: 'rounded-circle')
    end
  end

end
