$ ->
  window.onfocus = ->
    f = ->
      $.getJSON "timestamps?FILE=#{CS_FN}", (data) ->
        if data.cs == FINGERPRINT.cs and data.js == FINGERPRINT.js
          # do nothing if files didn't change
        else
          # reload the page
          location.reload true

    # In some editors, like TextMate, files get saved when you remove
    # focus from the editor, so we give a couple seconds for the save
    # to happen and for coffee -wc to wake up.
    setTimeout f, 2000