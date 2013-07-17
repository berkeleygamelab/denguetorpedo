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
		if ($("#user_middle_name").val() == "") {
			$("#firstmiddlelast").hide();
		}
	});
	$("#user_last_name").keyup(function() {
		reflectChangeInName();
	});
	$("#user_nickname").keyup(function() {
		reflectChangeInName();

		if ($("#user_nickname").val() == "") {
			$("#nickname").hide();
			$("#firstlastnickname").hide();
		}
	});

	// $("#recruitment").change
	$("select#role").change(function() {
		if($("select#role").val() == "lojista") {
			$("h1#configuration").html("Configurações do estabelecimento");
			$("label#house_name").html("Nome do estabelecimento");
			$("label#house_picture").html("Logo digital");
			$("input#house_name").attr("placeholder", "");
			$("input#phone_number").attr("disabled", true);
			$("input#confirmation").attr("disabled", true);

			$("label.commercial").show();
			$("input.commercial").show();

		} else {
			$("h1#configuration").html("Configurações da casa");
			$("label#house_name").html("Nome da casa");
			$("label#house_picture").html("Foto de casa");
			$("input#house_name").attr("placeholder", "ex. Maria Santos ou Maria e Paulo");
			$("input#phone_number").attr("disabled", false);
			$("input#confirmation").attr("disabled", false);

			$("label.commercial").hide();
			$("input.commercial").hide();
		}
	});
});