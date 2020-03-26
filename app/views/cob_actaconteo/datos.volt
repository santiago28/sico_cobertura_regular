{{ content() }}
{{ elements.getActamenu(acta) }}
<table class="table table-bordered table-striped">
	<tbody>
		{% if(periodo_tipo != 2) %} <!-- Daniel Gallo 02/03/2017 -->
		<tr>
			<td>1. TOTAL DE BENEFICIARIOS QUE EFECTIVAMENTE ASISTIERON</td>
			<td>{{ asiste1 }}</td>
		</tr>
		<tr>
			<td>2. TOTAL DE BENEFICIARIOS AUSENTES CON EXCUSA VALIDA</td>
			<td>{{ asiste2 }}</td>
		</tr>
		<tr>
			<td>3. TOTAL DE BENEFICIARIOS AUSENTES SIN EXCUSA</td>
			<td>{{ asiste3 }}</td>
		</tr>
		<tr>
			<td>4. TOTAL DE BENEFICIARIOS RETIRADOS</td>
			<td>{{ asiste4 }}</td>
		</tr>
		<tr>
			<td>5. TOTAL DE BENEFICIARIOS CON EVIDENCIA DE ATENCIÓN</td>
			<td>{{ asiste5 }}</td>
		</tr>
		<tr>
			<td><strong>TOTAL LISTADO DE BENEFICIARIOS</strong></td>
			<td>{{ asistetotal }}</td>
		</tr>
		{# <tr>
		<td><strong>TOTAL NIÑOS ADICIONALES INGRESADOS</strong></td>
		<td>{{ asisteadicionales }}</td>
	</tr> #}
	{% else %}
	<tr>
		<td>1.1 ASISTE</td>
		<td>{{ asiste1 }}</td>
	</tr>
	<tr>
		<td>1.2 RETIRADO</td>
		<td>{{ asiste2 }}</td>
	</tr>
	<tr>
		<td>1.3 AUSENTE</td>
		<td>{{ asiste3 }}</td>
	</tr>
	<tr>
		<td>1.4 BENEFICIARIO CON EXCUSA VALIDA</td>
		<td>{{ asiste4 }}</td>
	</tr>
	<tr>
		<td>1.5 LLAMADA TELEFÓNICA PRECERTIFICADA</td>
		<td>{{ asiste5 }}</td>
	</tr>
	<tr>
		<td>1.6 LLAMADA TELEFÓNICA NO CERTIFICADA</td>
		<td>{{ asiste6 }}</td>
	</tr>
	<tr>
		<td>1.7 ENCUENTRO EN CASA</td>
		<td>{{ asiste7 }}</td>
	</tr>
	{% endif %}
</tbody>
</table>
{{ form("cob_actaconteo/guardardatos/"~id_actaconteo, "method":"post", "class":"form-container form-horizontal", "parsley-validate" : "", "id" : "datos_form", "enctype" : "multipart/form-data") }}
<input type="hidden" id="id_actaconteo" value="{{acta.id_actaconteo}}">
<div class="form-group">
	<label class="col-sm-2 control-label" for="fecha">* Fecha Interventoría</label>
	<div class="col-sm-10">
		{{ text_field("fecha", "type" : "date", "class" : "form-control tipo-fecha required", "placeholder" : "dd/mm/aaaa", "parsley-type" : "dateIso", "data-date-format" : "dd/mm/yyyy") }}
	</div>
</div>
<div class="form-group">
	<label class="col-sm-2 control-label" for="horaInicio">* Hora Inicio</label>
	<div class="col-sm-10">
		{{ text_field("horaInicio", "placeholder": "Ej: 08:30 am", "class" : "form-control required") }}
	</div>
</div>
<div class="form-group">
	<label class="col-sm-2 control-label" for="horaFin">* Hora Fin</label>
	<div class="col-sm-10">
		{{ text_field("horaFin", "placeholder": "Ej: 09:00 am", "class" : "form-control required") }}
	</div>
</div>
{% if(periodo_tipo != 2) %}
<div class="form-group">
	<label class="col-sm-2 control-label" for="nombreEncargado">* Nombre Encargado de la Sede</label>
	<div class="col-sm-10">
		{{ text_field("nombreEncargado", "class" : "form-control required") }}
	</div>
</div>
{% else %}
{{ hidden_field("nombreEncargado", "value": "N/A") }}
<div class="form-group">
	<label class="col-sm-2 control-label" for="encuentroSede">* El encuentro se realizó en la sede matriculada</label>
	<div class="col-sm-10">
		{{ select("encuentroSede", sino, "class" : "form-control encuentroSede required") }}
	</div>
</div>
<div id="servicio-item" class="form-group hidden servicio">
	<label class="col-sm-2 control-label" for="nombreSede">* Nombre de la sede donde prestó el servicio</label>
	<div class="col-sm-10">
		{{ text_field("nombreSede", "placeholder" : "Nombre de la sede donde prestó el servicio", "class" : "form-control required hidden servicio", "disabled" : "disabled") }}
	</div>
</div>
<!--<div class="form-group">
<label class="col-sm-2 control-label" for="mosaicoSanitario">* Cuenta con servicio sanitario, lavamanos, energía eléctrica y agua potable</label>
<div class="col-sm-10">
{{ select("mosaicoSanitario", sino, "class" : "form-control required") }}
</div>
</div>
<div class="form-group">
<label class="col-sm-2 control-label" for="mosaicoSeguridad" placeholder="Plan de Ordenamiento Territorial">* Cuenta con condiciones minimas (POT)</label>
<div class="col-sm-10">
{{ select("mosaicoSeguridad", sino, "class" : "form-control required") }}
</div>
</div>-->
<div class="form-group">
	<label class="col-sm-2 control-label" for="mosaicoEncuentro" placeholder="Plan de Ordenamiento Territorial">El encuentro se realizó</label>
	<div class="col-sm-10">
		{{ select("mosaicoEncuentro", tipo_encuentro, "class" : "form-control required") }}
	</div>
</div>
<div class="form-group">
	<label class="col-sm-2 control-label" for="gruposVisitados">* Cantidad de grupos visitados</label>
	<div class="col-sm-10">
		{{ text_field("gruposVisitados", "class" : "form-control required grupos") }}
	</div>
</div>

{% endif %}
{# <div class="form-group">
<label class="col-sm-2 control-label" for="vallaClasificacion">* Valla de Identificación</label>
<div class="col-sm-10">
{{ select("vallaClasificacion", valla_sede, "class" : "form-control required") }}
</div>
</div> #}
<div class="form-group">
	<label class="col-sm-2 control-label" for="correccionDireccion">Corrección Dirección Sede</label>
	<div class="col-sm-10">
		{{ text_field("correccionDireccion", "class" : "form-control") }}
	</div>
</div>
{% if(periodo_tipo != 2) %}
{# <div class="form-group">
<label class="col-sm-2 control-label" for="mosaicoFisico">* Cuenta con Registro Fotográfico Físico</label>
<div class="col-sm-10">
{{ select("mosaicoFisico", sino, "class" : "form-control required	") }}
</div>
</div> #}
{# <div class="form-group">
<label class="col-sm-2 control-label" for="mosaicoDigital">* Cuenta con Registro Fotográfico Digital</label>
<div class="col-sm-10">
{{ select("mosaicoDigital", sino, "class" : "form-control required") }}
</div>
</div> #}
{% endif %}
<div class="form-group">
	<label class="col-sm-2 control-label" for="observacionUsuario">Observación Interventor</label>
	<div class="col-sm-10">
		{{ text_area("observacionUsuario", "rows" : "4", "class" : "form-control") }}
	</div>
</div>
<div class="form-group">
	<label class="col-sm-2 control-label" for="observacionEncargado">Observación Encargado Sede</label>
	<div class="col-sm-10">
		{{ text_area("observacionEncargado", "rows" : "4", "class" : "form-control") }}
	</div>
</div>
<div class="form-group">
	<label class="col-sm-2 control-label" for="cargarDocumento">Evidencia de Atención</label>
	<div class="col-sm-10">
		<input class="fileupload filestyle" data-input="false" data-badge="false" type="file" name="evidencia" multiple>
		<div id="progress" class="progress" style="margin: 0 !important;">
			<div class="progress-bar progress-bar-success"></div>
		</div>
		<p><a class="captura" target="_blank" href="/sico_cobertura_regular/files/excusas/{{ urlEvidenciaAtencion }}">{% if urlEvidenciaAtencion %}Clic para ver{% endif %}</a></p>
		<input type='hidden' class='urlEvidenciaAtencion' name='urlEvidenciaAtencion' value="{{urlEvidenciaAtencion}}">
	</div>
</div>
{% if acta.id_modalidad == 12 %}
<div class="form-group">
	<label class="col-sm-2 control-label" for="estadoVisita">* Estado de la visita</label>
	<div class="col-sm-10">
		{{ select("estadoVisita", estadoVisita, "class" : "form-control required") }}
	</div>
</div>
<div class="form-group">
	<label class="col-sm-2 control-label" for="numeroEncuentos">* Número de Encuentros</label>
	<div class="col-sm-10">
		{{ select("numeroEncuentos", numeroEncuentos, "class" : "form-control required") }}
	</div>
</div>
<div class="form-group">
	<label class="col-sm-2 control-label" for="gestionTelefonica">Gestión Telefonica</label>
	<div class="col-sm-10">
		{{ text_area("gestionTelefonica", "rows" : "4", "class" : "form-control") }}
	</div>
</div>
{% endif %}
<div class="form-group">
	<div class="col-sm-offset-2 col-sm-10">
		{{ submit_button("Guardar", "class" : "btn btn-default") }}
	</div>
</div>
</form>
<script>
setTimeout(function(){
	$(document).ready(function(){
		$("#fecha").datepicker({
			language: 'es',
			autoclose: true,
		});
		document.getElementsByClassName("grupos")[0].setAttribute("type", "number");
	});
},1000);
</script>
