
{{ content() }}
<h1>Asignar Ajustes a fechas de Reporte</h1>
{{ link_to("cob_ajuste/", '<i class="glyphicon glyphicon-chevron-left"></i> Regresar', "class": "btn btn-primary menu-tab") }}
{% if (not(ajustes is empty)) %}
<table class="table table-bordered table-hover">
    <thead>
        <tr>
        	<th>#</th>
            <th>Periodo</th>
            <th>Contrato</th>
            <th>Documento</th>
            <th>Oficio</th>
            <th>Nombre</th>
            <th>Certificar</th>
            <th>Observacion</th>
            <th>Fecha</th>
            <th>Usuario</th>
            <th>Fecha Reporte</th>
         </tr>
    </thead>
    <tbody>
    {{ form("cob_ajuste/guardarasignarperiodo/", "method":"post", "parsley-validate" : "", "id" : "ajustes_form") }}
    {% for cob_ajuste in ajustes %}
    	{% set nombre = {cob_ajuste.CobActaconteoPersonaFacturacion.primerNombre, cob_ajuste.CobActaconteoPersonaFacturacion.segundoNombre, cob_ajuste.CobActaconteoPersonaFacturacion.primerApellido, cob_ajuste.CobActaconteoPersonaFacturacion.segundoApellido} %}
        <tr>
        <td>{{ loop.index }}</td>
		<td><?php echo $this->conversiones->fecha(5, $cob_ajuste->CobPeriodo->fecha); ?></td>
        <td>{{ cob_ajuste.CobActaconteoPersonaFacturacion.id_contrato }}</td>
        <td>{{ cob_ajuste.CobActaconteoPersonaFacturacion.numDocumento }}</td>
        <td>{{ cob_ajuste.radicado }}</td>
        <td>{{ nombre|join(' ') }}</td>
        <td>{{ cob_ajuste.getCertificarDetail() }}</td>
        <td>{{ cob_ajuste.observacion }}</td>
        <td>{{ cob_ajuste.datetime }}</td>
        <td>{{ cob_ajuste.IbcUsuario.usuario }}</td>
        <td><select style="width: 122px;" name="fecha_ajuste_reportado[]" class="form-control required"><option value="{{ cob_ajuste.CobPeriodo.fecha }}">{{ cob_ajuste.CobPeriodo.getFechaDetail() }}</option></select><input type="hidden" name="id_ajuste[]" value="{{ cob_ajuste.id_ajuste }}"><input type="hidden" name="ajusteDentroPeriodo[]" value="1"><input type="hidden" name="id_actaconteo_persona_facturacion[]" value="{{ cob_ajuste.id_actaconteo_persona_facturacion }}"><input type="hidden" name="asistenciaFinalFacturacion[]" value="{{ cob_ajuste.getAsistenciaFinalFacturacion() }}"><input type="hidden" name="certificacionFacturacion[]" value="{{ cob_ajuste.certificar }}"></td>
        </tr>
    {% endfor %}
    </tbody>
</table>
{{ submit_button("Guardar", "class" : "btn btn-default pull-right") }}
</form>
{% endif %}