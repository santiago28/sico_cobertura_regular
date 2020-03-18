{{ content() }}
<h1>Nueva Sede</h1>
{{ link_to("bc_sede_contrato/", '<i class="glyphicon glyphicon-chevron-left"></i> Regresar', "class": "btn btn-primary menu-tab") }}
{{ form("bc_sede_contrato/crear", "method":"post", "class":"form-container form-horizontal", "parsley-validate" : "", "enctype" : "multipart/form-data") }}
{% if (nivel <= 1 or (sedes_contrato.id_contrato == usuario)) %}
<div class="form-group">
    <label class="col-sm-2 control-label" for="mes">Contratos</label>
    <div class="col-sm-10">
      {{ select("id_contrato", contratos, "class" : "form-control") }}
    </div>
</div>
{% endif %}
<div class="form-group">
  <label class="col-sm-2 control-label" for="mes">Nombre Sede</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" name="sede_nombre">
  </div>
</div>
<div class="form-group">
  <label class="col-sm-2 control-label" for="mes">Comuna Sede</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" name="sede_comuna">
  </div>
</div>
<div class="form-group">
  <label class="col-sm-2 control-label" for="mes">Barrio Sede</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" name="sede_barrio">
  </div>
</div>
<div class="form-group">
  <label class="col-sm-2 control-label" for="mes">Dirección Sede</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" name="sede_direccion">
  </div>
</div>
<div class="form-group">
  <label class="col-sm-2 control-label" for="mes">Teléfono Sede</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" name="sede_telefono">
  </div>
</div>
<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    {{ submit_button("Guardar", "class" : "btn btn-default") }}
  </div>
</div>
</form>
