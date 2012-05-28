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
});
