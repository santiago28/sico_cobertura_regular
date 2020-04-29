
{{ content() }}
<h1>Nueva Carga Comité</h1>
{{ link_to("bc_carga_cobertura/", '<i class="glyphicon glyphicon-chevron-left"></i> Regresar', "class": "btn btn-primary menu-tab") }}
{{ form("bc_carga_cobertura/crear", "method":"post", "class":"form-container form-horizontal", "parsley-validate" : "", "enctype" : "multipart/form-data") }}
<div class="form-group">
  <label class="col-sm-2 control-label" for="mes">Mes</label>
  <div class="col-sm-10">
    {{ select("mes", meses, "class" : "form-control") }}
  </div>
</div>
<!-- <div class="form-group">
  <label class="col-sm-2 control-label" for="modalidad">Modalidad</label>
  <div class="col-sm-10">
    <select class="form-control" name="id_modalidad">
      <option value="1">Confesiones</option>
      <option value="2">Adultos</option>
      <option value="3">Banco Oferentes</option>
      <option value="4">Otras Poblaciones</option>
    </select>
  </div>
</div> -->
<div class="form-group">
  <label class="col-sm-2 control-label">Archivo Comité semanal</label>
  <div class="col-sm-10">
    <input type="file" class="form-control" name="files[]" multiple>
  </div>
</div>
<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    {{ submit_button("Guardar", "class" : "btn btn-default") }}
  </div>
</div>
</form>
<br>

{{ form("bc_carga_cobertura/beneficiarios", "method":"get", "class":"form-container form-horizontal", "parsley-validate" : "", "enctype" : "multipart/form-data") }}
  <div class="form-group">
    <label class="col-sm-2 control-label" for="mes">Número Contrato o Número documento</label>
    <div class="col-sm-10">
        {{ text_field("valor_busqueda", "type" : "text", "class" : "form-control", "placeholder" : "Número contrato o Número documento") }}
    </div>
  </div> 
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      {{ submit_button("Consultar", "class" : "btn btn-default") }}
    </div>
  </div>
</form>
