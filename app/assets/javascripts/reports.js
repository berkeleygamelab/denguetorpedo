$(document).ready(function() {
	$("#elimination_type").change(function() {

		$("select.elimination_methods").hide();
		
		if($("select#elimination_type").val() == "Pratinho de planta") {
			$("select#prantinho").show();
		} else if ($("select#elimination_type").val() == "Pneu") {
			$("select#pneu").show();
		} else if ($("#elimination_type").val() == "Lixo (recipientes inutilizados)") {
			$("select#lixo").show();
		} else if ($("#elimination_type").val() == "Pequenos Recipientes utilizáveis") {
			$("select#pequenos").show();
		} else if ($("#elimination_type").val() == "Grandes Recipientes Utilizáveis") {
			$("select#grandes").show();
		} else if ($("#elimination_type").val() == "Calha") {
			$("select#calha").show();
		} else if ($("#elimination_type").val() == "Registros abertos") {
			$("select#registros").show();
		} else if ($("#elimination_type").val() == "Laje e terraços com água") {
			$("select#laje").show();
		} else if ($("#elimination_type").val() == "Piscinas") {
			$("select#piscinas").show();
		} else if ($("#elimination_type").val() == "Poças d’água na rua") {
			$("select#pocas").show();
		} else if ($("#elimination_type").val() == "Ralos") {
			$("select#ralos").show();
		} else if ($("#elimination_type").val() == "Plantas ornamentais que acumulam água (ex: bromélias)") {
			$("select#plantas").show();
		}
	});
	$("select.elimination_methods").change(function() {
		$("input#selected_elimination_method").val($(this).val());
	});
});