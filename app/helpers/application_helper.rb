module ApplicationHelper
  include Pagy::Frontend

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
