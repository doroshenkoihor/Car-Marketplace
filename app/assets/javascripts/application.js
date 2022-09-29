//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets

$(document).ready(function() {
  $("#brand_selector").on('change', function() {
    $.ajax({
      url: "/models.json",
      type: "GET",
      data: {brand_id: $(this).val()},
      success: function(data) {
      	$("#model_selector").children().remove();
      	var listitems = []; 
      	$.each(data, function(_, value) { listitems += '<option value="' + value.id + '">' + value.name + '</option>'; }); 
      	$("#model_selector").append(listitems);
      }
    })
  });
});
