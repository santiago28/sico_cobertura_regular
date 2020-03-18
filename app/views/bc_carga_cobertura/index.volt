
{{ content() }}
<h1>Cargas</h1>
{{ link_to("bc_carga_cobertura/nuevo", '<i class="glyphicon glyphicon-plus"></i> Nueva Carga General', "class": "btn btn-primary menu-tab-first") }}
{% if (not(bc_carga is empty)) %}
<table class="table table-bordered table-hover">
    <thead>
    	<tr>
            <th style="text-align:center" colspan="4">CARGAS GENERALES</th>
         </tr>
        <tr>
            <th>Archivo Matr</th>
            <th>Mes</th>
            <th>Fecha</th>
         </tr>
    </thead>
    <tbody>
    {% for bc_carga in bc_carga %}
        <tr>
            <td>{{ link_to("files/bc_bd/"~bc_carga.nombreMat, bc_carga.nombreMat, "target" : "_blank") }}</td>
            <td>{{ bc_carga.mes }}</td>
            <td>{{ bc_carga.fecha }}</td>
        </tr>
    {% endfor %}
    </tbody>
</table>
{% endif %}
