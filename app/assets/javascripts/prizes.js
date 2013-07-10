// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function() {
	$("#how_to").tooltip({content: $("#how_to").attr('title')});

	$(":checkbox").mousedown(function() {
		if ($(":checkbox").is(':checked')) {
			$("#prize_expire_on_3i").attr("disabled", true);
			$("#prize_expire_on_2i").attr("disabled", true);
			$("#prize_expire_on_1i").attr("disabled", true);
		} else {
			
			$("#prize_expire_on_3i").attr("disabled", false);
			$("#prize_expire_on_2i").attr("disabled", false);
			$("#prize_expire_on_1i").attr("disabled", false);
		}
	});
});
