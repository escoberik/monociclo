#= require jquery-ui
#= require jquery-fileupload/vendor/jquery.ui.widget
#= require jquery-fileupload/jquery.iframe-transport
#= require jquery-fileupload/jquery.fileupload
$(document).ready ->
  $('.new_album').bind 'click', ->
    $.post '/albums',
      album:
        title: prompt('Nombre del nuevo álbum:')
    false

  $.getJSON '/albums', (data) ->
    $select = $('#albums')
    $prompt = $('<option />').text('Seleccione un álbum')
    $select.html($prompt)

    $.each data, (i, el) ->
      $option = $('<option />').attr(value: el.id).text(el.title)
      $select.append($option)

  $clear = -> $('<div />').attr(class: 'clear')
  renderGrid = ->
    $('.repo .clear').remove()
    $('.image:nth-child(4n)').each ->
      $(this).css(marginRight: 0)
      $(this).after($clear())
    $('.repo').append($clear())
  renderGrid()

  makeDraggable = ($img) ->
    $img.draggable
      cursor: 'copy'
      revert: true
  makeDraggable $('.image')

  $('.photos form').fileupload
    start: ->
      $('#photo_photo').attr('disabled', true)
    done:  (e, data) ->
      $('#photo_photo').attr('disabled', false)
      $image = $(data.result).hide()
      $('.repo').append($image)
      $image.css(opacity: 0).show()
      $image.animate(opacity: 1, 'slow')
      renderGrid()
      makeDraggable($image)

  $('.droppable').droppable
    drop: (e, ui) ->
      $select   = $('#albums')
      $selected = $select.find('option:selected')
      photo_id  = $(ui.draggable).data('id')
      album_id  = parseInt $selected.val()

      unless album_id
        alert('Por favor, seleccione un álbum')
        return

      $.post "/album_photos/#{album_id}.json",
        _method: 'put'
        photo_id: photo_id
      $('.droppable li').remove()
      $.getJSON "/album_photos/#{album_id}.json", (json) ->
        $.each json, (i, el) ->
          $li = $('<li />')
          $x  = $('<img />').attr(src: '/assets/boton.png')
          $a  = $('<a />').html($x).attr
            href: "/album_photos/#{el.id}"
            data:
              method: 'delete'
          $img = $('<img />').attr(src: el.url)
          $('.droppable').append($li)

  $('a[data-method="delete"]').bind 'click', ->
    $x = $(this)
    $.post $x.attr('href'),
      _method: 'delete'
    , ->
      $x.parent().animate opacity: 0, 'slow', ->
        $(this).remove()
        renderGrid()
    false
