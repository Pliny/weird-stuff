module ApplicationHelper

  COLORS = 14

  def bg_color_of page
    @bg_color_of ||= {
      header:   "bg-color%02d" % ((page)   % COLORS),
      angle:    "angle%02d"    % ((page)   % COLORS),
      footer:   "bg-color%02d" % ((page+1) % COLORS),
      font:     page == 0 ? 'initial-color'          : "color%02d"          % ((page%COLORS == 0) ? COLORS-1 : (page%COLORS)-1),
      facebook: page == 0 ? 'initial-share-facebook' : "share-facebook%02d" % ((page%COLORS == 0) ? COLORS-1 : (page%COLORS)-1),
      twitter:  page == 0 ? 'initial-share-twitter'  : "share-twitter%02d"  % ((page%COLORS == 0) ? COLORS-1 : (page%COLORS)-1)
    }
  end

end
