module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="row">
      <div class="col-xs-8 offset-xs-2">
        <div class="alert alert-danger">
          <div class="alert-heading">
            <h4 class="alert-title">
              <button type="button" class="close" data-dismiss="alert">x</button>
              #{sentence}</h4>
          </div>
          #{messages} 
        </div>
      </div>
    </div>
    HTML

    html.html_safe
  end
end