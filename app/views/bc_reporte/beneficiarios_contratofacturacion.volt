
{{ content() }}
<h1>Base de Datos Niño a Niño Consolidado Final {{ periodo.getFechaAnioDetail() }} <br><small>CONTRATO {{ contrato.id_contrato }} MODALIDAD {{ contrato.BcSedeContrato.modalidad_nombre }}</small></h1>
<div class='col-md-10'>
	{{ link_to("bc_reporte/oferente_periodos/"~contrato.id_contrato, '<i class="glyphicon glyphicon-chevron-left"></i> Regresar', "class": "btn btn-primary menu-tab") }}
	<button class='btn btn-primary' id='ExportarExcel'>Exportar</button>
</div>
<div class="tableFixHead">


	<table class="table table-bordered table-hover">
		<thead>
			<tr>
				<th>Nombre Sede<input autocomplete='off' class='filter form-control input-sm' name='nombre sede' data-col='nombre sede'/></th>
				<th>Nombre Grupo<input autocomplete='off' class='filter form-control input-sm' name='nombre grupo' data-col='nombre grupo'/></th>
				<th>ID Persona<input autocomplete='off' class='filter form-control input-sm' name='id persona' data-col='id persona'/></th>
				<th>Número documento<input autocomplete='off' class='filter form-control input-sm' name='número documento' data-col='número documento'/></th>
				<th>Primer Nombre<input autocomplete='off' class='filter form-control input-sm' name='primer nombre' data-col='primer nombre'/></th>
				<th>Segundo Nombre<input autocomplete='off' class='filter form-control input-sm' name='segundo nombre' data-col='segundo nombre'/></th>
				<th>Primer Apellido<input autocomplete='off' class='filter form-control input-sm' name='primer apellido' data-col='primer apellido'/></th>
				<th>Segundo Apellido<input autocomplete='off' class='filter form-control input-sm' name='segundo apellido' data-col='segundo apellido'/></th>
				<th>Fecha Registro Matrícula<input autocomplete='off' class='filter form-control input-sm' name='fecha registro matricula' data-col='fecha registro matricula'/></th>
				<th>Fecha Registro Beneficiario<input autocomplete='off' class='filter form-control input-sm' name='fecha registro beneficiario' data-col='fecha registro beneficiario'/></th>
				<th>Fecha Retiro<input autocomplete='off' class='filter form-control input-sm' name='fecha retiro' data-col='fecha retiro'/></th>
				<th>Certificación Facturación<input autocomplete='off' class='filter form-control input-sm' name='certificación facturación' data-col='certificación facturación'/></th>
			</tr>
		</thead>
		<tbody>
			{% for beneficiario in beneficiarios %}
			<tr>
				<td>{{ beneficiario.CobActaconteo.sede_nombre }}</td>
				<td>{{ beneficiario.grupo }}</td>
				<td>{{ beneficiario.id_persona }}</td>
				<td>{{ beneficiario.numDocumento }}</td>
				<td>{{ beneficiario.primerNombre }}</td>
				<td>{{ beneficiario.segundoNombre }}</td>
				<td>{{ beneficiario.primerApellido }}</td>
				<td>{{ beneficiario.segundoApellido }}</td>
				<td>{{ beneficiario.fechaRegistro }}</td>
				<td>{{ beneficiario.fechaInicioAtencion }}</td>
				<td>{{ beneficiario.fechaRetiro }}</td>
				<td>{{ beneficiario.getCertificacionFacturacion() }}</td>
			</tr>
			{% endfor %}
		</tbody>
	</table>
</div>
<script>
setTimeout(function(){
	$("#ExportarExcel").click(function(){
		var Export = [];
		{% for beneficiario in beneficiarios %}
		Export.push({
			"Nombre sede": "{{ beneficiario.CobActaconteo.sede_nombre }}",
			"Nombre Grupo": "{{ beneficiario.grupo }}",
			"ID Persona": "{{ beneficiario.id_persona }}",
			"Número documento": "{{ beneficiario.numDocumento }}",
			"Primer Nombre": "{{ beneficiario.primerNombre }}",
			"Segundo Nombre": "{{ beneficiario.segundoNombre }}",
			"Primer Apellido": "{{ beneficiario.primerApellido }}",
			"Segundo Apellido": "{{ beneficiario.segundoApellido }}",
			"Fecha Registro Matricula": "{{ beneficiario.fechaRegistro }}",
			"Fecha Registro Beneficiario": "{{ beneficiario.fechaInicioAtencion }}",
			"Fecha Retiro": "{{ beneficiario.fechaRetiro }}",
			"Certificación Facturación": "{{ beneficiario.getCertificacionFacturacion() }}"
		})
		{% endfor %}
		alasql('SELECT * INTO XLSX("Reporte Niño a Niño de Facturación.xlsx",{headers:true}) FROM ?', [Export]);
	});
}, 1000);

</script>
