class PostDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def posted_by(user, object)
    if user.full_name == object.user.full_name
      "You"
    else
      object.user.full_name
    end
  end

  def posted_at(object)
    object.created_at.strftime('%d %b %Y, %I:%M:%S %p')
  end

end
