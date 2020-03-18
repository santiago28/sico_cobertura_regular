
{{ content() }}
<h1>Permisos - {{ titulo }}</h1>
<div class="form-inline">
	<div class="btn-group">
		{{ btn_anio }}
		{{ btn_mes }}
		{{ btn_semana }}
		{{ btn_dia }}
	</div>
	<div class="btn-group">
		{{ btn_anterior }}
		<a class="btn btn-default" data-calendar-nav="today">{{ titulo }}</a>
		{{ btn_siguiente }}
	</div>
	<div class="input-group">
    <input name="buscar" type="text" class="form-control buscar-permiso-input" placeholder="Buscar por ID...">
    <span class="input-group-btn">
      <a class="btn btn-primary buscar-permiso-btn" type="button"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> Buscar</a>
    </span>
  </div><!-- /input-group -->
</div>
<div class="form-inline" style="padding-top: 5px">
	{{ link_to("bc_permiso/nuevo", '<i class="glyphicon glyphicon-plus"></i> Nuevo Permiso', "class": "btn btn-primary menu-tab-first") }}
</div>
{% if (not(permisos is empty)) %}
<!-- Modal -->
<div class="modal fade" id="eliminar_elemento" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Anulando Permiso ID <span class="fila_eliminar"></span></h4>
      </div>
      <div class="modal-body">
      {{ form("bc_permiso/anular/", "method":"post", "class":"", "id":"anular_permiso", "parsley-validate" : "") }}
          <p>Escribe el motivo por el cual vas a anular el permiso ID <span class="fila_eliminar"></span>:</p>
          <p>{{ text_area("observacion", "maxlength" : "150", "parsley-maxlength" : "150", "rows" : "4", "class" : "form-control required") }}</p>
          <input type="hidden" name="id_permiso" class="id_elemento">
      </div>
      <div class="modal-footer">
        {{ submit_button("Anular", "class" : "btn btn-primary") }}
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
        </form>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<table class="table table-bordered table-hover" id="permisos_lista">
    <thead>
        <tr>
            <th>ID Permiso</th>
            <th filter-type='ddl'>Estado</th>
            <th filter-type='ddl'>Categoría</th>
            <th>Contrato-Modalidad</th>
            <th>ID-Sede</th>
            <th>Título</th>
            <th>Fecha</th>
            <th>Horas</th>
         </tr>
    </thead>
    <thead>
    	<tr><th style="margin: 0; padding: 0; border: 0" colspan="9"><a id='cleanfilters' class='btn btn-primary btn-sm btn-block'>Limpiar Filtros</a></th></tr>
    </thead>
    <tbody>
    <?php
    $fecha_limite = strtotime(date('Y-m-d'). ' +1 days');
    ?>
    {% for permiso in permisos %}
        <tr data-estado="{{ permiso.estado }}" class="bg-{{ permiso.getEstadoStyle() }}">
            <td><a rel="tooltip" title="Ver Detalles del Permiso" href="{{ url("bc_permiso/permiso/"~permiso.id_permiso) }}"><?php if (strtotime($permiso->fecha) > $fecha_limite && $permiso->estado < 3){ ?><a href="#eliminar_elemento" rel="tooltip" title="Anular" class="eliminar_fila" data-id = "{{ permiso.id_permiso }}" data-toggle = "modal" id="{{ url("bc_permiso/eliminar/"~permiso.id_permiso) }}"><i class="glyphicon glyphicon-remove"></i></a> <?php } ?>{{ permiso.id_permiso }}</a></td>
            <td><a rel="tooltip" title="Ver Detalles del Permiso" href="{{ url("bc_permiso/permiso/"~permiso.id_permiso) }}">{{ permiso.getEstado() }}</a></td>
            <td>{{ permiso.getCategoria() }}</td>
            <td>{{ permiso.BcSedeContrato.id_contrato }} - {{ permiso.BcSedeContrato.modalidad_nombre }}</td>
            <td>{{ permiso.BcSedeContrato.id_sede }} - {{ permiso.BcSedeContrato.sede_nombre }}</td>
            <td>{{ permiso.titulo }}</td>
            <td><?php echo $this->conversiones->fecha(4, $permiso->fecha); ?></td>
            <td><?php echo $this->conversiones->hora2(1, $permiso->horaInicio); ?> - <?php echo $this->conversiones->hora2(1, $permiso->horaFin); ?></td>
        </tr>
    {% endfor %}
    </tbody>
</table>
{% endif %}
