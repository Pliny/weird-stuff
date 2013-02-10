module ShareHelper

  def facebook_share_url
    "https://www.facebook.com/sharer/sharer.php?u=#{CGI.escape root_url}"
  end

  def twitter_share_url
    "https://twitter.com/share?url=#{CGI.escape root_url}&text=#{CGI.escape "Anyone else want to like weird stuff? #{root_url}" }"
  end
end
