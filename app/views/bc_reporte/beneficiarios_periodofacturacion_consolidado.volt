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
      "DANE": "{{ beneficiario.codigo_dane }}",
      "CALENDARIO": "{{ beneficiario.calendario }}",
      "PRESTACIÓN SERVICIO": "{{ beneficiario.prestacion_servicio }}",
      "GRADO": "{{ beneficiario.id_grupo }}",
      "GRUPO": "{{ beneficiario.grupo }}",
      "PER_ID": "{{ beneficiario.id_persona }}",
      "TIPODOC": "{{ beneficiario.tipoDocumento }}",
      "NUMDOC": "{{ beneficiario.numDocumento }}",
      "APELLIDO1": "{{ beneficiario.primerApellido }}",
      "APELLIDO2": "{{ beneficiario.segundoApellido }}",
      "NOMBRE1": "{{ beneficiario.primerNombre }}",
      "NOMBRE2": "{{ beneficiario.segundoNombre }}",
      "GENERO": "{{ beneficiario.genero }}",
      "CONTRATO": "{{ beneficiario.id_contrato }}",
      {% if(beneficiario.CobActaconteo) %}
      "ID_SEDE": "{{ beneficiario.id_sede }}",
      "SEDE": "<?php echo str_replace('"', '', $beneficiario->CobActaconteo->sede_nombre); ?>",
      "OFERENTE": "<?php echo str_replace('"', '', $beneficiario->CobActaconteo->oferente_nombre); ?>",
      {% else %}
      "ID_SEDE":"",
      "SEDE":"",
      "OFERENTE":"",
      {% endif %}
      "JORNADA": "{{ beneficiario.nombre_jornada }}",
      "MATRICULADO SIMAT": "SI",
      "ESTADO CERTIFICACIÓN": "{{ beneficiario.getCertificacionFacturacion() }}",
      "INGRESO": "{{ beneficiario.ingreso }}",
      "ASISTENCIA": "{{ beneficiario.asistenciaFinalFacturacion }}. {{ beneficiario.getAsistenciaFinalDetail() }}",
      "FECHA MATRÍCULA": "{{ beneficiario.fecha_matricula }}"
    })
    {% endfor %}
    alasql('SELECT * INTO XLSX("Reporte Consolidado Facturación.xlsx",{headers:true}) FROM ?', [Export]);
    window.close();
  });
},1000);
</script>
