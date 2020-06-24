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
      "ID_PRESTADOR": "{{ beneficiario.BcSedeContrato.id_oferente }}",
      "PRESTADOR_SERVICIO": "{{ beneficiario.BcSedeContrato.oferente_nombre }}",
      "NUMERO_CONTRATO": "{{ beneficiario.id_contrato }}",
      "ID_MODALIDAD_ORIGEN": "{{ beneficiario.BcSedeContrato.id_modalidad }}",
      "NOMBRE_MODALIDAD": "{{ beneficiario.BcSedeContrato.modalidad_nombre }}",
      "ID_SEDE": "{{ beneficiario.id_sede }}",
      "NOMBRE_SEDE": "{{ beneficiario.nombre_sede }}",
      "NOMBRE_BARRIO_SEDE": "{{ beneficiario.BcSedeContrato.sede_barrio }}",
      "DIRECCION_SEDE": "{{ beneficiario.BcSedeContrato.sede_direccion }}",
      "TELEFONO_SEDE": "{{ beneficiario.BcSedeContrato.sede_telefono }}",
      "ID_SEDE_CONTRATO": "{{ beneficiario.id_sede }}<?php echo substr($beneficiario->id_contrato,-5) ?>",
      "ID_JORNADA": "{{ beneficiario.id_jornada }}",
      "NONBRE_JORNADA": "{{ beneficiario.nombre_jornada }}",
      "ID_GRUPO": "{{ beneficiario.grupo_simat }}",
      "NOMBRE_GRUPO": "{{ beneficiario.grupo_simat }}",
      "ID_PERSONA": "{{ beneficiario.documento }}",
      "TIPO_DOCUMENTO": "{{ beneficiario.tipo_documento }}",
      "NUMERO_DOCUMENTO": "{{ beneficiario.documento }}",
      "PRIMER_NOMBRE": "{{ beneficiario.nombre1 }}",
      "SEGUNDO_NOMBRE": "{{ beneficiario.nombre2 }}",
      "PRIMER_APELLIDO": "{{ beneficiario.apellido1 }}",
      "SEGUNDO_APELLIDO": "{{ beneficiario.apellido2 }}",
      "INGRESO": "{{ beneficiario.ingreso }}",
      "CODIGO_DANE": "{{ beneficiario.codigo_dane }}"
    })
    {% endfor %}
    alasql('SELECT * INTO XLSX("MAT.xlsx",{headers:true}) FROM ?', [Export]);
    window.close();
  });
},1000);
</script>
