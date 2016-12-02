Listabeta.Startups ?= {}

Listabeta.Startups.Edit =
  init: ->
    name = $(".js-name-count-char")
    nameValue = $(".js-name-count-char-value")
    pitch = $(".js-pitch-count-char")
    pitchValue = $('.js-pitch-count-char-value')
    description = $(".js-description-count-char")
    descriptionValue = $(".js-description-count-char-value")

    # Change color on load
    if (20 - $(name).val().length) <= 3
      $(nameValue).removeClass('c-cyan')
      $(nameValue).addClass('c-red')
    else
      $(nameValue).removeClass('c-red')
      $(nameValue).addClass('c-cyan')

    if (75 - $(pitch).val().length) <= 5
      $(pitchValue).removeClass('c-cyan')
      $(pitchValue).addClass('c-red')
    else
      $(pitchValue).removeClass('c-red')
      $(pitchValue).addClass('c-cyan')

    if (500 - $(description).val().length) <= 10
      $(descriptionValue).removeClass('c-cyan')
      $(descriptionValue).addClass('c-red')
    else
      $(descriptionValue).removeClass('c-red')
      $(descriptionValue).addClass('c-cyan')

    # Execute when key is pressed
    $(name).keyup ->
      current = 20 - $(this).val().length
      # Turn the number red
      if current <= 3
        $(nameValue).removeClass('c-cyan')
        $(nameValue).addClass('c-red')
      else
        $(nameValue).removeClass('c-red')
        $(nameValue).addClass('c-cyan')
      # calculate and apply value
      $(nameValue).html(current)

    # Execute when key is pressed
    $(pitch).keyup ->
      current = 75 - $(this).val().length
      # Turn the number red
      if current <= 5
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
      if current <= 10
        $(descriptionValue).removeClass('c-cyan')
        $(descriptionValue).addClass('c-red')
      else
        $(descriptionValue).removeClass('c-red')
        $(descriptionValue).addClass('c-cyan')
      # calculate and apply value
      $(descriptionValue).html(current)

  modules: -> []
