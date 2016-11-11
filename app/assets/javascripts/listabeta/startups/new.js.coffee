Listabeta.Startups ?= {}

Listabeta.Startups.New =
  init: ->
    pitch = $(".js-pitch-count-char")
    pitchValue = $('.js-pitch-count-char-value')
    description = $(".js-description-count-char")
    descriptionValue = $(".js-description-count-char-value")

    # Change color on load
    if (75 - $(pitch).val().length) <= 0
      $(pitchValue).removeClass('c-cyan')
      $(pitchValue).addClass('c-red')
    else
      $(pitchValue).removeClass('c-red')
      $(pitchValue).addClass('c-cyan')

    if (500 - $(description).val().length) <= 0
      $(description).removeClass('c-cyan')
      $(description).addClass('c-red')
    else
      $(description).removeClass('c-red')
      $(description).addClass('c-cyan')

    # Execute when key is pressed
    $(pitch).keyup ->
      current = 75 - $(this).val().length
      # Turn the number red
      if current <= 0
        $(pitchValue).removeClass('c-cyan')
        $(pitchValue).addClass('c-red')
      else
        $(pitchValue).removeClass('c-red')
        $(pitchValue).addClass('c-cyan')
      # calculate and apply value
      $(pitchValue).html(current)

    # Execute when key is pressed
    $(description).keyup ->
      current = 500 - $(this).val().length
      # Turn the number red
      if current <= 0
        $(description).removeClass('c-cyan')
        $(description).addClass('c-red')
      else
        $(description).removeClass('c-red')
        $(description).addClass('c-cyan')
      # calculate and apply value
      $(descriptionValue).html(current)

  modules: -> []
