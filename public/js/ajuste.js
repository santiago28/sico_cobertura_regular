var url = window.location.protocol + "//" + window.location.host + "/sico_cobertura_regular/" + "cob_ajuste/subirexcusa/" + $("#id_actaconteo_persona_facturacion").val();
$(".confirmar_ajuste").click(function() {
	if($( '#ajuste' ).parsley( 'validate' )){
		$('#confirmacion_ajuste').modal('show');
	}
});


$(".fileupload").change(function() {
  var archivo = $(this);
  $(archivo).parent().find('#progress .progress-bar').css(
    "width", "0%"
  );
  var formData = new FormData($('#ajuste ')[0]);
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
      } else if(data == "Peso") {
        alert("El archivo no debe tener un peso mayor a 100 mb");
      } else {
        $(archivo).parent().find('#progress .progress-bar').css(
          "width", "100%"
        );
        // $(archivo).parent().find(".captura").html("Clic para ver");
        $(archivo).parent().find("href").html(window.location.protocol + "//" + window.location.host + "/sico_cobertura_regular/files/excusa/" + data);
        $(".urlEvidenciaAtencion").val(data);
      }
    }
  });
});
