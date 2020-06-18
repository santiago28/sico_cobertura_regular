
$(".fileupload").change(function() {
  var archivo = $(this);
  $(archivo).parent().find('#progress .progress-bar').css(
    "width", "0%"
  );
  var form =$(this).closest("form").attr('id');
  var url ="";
  if(form =="evidencia_form"){
      url = window.location.protocol + "//" + window.location.host + "/sico_cobertura_regular/" + "bc_sede_contrato/subirEvidencia/" + $("#documento").val();
   }else{
     url = window.location.protocol + "//" + window.location.host + "/sico_cobertura_regular/" + "bc_sede_contrato/subirEvidencia/" + $("#documento1").val();
   }
  var formData = new FormData($('#'+ form)[0]);
  $.ajax( {
    url: url,
    type: 'POST',
    data: formData,
    processData: false,
    contentType: false,
    success: function (data) {
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