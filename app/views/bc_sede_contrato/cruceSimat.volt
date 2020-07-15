<style>

    .tablesorter-filter {
      width: 90px;
    }
    
    .boton-abrir{
      width: 45px;
      height: 45px;
      background: #337ab7;
      position: fixed;
      border-radius: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      bottom: 18px;
      right: 18px;
      -webkit-box-shadow: 5px 5px 37px -17px rgba(0,0,0,0.75);
      -moz-box-shadow: 5px 5px 37px -17px rgba(0,0,0,0.75);
      box-shadow: 5px 5px 37px -17px rgba(0,0,0,0.75);
      color: #fff;
      cursor: pointer;
      z-index: 1000;
    }
    
    .boton-exportar{
      width: 45px;
      height: 45px;
      background: #5cb85c;
      position: fixed;
      border-radius: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      bottom: 82px;
      right: 18px;
      -webkit-box-shadow: 5px 5px 37px -17px rgba(0,0,0,0.75);
      -moz-box-shadow: 5px 5px 37px -17px rgba(0,0,0,0.75);
      box-shadow: 5px 5px 37px -17px rgba(0,0,0,0.75);
      color: #fff;
      cursor: pointer;
      z-index: 1000;
    }
    .tableFixHead          { overflow-y: auto; height: 600px; }
    .tableFixHead thead th { position: sticky; top: 0; }
    
    /* Just common table stuff. Really. */
    table  { border-collapse: collapse; width: 100%; }
    th, td { padding: 8px 16px; }
    th     { background:#eee; }
    
    .loader,
    .loader:before,
    .loader:after {
      background:#d9edf7;
      -webkit-animation: load1 1s infinite ease-in-out;
      animation: load1 1s infinite ease-in-out;
      width: 1em;
      height: 4em;
    }
    .loader:before,
    .loader:after {
      position: absolute;
      top: 0;
      content: '';
    }
    .loader:before {
      left: -1.5em;
    }
    .loader {
      text-indent: -9999em;
      margin: 2% auto;
      position: relative;
      font-size: 11px;
      -webkit-animation-delay: 0.16s;
      animation-delay: 0.16s;
    }
    .loader:after {
      left: 1.5em;
      -webkit-animation-delay: 0.32s;
      animation-delay: 0.32s;
    }
    @-webkit-keyframes load1 {
      0%,
      80%,
      100% {
        box-shadow: 0 0 #FFF;
        height: 4em;
      }
      40% {
        box-shadow: 0 -2em #ffffff;
        height: 5em;
      }
    }
    @keyframes load1 {
      0%,
      80%,
      100% {
        box-shadow: 0 0 #FFF;
        height: 4em;
      }
      40% {
        box-shadow: 0 -2em #ffffff;
        height: 5em;
      }
    }
</style>

<br>
<br>

<div class="form-group" align="center">
  <h1  style="margin:2%;"><span><b>CRUCE SIMAT</b></span></h1>
  <br>
  <br>
  <button type="button" id="ExportaSimat"  class="btn btn-primary btn-lg">Descargar Estudiantes Sobrantes Simat</button> ||
  <button type="button" id="ExportaCobertura" class="btn btn-default btn-lg">Descargar Estudiantes Sobrantes Cobertura</button>
</div>


<script>
  setTimeout(function(){
    $("#ExportaSimat").click(function(){
        var Export = [];
        {% for beneficiario in beneficiario_sobrantes_simat %}
            Export.push({
              "Documento": "<?php echo trim($beneficiario->documento); ?>",
              "Contrato": "<?php echo trim($beneficiario->id_contrato); ?>",
              "Apellidos": "{{beneficiario.apellido1}}  {{beneficiario.apellido2}} ",
              "Nombres": "{{beneficiario.nombre1}}  {{beneficiario.nombre2}}",
              "Grado": "{{beneficiario.grado_cod_simat}}",
              "Grupo": "<?php echo trim($beneficiario->grupo_simat); ?>"
            });
        {% endfor %}
        alasql('SELECT * INTO XLSX("Reporte Simat.xlsx",{headers:true}) FROM ?', [Export]);
    });

    $("#ExportaCobertura").click(function(){
        var Export = [];
        {% for beneficiario in beneficiario_sobrantes_cobertura %}
            Export.push({
              "Año": "{{beneficiario.ano}}",
              "Contrato": "<?php echo trim($beneficiario->id_contrato); ?>",
              "Estado": "{{beneficiario.estado}}",
              "Institucion": "{{beneficiario.institucion}}",
              "Dane": "{{beneficiario.codigo_dane}}",
              "prestacion_servicio": "{{beneficiario.prestacion_servicio}}",
              "sector": "{{beneficiario.sector}}",
              "sede": "{{beneficiario.nombre_sede}}",
              "zona_sede": "{{beneficiario.zona_sede}}",
              "nombre_jornada": "{{beneficiario.nombre_jornada}}",
              "grado": "{{beneficiario.grado_cod_simat}}",
              "grupo": "{{beneficiario.grupo_simat}}",
              "modelo": "{{beneficiario.modelo}}",
              "fecha_ini": "{{beneficiario.fecha_ini}}",
              "estrato": "{{beneficiario.estrato}}",
              "id_persona_simat": "{{beneficiario.id_persona_simat}}",
              "tipo_documento": "{{beneficiario.tipo_documento}}",
              "Documento": "<?php echo trim($beneficiario->documento); ?>",
              "Apellidos": "{{beneficiario.apellido1}}  {{beneficiario.apellido2}} ",
              "Nombres": "{{beneficiario.nombre1}}  {{beneficiario.nombre2}}",
              "genero": "{{beneficiario.genero}}",
              "fecha_nacimiento": "{{beneficiario.fecha_nacimiento}}",
              "fuente_recursos": "{{beneficiario.fuente_recursos}}",
              "pais_origen": "<?php echo trim($beneficiario->pais_origen); ?>"
            });
        {% endfor %}
        alasql('SELECT * INTO XLSX("Reporte Cobertura.xlsx",{headers:true}) FROM ?', [Export]);
    });
  }, 1000);
</script>