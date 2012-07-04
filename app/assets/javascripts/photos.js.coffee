#= require jquery-ui
#= require jquery-fileupload/vendor/jquery.ui.widget
#= require jquery-fileupload/jquery.iframe-transport
#= require jquery-fileupload/jquery.fileupload
class PhotosManager
  constructor: ->
    _.bindAll(this)
    @$select_album = $('#albums')
    @renderGrid()
    @listenEvents()

    @loadAlbums()
    @initUploader()
    @makeDraggable $('.image')
    @changeColor()

  listenEvents: ->
    $('.new_album').bind 'click', @createAlbum
    $('a.delete').live 'click', @deletePhoto
    $('.droppable').droppable drop: @createAlbumPhoto
    @$select_album.bind 'change', @loadSelectedAlbum

  loadAlbums: ->
    self = this
    $.getJSON '/albums', (albums) ->
      self.$select_album.html $('<option />').text('Seleccione un álbum')
      $.each albums, (index, album) -> self.appendAlbum.bind(self)(album)

  createAlbum: ->
    self = this
    $.post '/albums.json',
      album:
        title: prompt('Nombre del nuevo álbum:')
    , (album) ->
      self.appendAlbum(album)
      self.$select_album.val(album.id)
    false

  appendAlbum: (album) ->
    @$select_album.append $('<option />').attr(value: album.id).text(album.title)

  deletePhoto: (e) ->
    self = this
    $x = $(e.currentTarget)
    $.post $x.attr('href'), _method: 'delete', ->
      $x.parent().animate opacity: 0, 'slow', ->
        $(this).remove()
        self.loadSelectedAlbum()
    false

  renderGrid: ->
    $clear = -> $('<div />').attr(class: 'clear')
    $('.repo .clear').remove()
    $('.image:nth-child(4n)').each ->
      $(this).css(marginRight: 0)
      $(this).after($clear())
    $('.repo').append($clear())

  makeDraggable: ($img) ->
    $img.draggable
      cursor: 'copy'
      revert: true
      start: -> $('.droppable').show()
      stop:  -> $('.droppable').hide()

  initUploader: ->
    self = this
    $('.photos form').fileupload
      start: ->
        $('#photo_photo').attr('disabled', true)
      done:  (e, data) ->
        $('#photo_photo').attr('disabled', false)
        $image = $(data.result).hide()
        $('.repo').append($image)
        $image.css(opacity: 0).show()
        $image.animate(opacity: 1, 'slow')
        self.renderGrid()
        self.makeDraggable($image)

  createAlbumPhoto: (e, ui) ->
    self = this
    album_id  = parseInt @$select_album.find('option:selected').val()
    unless album_id
      alert 'Seleccione un álbum'
      return

    photo_id = $(ui.draggable).data('id')
    $.post "/albums/#{album_id}/photos",
      album_photo:
        photo_id: photo_id
        position: 1
      , (html) ->
        $('.album-photos').prepend(html)

  loadSelectedAlbum: ->
    album_id  = parseInt @$select_album.find('option:selected').val()
    return  unless album_id

    $.get "/albums/#{album_id}/photos", (html) ->
      $('.album-photos').replaceWith(html)
      $('.album-photos').sortable
        axis: 'y'
        cursor: 'move'
        stop: (e, ui) ->
          position = $('.album-photos li').index($(ui.item)) + 1
          id = $(ui.item).data('id')
          $.post "/album_photos/#{id}",
            _method: 'put'
            album_photo:
              position: position
  
  changeColor: ->
    $('.repo').find('.resized').css('background','red') 
  
$(document).ready -> new PhotosManager
