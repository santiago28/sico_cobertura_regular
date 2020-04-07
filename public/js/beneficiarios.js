var url = window.location.protocol + "//" + window.location.host + "/sico_cobertura_regular/" + "cob_actaconteo/subirexcusa/" + $("#beneficiarios_form table").attr("id");
$(document).ready(function () {
	$('.asistencia').each(function() {
		var asistencia = $(this).val();
		var periodo_tipo = $('#periodo_tipo').val();

		if( asistencia == 2 || asistencia == 5 ) {
			$(this).parent().parent().find(".excusa").removeClass("hidden");
			$(this).parent().parent().find(".excusa").removeAttr("disabled");
			$(this).parent().parent().find(".excusa").addClass("required");
			// setTimeout(function(){

		// },500);
		} else {
			$(this).parent().parent().find(".excusa").addClass("hidden");
			$(this).parent().parent().find(".excusa").attr("disabled", "disabled");
			$(this).parent().parent().find(".excusa").removeClass("required");
		}

	});
	$( '#beneficiarios_form' ).parsley( 'destroy' );
	$( '#beneficiarios_form' ).parsley();
});
if($(".fecha_visita_header").html() == null){
	$( ".fecha" ).parent().remove();
}
$('.asistencia').change(function() {
	var asistencia = $(this).val();
	var periodo_tipo = $('#periodo_tipo').val();
	if( asistencia == 2 || asistencia == 5 ) {
		$(this).parent().parent().find(".excusa").removeClass("hidden");
		$(this).parent().parent().find(".excusa").removeAttr("disabled");
		$(this).parent().parent().find(".excusa").addClass("required");
		//Esta linea es para duplicar el texto de campo "Texto para replicar excusa"
		$(this).parent().parent().find(".texto_excusa").val($("#texto_excusa_replicar").val());
	} else {
		$(this).parent().parent().find(".excusa").addClass("hidden");
		$(this).parent().parent().find(".excusa").attr("disabled", "disabled");
		$(this).parent().parent().find(".excusa").removeClass("required");
	}
});
$("#boton_duplicar").click(function() {
	var fecha = $(".fecha_duplicar").val();
	$('.modal-body input:checkbox:checked').each(function(){
		var id_grupo = $(this).val();
		$('.id_grupo').each(function(){
			if(id_grupo == $(this).html()){
				$(this).parent().parent().find(".tipo-fecha").val(fecha);
			}
		});
	});
});
$(".sel-todos").click(function() {
	$('.modal-body input:checkbox').attr('checked', true);
});

$(".fileupload").change(function() {
	var archivo = $(this);
	$(archivo).parent().find('#progress .progress-bar').css(
		"width", "0%"
	);
	var formData = new FormData($('#beneficiarios_form ')[0]);
	$.ajax( {
		url: url,
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (data) {
			console.log(data);
			if(data == "Tipo"){
				alert("El tipo de imagen debe de ser jpg, png, bmp, o gif");
			} else if(data == "Error"){
				alert("Ocurrió un error la subir la imagen");
			} else {
				$(archivo).parent().find('#progress .progress-bar').css(
					"width", "100%"
				);
				// $(archivo).parent().find(".captura").html("Clic para ver");
				$(archivo).parent().find("href").html(window.location.protocol + "//" + window.location.host + "/sico_cobertura_regular/files/excusa/" + data);
				$(archivo).parent().find(".urlExcusa").val(data);
			}
		}
	});
});
