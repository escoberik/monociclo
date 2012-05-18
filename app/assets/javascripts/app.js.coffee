window.App =
  Views: {}
  init: ->
    App.router = new App.Router
    Backbone.history.start(pushState: true)
    new App.Views.Menu

$(document).ready(App.init)
