class App.Router extends Backbone.Router
  routes:
    '*url': 'visitPage'

  visitPage: (url) ->
    action = (url || 'index').replace('-', '_')
    callback = @initGallery

    if $('.content').hasClass('fresh')
      $('.content').removeClass('fresh')
      $("a[href='/#{url}']").addClass('active')
      callback(action)
    else
      $.get url, (html) ->
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
        callback(action)

  initGallery: (action) ->
    new App.Views.Gallery
      el: ".content.#{action}"
      arrows:
        left: '/assets/buttons/big_left_arrow.png'
        right: '/assets/buttons/big_right_arrow.png'
