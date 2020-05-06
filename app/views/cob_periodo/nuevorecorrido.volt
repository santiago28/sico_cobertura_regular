
{{ content() }}
<h1>Generando Recorrido {{ recorrido }}</h1>
<h2>Fecha de corte: {{ fecha_corte }}</h2>
{{ link_to("cob_periodo/index", '<i class="glyphicon glyphicon-chevron-left"></i> Regresar', "class": "btn btn-primary menu-tab") }}
{{ form("cob_periodo/generarrecorrido/"~id_periodo, "method":"post", "class":"form-container form-horizontal", "parsley-validate" : "") }}
<div class="form-group">
  <label class="col-sm-2 control-label" for="carga">Carga</label>
  <div class="col-sm-10">
    <select id="carga" name="carga" class="form-control">
      {% for carga in cargas %}
      <option value="{{ carga.id_carga }}">{{ carga.mes }} {{ carga.fecha }} {{ carga.nombreMat }}</option>
      {% endfor  %}
    </select>
  </div>
</div>
<div class="form-group">
  <label class="col-sm-2 control-label" for="carga">Recorrido Virtual</label>
  <div class="col-sm-10">
    <select name="recorrido_virtual" class="form-control">
      <option value="2">No</option>
      <option value="1">Sí</option>
    </select>
  </div>
</div>
<div class="form-group">
  <label class="col-sm-2 control-label" for="modalidad">¿Base de datos de Facturación?</label>
  <div class="col-sm-10">
    <select id="facturacion" name="facturacion" class="form-control">
      <option value="2">No</option>
      <option value="1">Sí</option>
    </select>
  </div>
</div>
<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    {{ submit_button("Generar", "class" : "btn btn-default") }}
  </div>
</div>
</form>
