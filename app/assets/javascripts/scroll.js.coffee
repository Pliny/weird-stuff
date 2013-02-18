$(document).on('ready', () ->

  window.animateScrollTo = ($target, duration) ->
    offset   = window.pageYOffset
    delta    = $target.offset().top - window.pageYOffset
    duration = duration or 1000                # default 1 sec animation
    start    = Date.now()                      # get start time
    factor   = 0

    clearInterval(timer) if( timer )           # stop any running animations

    step = () ->
      factor = (Date.now() - start) / duration # get interpolation factor
      if( factor >= 1 )
        clearInterval(timer)                   # stop animation
        factor = 1                             # clip to max 1.0
      diff = (1/(1+Math.exp(-(-7+14*factor))))
      y = diff * delta + offset
      window.scrollBy(0, y - window.pageYOffset)

    timer = setInterval(step, 20)
)
