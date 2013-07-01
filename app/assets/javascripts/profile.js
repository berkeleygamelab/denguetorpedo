function reflectChangeInName() {
	// for (var i = 0; i < length; i++) {
	// 	var child = $("#display_select").children()[i];
	// 	var id = $(child).attr("id");
		
	// }

	// alert($("#firstmiddlelast").html());
	$("#firstmiddlelast").html($("#user_first_name").val() + " " + $("#user_middle_name").val() + " " + $("#user_last_name").val());
	$("#firstlast").html($("#user_first_name").val() + " " + $("#user_last_name").val());
	$("#first").html($("#user_first_name").val());
	$("#nickname").html($("#user_nickname").val());
	$("#firstlastnickname").html($("#user_first_name").val() + " " + $("#user_last_name").val() + " (" + $("#user_nickname").val() + ")"); 
}

$(document).ready(function() {
	$(document).tooltip();

	$("#user_first_name").keyup(function() {
		reflectChangeInName();
	});
	$("#user_middle_name").keyup(function() {
		reflectChangeInName();
	});
	$("#user_last_name").keyup(function() {
		reflectChangeInName();
	});
	$("#user_nickname").keyup(function() {
		reflectChangeInName();
	});
});