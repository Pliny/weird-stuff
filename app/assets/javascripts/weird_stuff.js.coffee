
disableSharingLinks = () ->
  $('.share-twitter,.share-facebook').each( (index, $link) ->
    $link.onclick = () -> return false
  )

getNextPage = () ->
  $.ajax({
    type:     'GET',
    url:      $('#content').attr('url-for-next'),
    data:     '',
    success:  weirdSiteLiked,
    dataType: 'html'
  })

weirdSiteLiked = (data, status, xhr) ->
  $('.facebook-like').remove()
  $('#content').append(data)
  disableSharingLinks()
  window.animateScrollTo($('.page').last(), 1000)
  setTimeout((() ->
    FB.XFBML.parse()
  ), 1000)

$(document).on('ready', disableSharingLinks )
$(document).on('ready', () ->
  setInterval(() ->
    $div = $('.vertical-animate')
    $div.before($div.clone(true)).remove()
  , 12000
  )
)

$(document).on('click', '.share-twitter,.share-facebook', () ->
  left = window.screenX + 256
  top  = window.screenY + 250
  window.open($(this).attr('href'),'popUpWindow', 'height=350,width=800,left=' + left + ',top=' + top + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
)

$(document).on('ajax:success', '.admin-skip', (evt, data, status, xhr) -> getNextPage())
window.fbAsyncInit = () -> FB.Event.subscribe('edge.create', (response) -> getNextPage())


