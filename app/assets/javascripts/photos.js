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
});
