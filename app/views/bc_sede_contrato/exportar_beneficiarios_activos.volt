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
      "GRADO": "{{ beneficiario.grado_cod_simat }}",
      "GRUPO": "{{ beneficiario.grupo_simat }}",
      "TIPODOC": "{{ beneficiario.tipo_documento }}",
      "NUMDOC": "{{ beneficiario.documento }}",
      "APELLIDO1": "{{ beneficiario.apellido1 }}",
      "APELLIDO2": "{{ beneficiario.apellido2 }}",
      "NOMBRE1": "{{ beneficiario.nombre1 }}",
      "NOMBRE2": "{{ beneficiario.nombre2 }}",
      "GENERO": "{{ beneficiario.genero }}",
      "CONTRATO": "{{ beneficiario.id_contrato }}",
      "ID_OFERENTE": "{{ beneficiario.id_oferente }}",
      "INSTITUCION":"<?php echo str_replace('"', '', $beneficiario->institucion); ?>",
      "ID_MODALIDAD": "{{ beneficiario.id_modalidad }}",
      "MODALIDAD": "{{ beneficiario.modalidad_nombre }}",
      "ID_SEDE": "{{ beneficiario.id_sede }}",
      "SEDE": "<?php echo str_replace('"', '', $beneficiario->nombre_sede); ?>",
      "ID_JORNADA": "{{ beneficiario.id_jornada }}",
      "JORNADA": "{{ beneficiario.nombre_jornada }}",
      "INGRESO": "{{ beneficiario.ingreso }}",
      "FECHA MATRÍCULA": "{{ beneficiario.fecha_ini }}"
    })
    {% endfor %}
    alasql('SELECT * INTO XLSX("Reporte Beneficiarios Activos.xlsx",{headers:true}) FROM ?', [Export]);
  });
},1000);
</script>
