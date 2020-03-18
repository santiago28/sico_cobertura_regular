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
</style>
<div class="tableFixHead">


  {{ form("bc_sede_contrato/guardarbeneficiarios/"~id_contrato, "method":"post", "parsley-validate" : "", "id" : "beneficiarios_form") }}
  {{ hidden_field("id_contrato", "value": id_contrato) }}

  <table class="table table-bordered table-hover" id="tabla_beneficiarios">
    <thead>
      <tr>
        <th>#</th>
        <th>Documento</th>
        <th style="width: 150px;">Nombre</th>
        <th style="width: 150px;">Sede</th>
        <th >Jornada</th>
        <th>Grados</th>
        <th>Grupo</th>
        <th style="width: 90px;">¿Está matriculado en el SIMAT?</th>
        <th style="width: 90px;">¿Está retirado?</th>
        <th style="width: 90px;">Ingreso</th>
      </tr>
    </thead>
    <tbody>
      {% for beneficiario in beneficiarios %}
      <tr <?php echo $beneficiario->getAsistenciaDetail(); ?>>
        <td>{{ loop.index }}</td>
        <td><input type="hidden" name="id_oferente_persona[]" value="{{ beneficiario.id_oferente_persona }}">{{ beneficiario.numDocumento }}</td>
        <td>{{ beneficiario.nombreCompleto }}</td>
        <td>{{ select("id_sede[]", sedes, "value" : beneficiario.id_sede, "class" : "form-control") }}
        </td>
        <td>
          {# {{beneficiario.BcSedeContrato.sede_nombre}} #}
          {{ select("jornada[]", jornada, "value" : beneficiario.jornada, "class" : "form-control") }}
        </td>
        <td>
          {{ select("grado[]", grados, "value" : beneficiario.grado, "class" : "form-control") }}
        </td>
        <td>
          {{ select("grupo[]", grupos, "value" : beneficiario.grupo, "class" : "form-control") }}
        </td>
        <td>
          {{ select("matriculadoSimat[]", sino, "value" : beneficiario.matriculadoSimat, "class" : "form-control") }}
        </td>
        <td>
          {{ select("retirado[]", sino, "value" : beneficiario.retirado, "class" : "form-control") }}
        </td>
        <td>{{ beneficiario.ingreso }}</td>
      </tr>
      {% endfor %}
    </tbody>
  </table>
</div>
<div style="justify-content: center; text-align:center;">
  <br>
  <button class="btn btn-primary" onclick="document.getElementById('beneficiarios_form').submit()">GUARDAR CAMBIOS</button>
  <button class="btn btn-success" id="ExportarExcel">EXPORTAR REGISTROS</button>
</div>
{# <div class="boton-abrir" id="guardarbeneficiarios" onclick="document.getElementById('beneficiarios_form').submit()">
  <a class="material-icons" title="Guardar Beneficiarios"   style="color:white; text-decoration:none;">save</a>
</div>
<div class="boton-exportar" id="ExportarExcel">
  <a class="material-icons" title="Exportar a Excel" style="color:white; text-decoration:none;">arrow_downward</a>
</div> #}
</form>

<script>

setTimeout(function(){
  $("#ExportarExcel").click(function(){
    var Export = [];
    {% for beneficiario in beneficiarios %}
    var matriculado = "{{beneficiario.matriculadoSimat}}";
    var retirado = "{{beneficiario.retirado}}";
    Export.push({
      "Documento": "{{beneficiario.numDocumento}}",
      "Nombre": "{{beneficiario.nombreCompleto}}",
      "Sede": "{{beneficiario.BcSedeContrato.sede_nombre}}",
      "Jornada": "{{beneficiario.jornada}}",
      "Grado": "{{beneficiario.grado}}",
      "Grupo": "{{beneficiario.grupo}}",
      "Matriculado al SIMAT": matriculado=="1"?"SI":"NO",
      "Retirado": retirado=="1"?"SI":"NO",
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
      headers: { 3: { sorter: false, filter:false} , 4: { sorter: false, filter:false}, 5: { sorter: false, filter:false}, 6: { sorter: false, filter:false}, 7: { sorter: false, filter:false}, 8: { sorter: false, filter:false}}  ,

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
