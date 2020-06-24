{{ content() }}

{# <h1>Periodos <br><small>CONTRATO {{ contrato.id_contrato }} MODALIDAD {{ contrato.modalidad_nombre }}</small></h1> #}
{{ link_to("bc_reporte/oferente_contratos", '<i class="glyphicon glyphicon-chevron-left"></i> Regresar', "class": "btn btn-primary menu-tab") }}
<table class="table table-bordered table-hover">
  <thead>
    	 <tr>
            <th>Periodo</th>
            {# <th>Reporte Niño a Niño R1, R2 y R3</th> #}
            <th>Reporte Consolidado de Estudiantes</th>
         </tr>
    </thead>
    <tbody>
      <tr>
         <td>REPORTE SIMAT</td>
         <td>{{ link_to("bc_reporte/beneficiarios_consolidado_simat/", '<i class="glyphicon glyphicon-file"></i> ', "rel": "tooltip", "title":"MAT Consolidada", 'target': '_blank') }}</td>
      </tr>
    {% for periodo in periodos %}
        <tr>
            <td>{{ periodo.CobPeriodo.getFechaDetail() }}</td>
            {# <td>{{ link_to("bc_reporte/beneficiarios_consolidados_periodos/"~periodo.id_periodo, '<i class="glyphicon glyphicon-file"></i> ', "rel": "tooltip", "title":"Reporte R1, R2 y R3", 'target': '_blank') }}</td> #}
            <td>
                {{ link_to("bc_reporte/beneficiarios_periodofacturacion/"~periodo.id_periodo, '<i class="glyphicon glyphicon-file"></i> ', "rel": "tooltip", "title":"Reporte Facturación Consolidado", 'target': '_blank') }}
            </td>
        </tr>
    {% endfor %}
    </tbody>
</table>
