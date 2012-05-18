class App.Views.Menu extends Backbone.View
  el: '#menu'
  events:
    'click li a': 'visitPage'

  visitPage: (e) ->
    url = $(e.target).attr('href')
    App.router.navigate(url, true)
    false
