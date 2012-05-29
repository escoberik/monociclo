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
	      $.post('/albums/' + album_id, {
	        _method: 'put',
	        photo_id: photo_id
	      });
	    } else {
	      alert("Por el amor de dios seleccione un album");  
	    }
	    var text = photo_id + " " + $selected.val();
	  }
  });
});
