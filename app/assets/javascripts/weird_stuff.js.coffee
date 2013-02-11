$(document).on('ready', disableSharingLinks )

disableSharingLinks = () ->
  $('.share-twitter,.share-facebook').each( (index, $link) ->
    $link.onclick = () -> return false
  )

$(document).on('click', '.share-twitter,.share-facebook', () ->
  left = window.screenX + 256
  top  = window.screenY + 250
  window.open($(this).attr('href'),'popUpWindow', 'height=350,width=800,left=' + left + ',top=' + top + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
)

$(document).on('ajax:success', '.admin-skip', (evt, data, status, xhr) ->
  $.ajax({
    type:     'GET',
    url:      $('#content').attr('url-for-next'),
    data:     '',
    success:  weirdSiteLiked,
    dataType: 'html'
  })
)

weirdSiteLiked = (data, status, xhr) ->
  # $('#facebook-like').remove()
  # $('#fb-root').children().remove()
  $('#content').append(data)
  facebookConnect(document, 'script', 'facebook-jssdk')
  disableSharingLinks()
  window.animateScrollTo($('.page').last())
