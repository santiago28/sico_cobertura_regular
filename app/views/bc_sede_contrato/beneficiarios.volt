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

<div class="form-group" >
  <h4 align="center" style="margin:2%;"><span><b>{{oferente}}</b></span></h4>
  <h5 align="center" style="margin:2%;"><span><b>CONTRATO: {{id_contrato}} MODALIDAD:</b> {{modalidad[0].nombre}}</span></h5>
  <div class="alert alert-info" role="alert" style="justify-content: center; text-align:center;">
    <span><b>Total Cupos Matriculados: </b> {{total_beneficiarios}}</span>
    <span style="margin-left: 2%;"><b>Total Beneficiarios Activos: </b>{{beneficiarios_activos}}</span>
    <span style="margin-left: 2%;"><b>Total Beneficiarios Retirados:</b> {{beneficiarios_retirado}}</span>
    <span style="margin-left: 2%;"><b>Cobertura:</b> {{porcentaje_cobertura}}%</span>
    <span style="margin-left: 2%;"><b>Total Beneficiarios Contrato:</b> {{cuposTotal}}</span>
  </div>
  <button class="btn btn-success" id="ExportarExcel">EXPORTAR REGISTROS</button>
  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
    Crear Beneficiario
  </button>
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
        <th>Editar</th>
        <th>Documento</th>
        <th>Nombres</th>
        <th>C. Dane</th>
        <th>Sede Simat</th>
        <th>Sede</th>
        <th>Jornada</th>
        <th>Grado</th>
        <th>Grupo</th>
        <th>Matriculado Simat</th>
        <th>Comité</th>
      </tr>
    </thead>
    <tbody>
      {% for beneficiario in beneficiarios %}
      <tr >
        <td>{{ link_to("bc_sede_contrato/editar_persona/?id_persona="~beneficiario.id_oferente_persona,  "Editar", "class": "btn btn-default") }}</td>
        <td>{{ beneficiario.documento }}</td>
        <td>{{ beneficiario.apellido1 }} {{ beneficiario.apellido2 }} {{ beneficiario.nombre1 }} {{ beneficiario.nombre2 }}</td>
        <td>{{ beneficiario.codigo_dane }}</td>
        <td>{{ beneficiario.sede_simat }}</td>
        <td>{{ beneficiario.nombre_sede }}</td>
        <td>{{ beneficiario.nombre_jornada }}</td>
        <td>{{ beneficiario.grado_cod_simat }}</td>
        <td>{{ beneficiario.grupo_simat }}</td>
        <td>{{ beneficiario.matricula_simat }}</td>
        <td>{{ beneficiario.ingreso }}</td>
       
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



<!-- Modal -->
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


<script>


window.onload = function() {
  //funciones a ejecutar
  setTimeout(function(){
    document.getElementById("contenedo").style.display = "none";
  }, 2000);
};
setTimeout(function(){
  $("#ExportarExcel").click(function(){
    var Export = [];
    {% for beneficiario in beneficiarios %}
    Export.push({
      "Documento": "{{beneficiario.documento}}",
      "Apellidos": "{{beneficiario.apellido1}}  {{beneficiario.apellido2}} ",
      "Nombres": "{{beneficiario.nombre1}}  {{beneficiario.nombre2}}",
      "Codigo_dane": "{{beneficiario.codigo_dane}}",
      "Sede_simat": "{{beneficiario.sede_simat}}",
      "Sede": "{{beneficiario.nombre_sede}}",
      "Jornada": "{{beneficiario.nombre_jornada}}",
      "Grado": "{{beneficiario.grado_cod_simat}}",
      "Grupo": "{{beneficiario.grupo_simat}}",
      "Grado": "{{beneficiario.matricula_simat}}",
      "Acta_Ingreso": "{{beneficiario.ingreso}}",
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
