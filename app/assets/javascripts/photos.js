// = require jquery
// = require jquery-ui
// = require jquery_ujs

$(document).ready(function() {
  $(".new_album").bind("click", function() {
    var name = prompt("Nombre del nuevo álbum:")
    $.post("/albums", {
      album: { title: name }
    });
    return false;
  });
  
  $.getJSON('/albums', function(data) {
    var $select = $('#albums');
    var $prompt = $('<option />').text('Seleccione álbum');
    $select.html($prompt);

    $.each(data, function(i, el) {
      var $option = $('<option />').attr({ value: el.id }).text(el.title);
      $select.append($option);
    });
  });
  
  $('.image').draggable({
    cursor: 'move',
    revert: true
  });
  
  $( '.droppable' ).droppable({
		drop: function( event, ui ) {
		  var $select = $('#albums');
		  var $selected = $select.find('option:selected');
	    var photo_id = $(ui.draggable).data("id");
	    var album_id = parseInt($selected.val());
	    if (album_id) {
	      $.post('/album_photos/' + album_id + ".json", {
	        _method: 'put',
	        photo_id: photo_id
	      });
	      $('.droppable li').remove()
        $.getJSON('/album_photos/' + album_id + ".json", function(json) {
        $.each(json, function(i, el) {
          var $li = $('<li />')
          var $a = $('<a />').attr({href: '/album_photos/' + el.id, "data-method": 'delete'});
          $a.append($('<img />').attr({src: '/assets/boton.png'}))
          var $img = $('<img />').attr({src: el.url});
          $li.append($a);
          $li.append($img);
          $('.droppable').append($li);
          });
        });
	    } else {
	      alert("Por el amor de dios seleccione un album");  
	    }
	    var text = photo_id + " " + $selected.val();
	  }
  });
  
  $('#albums').bind("change", function(){
    var $selected = $(this).find('option:selected');
    var album_id = parseInt($selected.val());
    $('.droppable li').remove()
    $.getJSON('/album_photos/' + album_id + ".json", function(json) {
      $.each(json, function(i, el) {
      var $li = $('<li />')
      var $a = $('<a />').attr({href: '/album_photos/' + el.id, "data-method": 'delete'});
      $a.append($('<img />').attr({src: '/assets/boton.png'}))
      var $img = $('<img />').attr({src: el.url});
      $li.append($a);
      $li.append($img);
      $('.droppable').append($li);
      });
    });
  });
});
