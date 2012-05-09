class App.Views.Gallery extends Backbone.View
  events:
    'click .arrow.left':  'moveLeft'
    'click .arrow.right': 'moveRight'

  initialize: ->
    _.bindAll(this)
    @initStyles()
    @createArrows()
    @showHideArrows()
    @page  = 1
    @total = @$img.length

  initStyles: ->
    @$gallery = @$('.gallery')
    @$('img.placeholder').css(display: 'none')
    @$img = @$gallery.find('img.carousel')
    @$img.css
      float: 'left'
      display: 'block'
    @$el.css
      position: 'relative'
      overflow: 'hidden'
    @$gallery.css
      position: 'absolute'
      width:  @$img.width() * @$img.length
      height: @$img.height()

  createArrows: ->
    @$arrows =
      left:  @generateArrowFrom(@options.arrows.left, 'left')
      right: @generateArrowFrom(@options.arrows.right, 'right')
    @$el.append(@$arrows.left)
    @$el.append(@$arrows.right)

    @$('.arrow').css
      position: 'absolute'
      display: 'inline-block'
      top:  0
    @$arrows.left.css(left: 0)
    @$arrows.right.css(right: 0)
    @$('.arrow').css(opacity: 0)

  moveLeft: ->
    if !@moving && @page > 1
      @moving = true
      @$gallery.animate
        left: "+=#{@$img.width()}"
      , (->
        @page -= 1
        @moving = false
      ).bind(this)
    false

  moveRight: ->
    if !@moving && @page < @total
      @moving = true
      @$gallery.animate
        left: "-=#{@$img.width()}"
      , (->
        @page += 1
        @moving = false
      ).bind(this)
    false

  showHideArrows: ->
    @$el.hover(
      (-> @$('.arrow').animate(opacity: 1, 'fast')).bind(this),
      (-> @$('.arrow').animate(opacity: 0, 'fast')).bind(this)
    )

  generateArrowFrom: (url, class_name) ->
    $img = $('<img />').attr(src: url)
    $('<a />').attr(href: '#', class: "arrow #{class_name}").html($img)
