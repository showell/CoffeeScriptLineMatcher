$ ->
  # Experimental feature.  This may be obnoxious.  We could tame it by
  # having an API to test whether a reload is necessary.
  window.onfocus = ->
    f = ->
      location.reload true
    setTimeout f, 500