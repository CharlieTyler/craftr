class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :navbar_categories
  def navbar_categories
    @navbar_categories = Category.all
  end

  def authenticate_is_author
    unless user_signed_in? && current_user.is_author?
      render plain: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :youtube_embed
  def youtube_embed(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end

    %Q{<iframe title="YouTube video player" width="640" height="390" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
  end
end
