$ ->
  # Experimental feature.  This may be obnoxious.  We could tame it by
  # having an API to test whether a reload is necessary.
  window.onfocus = ->
    f = ->
      location.reload true

    # In some editors, like TextMate, files get saved when you remove
    # focus from the editor, so we give a couple seconds for the save
    # to happen and for coffee -wc to wake up.
    setTimeout f, 2000