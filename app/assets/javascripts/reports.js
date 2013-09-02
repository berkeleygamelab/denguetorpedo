$(document).ready(function() {

	$("select.elimination_type").each(function() {
		$(this).parent().find("select.elimination_methods").hide();

		if($(this).val() == "Pratinho de planta") {
			$(this).parent().find("select#prantinho").show();
		} else if ($(this).val() == "Pneu") {
			$(this).parent().find("select#pneu").show();
		} else if ($(this).val() == "Lixo (recipientes inutilizados)") {
			$(this).parent().find("select#lixo").show();
		} else if ($(this).val() == "Pequenos Recipientes utilizáveis") {
			$(this).parent().find("select#pequenos").show();
		} else if ($(this).val() == "Caixa d'água aberta na residência") {
			$(this).parent().find("select#caixa").show();
		} else if ($(this).val() == "Grandes Recipientes Utilizáveis") {
			$(this).parent().find("select#grandes").show();
		} else if ($(this).val() == "Calha") {
			$(this).parent().find("select#calha").show();
		} else if ($(this).val() == "Registros abertos") {
			$(this).parent().find("select#registros").show();
		} else if ($(this).val() == "Laje e terraços com água") {
			$(this).parent().find("select#laje").show();
		} else if ($(this).val() == "Piscinas") {
			$(this).parent().find("select#piscinas").show();
		} else if ($(this).val() == "Poças d’água na rua") {
			$(this).parent().find("select#pocas").show();
		} else if ($(this).val() == "Ralos") {
			$(this).parent().find("select#ralos").show();
		} else if ($(this).val() == "Plantas ornamentais que acumulam água (ex: bromélias)") {
			$(this).parent().find("select#plantas").show();
		} else if ($(this).val() == "Outro tipo") {
			window.location.href = "/feedbacks/new?title=other_type";
		} else {
			$(this).parent().find("select#prantinho").show();
		}
	});
	if($(this).val() == "Pratinho de planta") {
			$(this).parent().find("select#prantinho").show();
		} else if ($(this).val() == "Pneu") {
			$(this).parent().find("select#pneu").show();
		} else if ($(this).val() == "Lixo (recipientes inutilizados)") {
			$(this).parent().find("select#lixo").show();
		} else if ($(this).val() == "Pequenos Recipientes utilizáveis") {
			$(this).parent().find("select#pequenos").show();
		} else if ($(this).val() == "Caixa d'água aberta na residência") {
			$(this).parent().find("select#caixa").show();
		} else if ($(this).val() == "Grandes Recipientes Utilizáveis") {
			$(this).parent().find("select#grandes").show();
		} else if ($(this).val() == "Calha") {
			$(this).parent().find("select#calha").show();
		} else if ($(this).val() == "Registros abertos") {
			$(this).parent().find("select#registros").show();
		} else if ($(this).val() == "Laje e terraços com água") {
			$(this).parent().find("select#laje").show();
		} else if ($(this).val() == "Piscinas") {
			$(this).parent().find("select#piscinas").show();
		} else if ($(this).val() == "Poças d’água na rua") {
			$(this).parent().find("select#pocas").show();
		} else if ($(this).val() == "Ralos") {
			$(this).parent().find("select#ralos").show();
		} else if ($(this).val() == "Plantas ornamentais que acumulam água (ex: bromélias)") {
			$(this).parent().find("select#plantas").show();
		} else if ($(this).val() == "Outro tipo") {
			window.location.href = "/feedbacks/new?title=other_type";
		} else {
			$(this).parent().find("select#prantinho").show();
		}

	

	$("select.elimination_methods").change(function() {
		if ($(this).val() == "Outro método") {
			window.location.href = "/feedbacks/new?title=other_method";
		} else {
			// alert($(this).val());
			$(this).parent().find("input#selected_elimination_method").val($(this).val());
		}
		
	});
});