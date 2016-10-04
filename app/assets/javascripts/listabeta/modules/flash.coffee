Listabeta.Flash =
  init: ->
    setTimeout( ->
      $('.flash').slideDown()
    , 100)
    if $('.flash').length > 0
      setTimeout( ->
        $('.flash').slideUp()
      , 6000)
    $(document).one 'click', ->
      $('.flash').slideUp()
