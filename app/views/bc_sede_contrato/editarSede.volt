{{ content() }}

<h1>Editar Sede</h1>

<br>
<br>
<br>
{{ form("bc_sede_contrato/guardarEdicionSede/", "method":"post", "parsley-validate" : "", "id" : "beneficiarios_form") }}
{{ hidden_field("id_sede_contrato", "value": sedeContrato.id_sede_contrato) }}
{{ hidden_field("oferente_nombre") }}
{{ hidden_field("modalidad_nombre") }}

    <!-- fila 1 -->
    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="">Oferente *</label>
            <select class="form-control" onchange="obtener_nombres(1)" name="id_oferente" id="id_oferente" required>
                <option value="">Seleccione una opción</option>
                <option value="{{sedeContrato.id_oferente}}" selected>{{sedeContrato.oferente_nombre}}</option>
                {% for oferente in oferentes %}
                  {% if(oferente.id_oferente != sedeContrato.id_oferente) %}
                    <option value="{{oferente.id_oferente}}">{{oferente.oferente_nombre}}</option>
                  {% endif %}
                {% endfor %}
            </select>
        </div>
        <div class="form-group col-md-4">
            <label for="">Contrato *</label>
            <select class="form-control" name="id_contrato" required>
                <option value="{{sedeContrato.id_contrato}}" selected>{{sedeContrato.id_contrato}}</option>
            </select>
        </div>
        <div class="form-group col-md-4">
            <label for="">Nombre Sede *</label>
            <input
                type="text"
                class="form-control"
                name="sede_nombre"
                placeholder="Nombre Sede"
                style="text-transform: uppercase;"
                maxlength="80"
                value="{{sedeContrato.sede_nombre}}"
                required>
            </input>
        </div>
    </div>

   <!-- fila 2 -->
   <div class="form-row">
        <div class="form-group col-md-4">
            <label for="">Barrio Sede *</label>
            <input
                type="text"
                class="form-control"
                name="sede_barrio"
                placeholder="Barrio Sede"
                style="text-transform: uppercase;"
                maxlength="80"
                value="{{sedeContrato.sede_barrio}}"
                required>
            </input>
        </div>
        <div class="form-group col-md-4">
            <label for="inputPassword4">Comuna Sede *</label>
            <input
                type="text"
                class="form-control"
                name="sede_comuna"
                placeholder="Comuna Sede"
                style="text-transform: uppercase;"
                maxlength="80"
                value="{{sedeContrato.sede_comuna}}"
                required>
            </input>
        </div>
        <div class="form-group col-md-4">
            <label for="inputPassword4">Dirección Sede *</label>
            <input
                type="text"
                class="form-control"
                name="sede_direccion"
                placeholder="Dirección Sede"
                style="text-transform: uppercase;"
                maxlength="80"
                value="{{sedeContrato.sede_direccion}}"
                required>
            </input>
        </div>
   </div>

    <!-- fila 3 -->
    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputPassword4">Teléfono Sede *</label>
            <input
                type="number"
                class="form-control"
                name="sede_telefono"
                placeholder="Teléfono Sede"
                style="text-transform: uppercase;"
                maxlength="80"
                value="{{sedeContrato.sede_telefono}}"
                required>
            </input>
        </div>

        <div class="form-group col-md-4">
            <label for="">Número de cupos*</label>
            <input
                type="number"
                class="form-control"
                name="cuposSostenibilidad"
                placeholder="Número de cupos"
                style="text-transform: uppercase;"
                value="{{sedeContrato.cuposSostenibilidad}}"
                required>
            </input>
        </div>
    </div>
    <div  class="form-group">
        <button type="submit" class="btn btn-primary"  style="margin-top: 2%;">GUARDAR</button>
    </div>
</form>

<script>

    window.onload = function(){
        $("#oferente_nombre").val($('select[name="id_oferente"] option:selected').text());
        $("#modalidad_nombre").val($('select[name="id_modalidad"] option:selected').text());
    }

    function obtener_nombres(opc){
        if(opc == 1){
            $("#oferente_nombre").val($('select[name="id_oferente"] option:selected').text());
            var url = window.location.protocol + "//" + window.location.host + "/sico_cobertura_regular/" + "bc_sede_contrato/consultarContratos?valor_busqueda=" + $("#id_oferente").val();
                $.ajax({
                    url: url,
                    type: 'GET',
                    dataType: 'json',
                    success: function (data) {
                        var lista_contratos = "<option value=''>Seleccione una opción</option>";
                        var anterior= "";
                        $.each(data, function(index, value){
                            if(anterior != value.id_contrato){
                                lista_contratos += "<option value='"+value.id_contrato+"'>"+value.id_contrato+"</option>";
                            }
                              anterior = value.id_contrato;
                        });
                        $("select[name*='id_contrato']").html(lista_contratos);
                    }
                 });
        }else{
            // $("#modalidad_nombre").val($('select[name="id_modalidad"] option:selected').text());
        }

    }

</script>
