$(document).on('ready', () ->
  $('#share-twitter,#share-facebook').each( (index, $link) ->
    $link.onclick = () -> return false
  )
)

$(document).on('click', '#share-twitter,#share-facebook', () ->
  left = window.screenX + 256
  top  = window.screenY + 250
  window.open($(this).attr('href'),'popUpWindow', 'height=350,width=800,left=' + left + ',top=' + top + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
)
