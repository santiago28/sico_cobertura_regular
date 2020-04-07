var url = window.location.protocol + "//" + window.location.host + "/sico_cobertura_regular/" + "cob_actaconteo/subirexcusa/" + $("#id_actaconteo").val();
$(document).ready(function () {
  $('.encuentroSede').change(function() {
    var encuentroSede = $(this).val();
    $selector = $(this).parent().parent().next();
    if(encuentroSede == 2){
      $selector.removeClass("hidden");
      $selector.find(".servicio").removeClass("hidden").addClass("required");
      $selector.find(".servicio").removeAttr("disabled");
    } else {
      $selector.addClass("hidden");
      $selector.find(".servicio").attr("disabled", "disabled");
      $selector.find(".servicio").removeClass("required").addClass("hidden");
    }
  });
});

$(".fileupload").change(function() {
  var archivo = $(this);
  $(archivo).parent().find('#progress .progress-bar').css(
    "width", "0%"
  );
  var formData = new FormData($('#datos_form ')[0]);
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
