class App.Router extends Backbone.Router
  routes:
    '*url': 'visitPage'

  visitPage: (url) ->
    if $('.content').hasClass('fresh')
      $('.content').removeClass('fresh')
      $("a[href='/#{url}']").addClass('active')
    else
      action = (url || 'index').replace('-', '_')
      $.get url, (html)->
        $content = $('<div />').attr(class: "content #{action}").html(html)
        $('.wrapper').append($content)

        $start = $('a.active')
        $end   = $("a[href='/#{url}']")
        $start.removeClass('active')
        $end.addClass('active')
        d = if $start.parent().index() - $end.parent().index() < 0 then 'right' else 'left'

        switch d
          when 'right'
            $content.css
              top: 0
              left: 960
            $('.content').animate
              left: '-=960px'
            , ->
              $('.content').each (i, el) ->
                if $(el).hasClass(action)
                  $(el).css(left: 0)
                else
                  $(el).remove()
          when 'left'
            $content.css
              top: 0
              left: -960
            $('.content').animate
              left: '+=960px'
            , ->
              $('.content').each (i, el) ->
                if $(el).hasClass(action)
                  $(el).css(left: 0)
                else
                  $(el).remove()
