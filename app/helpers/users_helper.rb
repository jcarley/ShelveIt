module UsersHelper

  def profile_image

    return image_tag "default_profile_image.jpg", :style => "width:186px; height:186px;" unless @user.avatar?

    image_tag @user.avatar.to_s, :style => "width:60px; height:60px;" if @user.avatar?

  end

end
