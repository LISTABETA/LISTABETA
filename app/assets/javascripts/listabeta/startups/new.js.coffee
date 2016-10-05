Listabeta.Startups ?= {}

Listabeta.Startups.New =
  init: ->
    pitch = $(".js-pitch-count-char")
    pitchValue = $('.js-pitch-count-char-value')
    description = $(".js-description-count-char")
    descriptionValue = $(".js-description-count-char-value")
    # Change color on load
    if (140 - $(pitch).val().length) <= 0
      $(pitchValue).css('color', 'red')
    else
      $(pitchValue).css('color', 'black')

    if (1024 - $(description).val().length) <= 0
      $(descriptionValue).css('color', 'red')
    else
      $(descriptionValue).css('color', 'black')

    # Execute when key is pressed
    $(pitch).keyup ->
      current = 140 - $(this).val().length
      # Turn the number red
      if current <= 0
        $(pitchValue).css('color', 'red')
      else
        $(pitchValue).css('color', 'black')
      # calculate and apply value
      $(pitchValue).html(current)

    # Execute when key is pressed
    $(description).keyup ->
      current = 1024 - $(this).val().length
      # Turn the number red
      if current <= 0
        $(descriptionValue).css('color', 'red')
      else
        $(descriptionValue).css('color', 'black')
      # calculate and apply value
      $(descriptionValue).html(current)

  modules: -> []
