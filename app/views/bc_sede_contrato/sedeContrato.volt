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
    
    <h1>SEDES CONTRATO</h1>
    <br>
    <br>
    <div class="form-group" >
      <button class="btn btn-success" id="ExportarExcel">EXPORTAR REGISTROS</button>
      <a href="/sico_cobertura_regular/bc_sede_contrato/crearSede" class="btn btn-primary">CREAR SEDE</a>
      <div id="contenedo">
        <div class="loader" id="loader"></div>
        <h6 align="center"><b>Cargando información en la tabla, un momento por favor</b></h6>
      </div>
    </div>
    <h4> </h4>
    <h4> </h4>
    <h4></h4>
    <div class="tableFixHead">
    
      <table class="table table-bordered table-hover" id="tabla_beneficiarios">
        <thead>
          <tr>
            <th>Acciones</th>
            <th>Contrato</th>
            <th>Oferente</th>
            <th>Nombre Sede</th>
            <th>Modalidad</th>
            <th>Comuna</th>
            <th>Barrio</th>
            <th>Dirección</th>
            <th>Teléfono</th>
            <th>Cupos</th>
          </tr>
        </thead>
        <tbody>
          {% for sede_contrato in sedes_contratos %}
          <tr>  
            <td>
              {{ link_to("bc_sede_contrato/editarSede/?id_sede_contrato="~sede_contrato.id_sede_contrato,  '<i class="glyphicon glyphicon-pencil"></i> ', "rel": "tooltip", "title":"Editar Sede") }}
              <a style="margin-left:7%;" onclick="abrirModal('{{sede_contrato.id_sede_contrato}}','{{sede_contrato.sede_nombre}}')" rel="tooltip" title="Eliminar Sede" class="eliminar_fila" data-toggle = "modal"><i class="glyphicon glyphicon-trash"></i></a>
            </td>
            <td>{{ sede_contrato.id_contrato }} </td>
            <td>{{ sede_contrato.oferente_nombre }}</td>
            <td>{{ sede_contrato.sede_nombre }}</td>
            <td>{{ sede_contrato.modalidad_nombre }}</td>
            <td>{{ sede_contrato.sede_comuna }}</td>
            <td>{{ sede_contrato.sede_barrio }}</td>
            <td>{{ sede_contrato.sede_direccion }}</td>
            <td>{{ sede_contrato.sede_telefono }}</td>
            <td>{{ sede_contrato.cuposSostenibilidad }}</td>
          </tr>
          {% endfor %}
        </tbody>
      </table>
    </div>
    <div style="justify-content: center; text-align:center;">
      <br>
      <!-- <button class="btn btn-primary" onclick="document.getElementById('beneficiarios_form').submit()">GUARDAR CAMBIOS</button> -->
    </div>
    {# <div class="boton-abrir" id="guardarbeneficiarios" onclick="document.getElementById('beneficiarios_form').submit()">
      <a class="material-icons" title="Guardar Beneficiarios"   style="color:white; text-decoration:none;">save</a>
    </div>
    <div class="boton-exportar" id="ExportarExcel">
      <a class="material-icons" title="Exportar a Excel" style="color:white; text-decoration:none;">arrow_downward</a>
    </div> #}
    </form>
    
    
    
    <!-- Modal Busqueda de beneficiario-->
    <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLongTitle">Consultar Beneficiario Comité</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            {{ form("bc_sede_contrato/crearBeneficiario/", "method":"post", "parsley-validate" : "", "id" : "beneficiarios_form") }}
            {{ hidden_field("activos", "value": beneficiarios_activos) }}
            {{ hidden_field("cuposTotal", "value": cuposTotal) }}
              <div class="form-group">
                <label for="inputPassword4">Documento</label>
                <input type="text" class="form-control" name="documento" placeholder="Documento" required>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary">Consultar</button>
              </div>
           </form>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Modal eliminar sede-->
    <div class="modal fade" id="eliminar_elemento" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">Eliminar Sede</h4>
          </div>
          <div class="modal-body">
            {{ form("bc_sede_contrato/eliminarSede/", "method":"post", "parsley-validate" : "", "id" : "eliminar_form") }}
            <input type="hidden" name="id_sede_contrato" id="id_sede_contrato">
              <div class="form-group">
                <label style="display:inline">Nombre Sede:  </label><p id="nombre_sede" style="display:inline"></p>
              </div>
              <p style="font-size: large;">
                <div class="alert alert-danger">
                  <i class="glyphicon glyphicon-warning-sign"></i> 
                  <strong>Atención:¿Esta seguro de eliminar la sede? </strong>
                  <button type="button"  class="btn btn-primary" onclick="confirmarEliminar()">SI</button>
                  <button type="button"  class="btn btn-default" data-dismiss="modal">No</button>
                </div>
              </p>
          </div>
          <div class="modal-footer">
            <!-- <a class="btn btn-primary" >Eliminar</a> -->
            <button type="submit" style="display: none;" class="btn btn-primary mostrar" id="boton_eliminar">Eliminar Sede</button>
            <button type="button" style="display: none;" class="btn btn-default mostrar" data-dismiss="modal">Cancelar</button>
          </div>
        </form>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    
    
    <script>
    
        function abrirModal(id,sede){
          $("#id_sede_contrato").val(id);
          $("#nombre_sede").text(sede);
          $("#eliminar_elemento").modal("show");
          $(".mostrar").hide();
        }

    
        function confirmarEliminar(){
          $(".mostrar").show();
        }
    
    
        window.onload = function() {
        //funciones a ejecutar
            setTimeout(function(){
            document.getElementById("contenedo").style.display = "none";
            }, 2000);
        };
    
        setTimeout(function(){
        $("#ExportarExcel").click(function(){
          var Export = [];
          {% for sede_contrato in sedes_contratos %}
          Export.push({
            "Contrato": "{{sede_contrato.id_contrato}}",
            "Oferente": "{{sede_contrato.oferente_nombre}} ",
            "Sede": "{{sede_contrato.sede_nombre}} ",
            "Comuna": "{{sede_contrato.sede_comuna}}",
            "Barrio": "{{sede_contrato.sede_barrio}}",
            "Direccion": "{{sede_contrato.sede_direccion}}",
            "Telefono": "{{sede_contrato.sede_telefono}}",
            "Cupos": "{{sede_contrato.cuposSostenibilidad}}",
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
              headers: { 0: { sorter: false, filter:false}}  ,
    
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
    