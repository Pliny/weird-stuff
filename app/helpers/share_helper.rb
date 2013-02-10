module ShareHelper

  def facebook_share_url
    "https://www.facebook.com/sharer/sharer.php?u=#{CGI.escape root_url}"
    # https://www.facebook.com/sharer/sharer.php?
    #   s=100
    #   &p%5Btitle%5D=Like+Weird+Stuff
    #   &p%5Bsummary%5D=Testing+1+2+3
    #   &p%5Burl%5D=http%3A%2F%2Fweird-stuff.herokuapp.com
    #   &p%5Bimages%5D%5B0%5D=https%3A%2F%2Fs3.amazonaws.com%2Fweird-stuff%2Fshare%2Flikeweirdstuff.jpg
  end

  def twitter_share_url
    "http://www.twitter.com"
  end
end
