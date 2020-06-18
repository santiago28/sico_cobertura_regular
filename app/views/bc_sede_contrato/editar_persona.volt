{{ content() }}
<h1>Editar Estudiante</h1>
<br>
<br>
<!-- <form style="margin-top: 4%;" action="bc_sede_contrato/guardar_update_beneficiario" method="POST" > -->
{{ form("bc_sede_contrato/guardar_update_beneficiario/", "method":"post", "parsley-validate" : "", "id" : "beneficiarios_form") }}
    {{ hidden_field("id_oferente_persona", "value": beneficiario.id_oferente_persona) }}
    {{ hidden_field("nombre_jornada", "value": beneficiario.nombre_jornada) }}
    <div class="form-row">
      <div class="form-group col-md-4">
        <label for="inputEmail4">Tipo Documento</label>
        {{ select("tipo_documento", tipo_documento, "value" : beneficiario.tipo_documento, "class" : "form-control", "required":"required") }}
      </div>
      <div class="form-group col-md-4">
        <label for="inputPassword4">Documento</label>
        <input type="text" class="form-control" style="text-transform: uppercase;" name="documento" placeholder="Documento" value="{{beneficiario.documento}}" readonly>
      </div>
      <div class="form-group col-md-4">
        <label for="inputPassword4">Primer Nombre</label>
        <input type="text" class="form-control"style="text-transform: uppercase;" name="nombre1" placeholder="Primer Nombre" value="{{beneficiario.nombre1}}" required >
      </div>
    </div>  
    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputPassword4">Segundo Nombre</label>
            <input type="text" class="form-control" name="nombre2" style="text-transform: uppercase;" placeholder="Segundo Nombre" value="{{beneficiario.nombre2}}">
        </div>
        <div class="form-group col-md-4">
            <label for="inputPassword4">Primer Apellido</label>
            <input type="text" class="form-control" name="apellido1" style="text-transform: uppercase;" placeholder="Primer Apelllido" value="{{beneficiario.apellido1}}" required>
        </div>
        <div class="form-group col-md-4">
            <label for="inputPassword4">Segundo Apellido</label>
            <input type="text" class="form-control" name="apellido2" style="text-transform: uppercase;" placeholder="Segundo Apellido" value="{{beneficiario.apellido2}}">
        </div>
    </div>  
      <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputEmail4">Sede</label>
            {{ select("id_sede", sedes, "value" : beneficiario.id_sede, "class" : "form-control") }}
        </div>
        <div class="form-group col-md-4">
            <label for="inputEmail4">Jornada</label>
            {{ select("id_jornada", jornada, "value" : beneficiario.id_jornada, "class" : "form-control", "onchange":"obtener_jornada()", "required":"required") }}
        </div>
        <div class="form-group col-md-4">
            <label for="inputEmail4">Grado</label>
            {{ select("grado_cod_simat", grados_simat, "value" : beneficiario.grado_cod_simat, "class" : "form-control", "required":"required") }}
        </div>
      </div>  
      <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputEmail4">Grupo</label>
            {{ select("grupo_simat", grupos_simat, "value" : grupo, "class" : "form-control", "required":"required") }}
        </div>
        <div class="form-group col-md-4">
            <label for="inputEmail4">Código Dane</label>
            <input type="text" class="form-control" name="codigo_dane" placeholder="Código Dane" value="{{beneficiario.codigo_dane}}" readonly required>
        </div>
    
        <button type="submit" style="margin-top: 2%;" class="btn btn-primary">GUARDAR</button>
      </div> 
      <!-- <div class="form-row">
        <div class="form-group col-md-12">
            <label for="inputEmail4">Observaciones</label>
            <textarea class="form-control" name="observaciones"  rows="3"></textarea>
        </div>
      </div>  -->
    
  </form>
  <script>
      function obtener_jornada(){
        $("#nombre_jornada").val($('select[name="id_jornada"] option:selected').text());
      }

      window.onload = function() {
        $("#nombre_jornada").val($('select[name="id_jornada"] option:selected').text());
      }
  </script>