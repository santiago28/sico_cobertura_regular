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
    
    <div class="form-group" >
      <h1 align="center" style="margin:2%;"><span><b>Reporte Prematriculas</b></span></h1>
      <br>
      <br>
    
      <button class="btn btn-success" id="ExportarExcel">EXPORTAR REGISTROS</button>
      <button class="btn btn-success" id="ExportarEliminados">ESTUDIANTES ELIMINADOS</button>
      <button class="btn btn-primary" onclick="abrirModal()" >CARGAR SIMAT</button>
      <button class="btn btn-primary" id="estado_periodo" onclick="bloquearPeriodo()">{% if(periodo_bloqueo[0].estado_periodo == 1) %} DESACTIVAR PERIODO {% else %} ACTIVAR PERIODO {% endif %}</button>
    
      <div id="contenedo">
        <div class="loader" id="loader"></div>
        <h6 align="center"><b>Cargando información en la tabla, un momento por favor</b></h6>
      </div>
    </div>
    <br>
    <br>
    <div class="tableFixHead">
    
      <table class="table table-bordered table-hover" id="tabla_beneficiarios">
        <thead>
          <tr>
            <th>Contrato</th>
            <th>Oferente</th>
            <th>T.Cupos</th>
            <th>Matriculados</th>
            <th>Pre-matriculados</th>
            <th>Rechazados</th>
            <th>Retirados</th>
          </tr>
        </thead>
        <tbody>
          {% for oferente_contrato in oferente_contratos %}
          <tr>  
            <td>{{ oferente_contrato.id_contrato }}</td>
            <td>{{ oferente_contrato.institucion }}</td>
            <td>{{ oferente_contrato.cuposSostenibilidad }}</td>
            <td>{{ oferente_contrato.matriculados }}</td>
            <td>{{ oferente_contrato.pre_matriculas }}</td>
            <td>{{ oferente_contrato.rechazados }}</td>
            <td>{{ oferente_contrato.eliminados }}</td>
          </tr>
          {% endfor %}
        </tbody>
      </table>
    </div>
     

<!-- Modal cargar excel-->
<div class="modal fade" id="modal_cargar_simat" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">CARGAR ARCHIVO SIMAT</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        {{ form("bc_sede_contrato/cruceSimat/", "method":"post", "class":"form-container form-horizontal", "parsley-validate" : "", "enctype" : "multipart/form-data") }}
          <div class="form-group" id="evidencia_archivo">
              <label for="cargarDocumento">Cargar archivo Simat</label>
              <div>
                  <!-- <input class="fileupload filestyle form-control" data-input="false" id="archivo" data-badge="false" type="file"  name="files[]" multiple required> -->
                  <input type="file" class="form-control" name="files[]" multiple id="archivo" required>
                  <div id="progress" class="progress" style="margin: 0 !important;">
                      <div class="progress-bar progress-bar-success"></div>
                  </div>
                  <input type='hidden' class='urlEvidenciaAtencion' name='urlEvidenciaAtencion'>
              </div>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn btn-primary submit" id="submit">Cargar</button>
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
          </div>
       </form>
      </div>
    </div>
  </div>
</div>

  <script> 
      
    function bloquearPeriodo(){
      var url = window.location.protocol + "//" + window.location.host + "/sico_cobertura_regular/" + "bc_sede_contrato/cambiarEstadoPeriodo";
      $.ajax({
          url: url,
          type: 'POST',
          dataType: 'json',
          success: function (data) {
            console.log(data);
            data==1? $("#estado_periodo").html("DESACTIVAR PERIODO"): $("#estado_periodo").html("ACTIVAR PERIODO");
          }
        });
    } 

    function abrirModal(){
      $("#modal_cargar_simat").modal("show");
      $('#archivo').val('')
      $(archivo).parent().find('#progress .progress-bar').css(
         "width", "0%"
       );
  
    }

    window.onload = function() {
      //funciones a ejecutar
      setTimeout(function(){
          document.getElementById("contenedo").style.display = "none";
      }, 2000);

          //Abrir modal de cambio docuemnto
     $('body').on('click', '#documentoIdentidad a', function(){
          $("#modal_editar_documento").modal("show");
              var id= $(this).attr('id');
              $('input[name="documento_anterior"]').val(id);
              $("#documento1").val(id);
      })
    };

      setTimeout(function(){
      $("#ExportarExcel").click(function(){
          var Export = [];
          {% for oferente_contrato in oferente_contratos %}
          Export.push({
          "Contrato": "{{oferente_contrato.id_contrato}}",
          "Oferente": "<?php echo str_replace('"','', $oferente_contrato->institucion); ?>",
          "T.Cupos": "{{oferente_contrato.cuposSostenibilidad}}",
          "Pre-matriculados": "{{oferente_contrato.matriculados}}",
          "Matriculados": "{{oferente_contrato.pre_matriculas}}",
          "Rechazados": "{{oferente_contrato.rechazados}}",
          "Eliminados": "{{oferente_contrato.eliminados}}",
          });
          {% endfor %}
          alasql('SELECT * INTO XLSX("Reporte.xlsx",{headers:true}) FROM ?', [Export]);
      });

      $("#ExportarEliminados").click(function(){
          var Export = [];
          {% for eliminado in eliminados %}
          Export.push({
            "Contrato": "{{eliminado.id_contrato}}",
            "Oferente": "<?php echo str_replace('"','', $eliminado->institucion); ?>",
            "Documento": "{{eliminado.documento}}",
            "Apellidos": "{{eliminado.apellido1}}  {{eliminado.apellido2}} ",
            "Nombres": "{{eliminado.nombre1}}  {{eliminado.nombre2}}",
            "Codigo_dane": "{{eliminado.codigo_dane}}",
            "Sede_simat": "<?php echo str_replace('"', '', $eliminado->sede_simat); ?>",
            "Sede": "<?php echo str_replace('"', '', $eliminado->nombre_sede); ?>",
            "Jornada": "{{eliminado.nombre_jornada}}",
            "Grado": "{{eliminado.grado_cod_simat}}",
            "Grupo": "{{eliminado.grupo_simat}}",
            "Motivo_retiro": "<?php echo str_replace(' ', '', $eliminado->observaciones_retiro); ?>",
            "Fecha_retiro": "{{eliminado.fecha_retiro}}",
            "Acta_Ingreso": "{{eliminado.ingreso}}",
          });
          {% endfor %}
          alasql('SELECT * INTO XLSX("Reporte.xlsx",{headers:true}) FROM ?', [Export]);
      });

      }, 1000);

      setTimeout(function(){
            $(function() {
      
              $.extend($.tablesorter.themes.bootstrap, {
                // these classes are added to the table. To see other table classes available,
                // look here: http://twitter.github.com/bootstrap/base-css.html#tables
                table      : 'table table-bordered',
                caption    : 'caption',
                header     : 'bootstrap-header', // give the header a gradient background
                footerRow  : '',
                footerCells: '',
                icons      : '', // add "icon-white" to make them white; this icon class is added to the <i> in the header
                sortNone   : 'bootstrap-icon-unsorted',
                sortAsc    : 'icon-chevron-up glyphicon glyphicon-chevron-up',     // includes classes for Bootstrap v2 & v3
                sortDesc   : 'icon-chevron-down glyphicon glyphicon-chevron-down', // includes classes for Bootstrap v2 & v3
                active     : '', // applied when column is sorted
                hover      : '', // use custom css here - bootstrap class may not override it
                filterRow  : '', // filter row class
                even       : '', // odd row zebra striping
                odd        : ''  // even row zebra striping
              });
      
              // call the tablesorter plugin and apply the uitheme widget
              $("table").tablesorter({
                // this will apply the bootstrap theme if "uitheme" widget is included
                // the widgetOptions.uitheme is no longer required to be set
                theme : "bootstrap",
      
                widthFixed: true,
                // headers: { 0: { sorter: false, filter:false}}  ,
      
                headerTemplate : '{content} {icon}', // new in v2.7. Needed to add the bootstrap icon!
      
                // widget code contained in the jquery.tablesorter.widgets.js file
                // use the zebra stripe widget if you plan on hiding any rows (filter widget)
                widgets : [ "uitheme", "filter", "zebra" ],
      
                widgetOptions : {
                  // using the default zebra striping class name, so it actually isn't included in the theme variable above
                  // this is ONLY needed for bootstrap theming if you are using the filter widget, because rows are hidden
                  zebra : ["even", "odd"],
      
                  // reset filters button
                  filter_reset : ".reset",
      
                  // set the uitheme widget to use the bootstrap theme class names
                  // this is no longer required, if theme is set
                  // ,uitheme : "bootstrap"
      
                }
              });
      
            });
       }, 1000);
      
  </script>
    