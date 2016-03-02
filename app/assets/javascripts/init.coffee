window.App ||= {}

App.init = ->
  $('i').tooltip()

$(document).on "page:change", ->
  App.init()
  return
