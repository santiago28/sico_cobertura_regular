{{ content() }}

<style>
.principal {
  /* background: yellow; */
  height: 500px;
  /*IMPORTANTE*/
  display: flex;
  justify-content: center;
  align-items: center;
}

.secundario {
  /* background: red; */
  width: 480px;
}
</style>

<div class="principal">
  <div class="secundario"><h3>Generando reporte consolidado...</h3></div>
</div>

<script>
setTimeout(function(){
  $(document).ready(function(){
    var Export = [];
    {% for beneficiario in beneficiarios %}
    Export.push({
      "Contrato": "{{ beneficiario.id_contrato }}",
      {% if(beneficiario.CobActaconteo) %}
      "Oferente": "{{ beneficiario.CobActaconteo.oferente_nombre }}",
      "Nombre sede": "{{ beneficiario.CobActaconteo.sede_nombre }}",
      {% else %}
      "Oferente Nombre":"",
      "Nombre sede":"",
      {% endif %}
      "Número documento": "{{ beneficiario.numDocumento }}",
      "Apellidos": "{{ beneficiario.primerApellido }} {{ beneficiario.segundoApellido }}",
      "Nombres": "{{ beneficiario.primerNombre }} {{ beneficiario.segundoNombre }}",
      "Grupo - Jornada": "{{ beneficiario.grupo }} - {{beneficiario.nombre_jornada}}",
      "Asistencia  Final": "{{ beneficiario.asistenciaFinalFacturacion }}",
      "Asistencia Final Texto": "{{ beneficiario.getAsistenciaFinalDetail() }}",
      "Certificación Facturación": "{{ beneficiario.getCertificacionFacturacion() }}",
      "Matriculado SIMAT": "OK"
    })
    {% endfor %}
    alasql('SELECT * INTO XLSX("Reporte Consolidado Facturación.xlsx",{headers:true}) FROM ?', [Export]);
    window.close();
  });
},1000);
</script>
