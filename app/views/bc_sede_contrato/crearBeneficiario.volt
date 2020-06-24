{{ content() }}

<h1>Pre-Matricular Estudiante</h1>

<br>
<br>
<!-- <form style="margin-top: 4%;" action="bc_sede_contrato/guardar_update_beneficiario" method="POST" > -->
{{ form("bc_sede_contrato/guardar_beneficiario/", "method":"post", "parsley-validate" : "", "id" : "beneficiarios_form") }}
{{ hidden_field("id_contrato", "value": id_contrato) }}
{{ hidden_field("ingreso", "value": beneficiario.proviene) }}
{{ hidden_field("nombre_jornada") }}

    <!-- fila 1 -->

    <div class="form-row">
        <div class="form-group col-md-8">
            <label for="">Institución *</label>
            <input
                type="text"
                class="form-control"
                name="institucion"
                placeholder="Institución"
                value="{{oferente.oferente_nombre}}"
                required
                readonly>
            </input>
        </div>

        <div class="form-group col-md-4">
            <label for="">Código Dane *</label>
            <input
                type="number"
                class="form-control"
                name="codigo_dane"
                placeholder="Código Dane"
                required>
            </input>
        </div>
    </div>

    <!-- fila 2 -->

    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputEmail4">ETC</label>

            <input
                type="text"
                class="form-control"
                name="etc"
                placeholder="Etc"
                value="MEDELLÍN" 
                readonly>
            </input>
        </div>

        <!-- <div class="form-group col-md-4">
            <label for="">Estado Matricula *</label>

            {{ select("estado", estado_simat, "class" : "form-control", "required":"required") }}
        </div> -->

        <div class="form-group col-md-4">
            <label for="">Jerarquía *</label>

            {{ select("jerarquia", jerarquia, "class" : "form-control", "required":"required") }}
        </div>
    </div>

    <!-- fila 3 -->

    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="">Calendario Estudiantil *</label>
            {{ select("calendario", calendario, "class" : "form-control", "required":"required") }}
        </div>

        <div class="form-group col-md-4">
            <label for="">Sector *</label>
            {{ select("sector", sector, "class" : "form-control", "required":"required") }}
        </div>

        <div class="form-group col-md-4">
            <label for="">Prestación de Servicio *</label>
            {{ select("prestacion_servicio", prestacion_servicio, "class" : "form-control", "required":"required") }}
        </div>
    </div>

    <!-- fila 4 -->

    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputEmail4">Tipo Documento *</label>
            {{ select("tipo_documento", tipo_documento, "class" : "form-control", "required":"required") }}
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">Documento *</label>
            <input
                type="text"
                class="form-control"
                name="documento"
                placeholder="Documento"
                value="{{beneficiario.documento_identidad}}"
                id="documento"
                required
                readonly>
            </input>
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">Primer Nombre *</label>
            <input
                type="text"
                class="form-control"
                name="nombre1"
                placeholder="Primer Nombre"
                value="{{beneficiario.primer_nombre}}"
                style="text-transform: uppercase;"
                required>
            </input>
        </div>
    </div>

    <!-- fila 5 -->
    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputPassword4">Segundo Nombre</label>
            <input
                type="text"
                class="form-control"
                name="nombre2"
                placeholder="Segundo Nombre"
                style="text-transform: uppercase;"
                value="{{beneficiario.segundo_nombre}}">
            </input>
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">Primer Apellido *</label>
            <input
                type="text"
                class="form-control"
                name="apellido1"
                placeholder="Primer Apelllido"
                style="text-transform: uppercase;"
                value="{{beneficiario.primer_apellido}}"
                required>
            </input>
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">Segundo Apellido</label>
            <input
                type="text"
                class="form-control"
                name="apellido2"
                placeholder="Segundo Apellido"
                style="text-transform: uppercase;"
                value="{{beneficiario.segundo_apellido}}">
            </input>
        </div>
    </div>

    <!-- fila 6 -->
    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputEmail4">Sede *</label>
        
            {{ select("id_sede", sedes, "class" : "form-control") }}
        </div>
        
        <div class="form-group col-md-4">
            <label for="inputEmail4">Jornada *</label>
        
            {{ select("id_jornada", jornada,  "class" : "form-control","onchange":"obtener_jornada()" ,"required":"required") }}
        </div>
        
        <div class="form-group col-md-4">
            <label for="inputEmail4">Grado *</label>
        
            {{ select("grado_cod_simat", grados_simat, "class" : "form-control", "required":"required") }}
        </div>
    </div>

    <!-- fila 7 -->
    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputEmail4">Grupo *</label>

            {{ select("grupo_simat", grupos_simat, "class" : "form-control", "required":"required") }}
        </div>

        <div class="form-group col-md-4">
            <label for="inputEmail4">Modelo *</label>

            {{ select("modelo", modelo, "class" : "form-control" , "required":"required") }}
        </div>

        <div class="form-group col-md-4">
            <label for="inputEmail4">Zona *</label>

            {{ select("zona_sede", zona_sede,  "class" : "form-control", "required":"required") }}
        </div>
    </div>

    <!-- fila 8 -->
    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputPassword4">Fecha Inicio *</label>
            <input
                id="fecha_ini"
                type="date"
                class="form-control"
                name="fecha_ini"
                min="{{fecha_inicio_min}}"
                max="{{fecha_fin_max}}"
                required>
            </input>
        </div>

        <!-- <div class="form-group col-md-4">
            <label for="inputPassword4">Fecha Finalización</label>
            <input
                id="fecha_fin"
                type="text"
                class="form-control"
                name="fecha_fin"
                placeholder="yyyy/mm/dd">
            </input>
        </div> -->

        <div class="form-group col-md-4" >
            <label for="inputPassword4">RH</label>
            <!-- <input
                type="text"
                class="form-control"
                name="tipo_sangre"
                placeholder="Tipo Sangre">
            </input> -->
            {{ select("tipo_sangre", tipo_sangre, "class" : "form-control", "required":"required") }}
        </div>
    </div>

    <!-- fila 9 -->

    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputPassword4">Puntaje Sisben</label>
            <input
                type="number"
                step="any"
                class="form-control"
                name="sisben_tres"
                placeholder="Puntaje Sisben">
            </input>
        </div>

        <div class="form-group col-md-4">
            <label for="inputEmail4">Sexo *</label>
            {{ select("genero", genero,  "class" : "form-control", "required":"required") }}
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">Fecha Nacimiento *</label>
            <input
                id="fecha_nacimiento"
                type="date"
                class="form-control"
                name="fecha_nacimiento"
                max="{{fecha_fin}}"
                required>
            </input>
        </div>
    </div>

    <!-- fila 10 -->

    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputPassword4">Teléfono / Celular</label>
            <input
                type="text"
                class="form-control"
                name="telefono"
                placeholder="Teléfono / Celular"
            ></input>
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">EPS</label>
            <input
                type="text"
                class="form-control"
                name="eps"
                placeholder="EPS"
            ></input>
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">Barrio</label>
            <input
                type="text"
                class="form-control"
                name="barrio"
                placeholder="Barrio"
            ></input>
        </div>
    </div>

    <!-- fila 11 -->

    <div class="form-row">
        <!-- <div class="form-group col-md-4">
            <label for="inputEmail4">Matrícula Contratada *</label>
            {{ select("matricula_contratada", matricula_contratada,  "class" : "form-control", "required":"required") }}
        </div> -->

        <!-- <div class="form-group col-md-4">
            <label for="inputPassword4">FUENTE DE RECURSOS</label>
            <input
                type="text"
                class="form-control"
                name="fuente_recursos"
                placeholder="FUENTE DE RECURSOS"
                value="SGP"
            ></input>
        </div> -->

        <!-- <div class="form-group col-md-4">
            <label for="inputPassword4">Internado</label>
            <input
                type="text"
                class="form-control"
                name="internado"
                placeholder="Internado"
                value="NINGUNO"
            ></input>
        </div> -->
    </div>

    <!-- fila 12 -->

    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputEmail4">Apoyo Academico Especial *</label>
            {{ select("apoyo_acadmico_especial", apoyo_acadmico_especial,  "class" : "form-control", "required":"required") }}
        </div>
<!-- 
        <div class="form-group col-md-4">
            <label for="inputEmail4">SRPA *</label>
            {{ select("srpa", srpa,  "class" : "form-control", "required":"required") }}
        </div> -->

        <div class="form-group col-md-4">
            <label for="inputPassword4">Discapacidad</label>
            <input
                type="text"
                class="form-control"
                name="discapacidad"
                placeholder="Discapacidad"
            ></input>
        </div>
    </div>

    <!-- fila 13 -->

    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputEmail4">Estrato *</label>
            {{ select("estrato", estrato,  "class" : "form-control", "required":"required") }}
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">País Origen *</label>
            <input
                type="text"
                class="form-control"
                name="pais_origen"
                placeholder="País Origen"
                required>
            </input>
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">Correo</label>
            <input
                type="email"
                class="form-control"
                name="correo"
                placeholder="Correo">
            </input>
        </div>
    </div>

      <!-- fila 14 -->

    <div class="form-row">
        <!-- <div class="form-group col-md-4">
            <label for="inputEmail4">Matriculado en Simat *</label>

            {{ select("matricula_simat", matricula_simat,  "class" : "form-control", "required":"required", "onchange":"ocultar_campo_evidencia()") }}
        </div> -->
      
        <div class="form-group col-md-4"  id="evidencia_archivo">
            <label for="cargarDocumento">Adjuntar Captura De Matrícula En Simat*</label>
            <div>
                <input class="fileupload filestyle form-control" data-input="false" id="archivo" required data-badge="false" type="file" name="evidencia" multiple required>
                <div id="progress" class="progress" style="margin: 0 !important;">
                    <div class="progress-bar progress-bar-success"></div>
                </div>
                <input type='hidden' class='urlEvidenciaAtencion' name='urlEvidenciaAtencion'>
            </div>
        </div>
        <div class="form-group col-md-4">
            <label for="inputEmail4">Observaciones</label>
            <textarea class="form-control" name="observaciones_prematricula"  rows="2"></textarea>
        </div>        
    </div>
    <div  class="form-group col-md-4" style="margin-top: 2%;">
        <button type="submit" class="btn btn-primary">GUARDAR</button>  
    </div>
</form>

<script>

    function ocultar_campo_evidencia(){
        var valor =$("#matricula_simat").val();
        if ( valor == "SI") {
            $('#evidencia_archivo').show()
            $("#archivo").prop('required')
        }else{
            $('#evidencia_archivo').hide()
            $('#archivo').removeAttr("required");
        }
    }

      
    function obtener_jornada(){
        $("#nombre_jornada").val($('select[name="id_jornada"] option:selected').text());
    }
    // window.onload = function() {
    //     var getDate = function (input) {
    //         return new Date(input.date.valueOf());
    //     }

    //     var d = new Date();
    //     var endDate_nac =  d.getFullYear() + "/" + (d.getMonth()+1) + "/"+ d.getDate();
    //     $('#fecha_nacimiento').datepicker({
    //         format: "yyyy/mm/dd",
    //         language: 'es',
    //         endDate: endDate_nac,
    //     });
    //     var strDate = d.getFullYear() + "/" + (d.getMonth())  + "/"+ d.getDate();
    //     var endDate = d.getFullYear()+"/12" + "/31" ;
       
    //     $('#fecha_fin').datepicker({
    //         format: "yyyy/mm/dd",
    //         language: 'es',
    //         startDate: strDate,
    //         endDate: endDate,
    //     });
       
    //     var strDate_ini = d.getFullYear() + "/" + (d.getMonth()) + "/"+ d.getDate() ;
    //     var endDate_ini =  d.getFullYear() + "/" + (d.getMonth()+1) + "/"+ d.getDate();
    //     $('#fecha_ini').datepicker({
    //         format: "yyyy/mm/dd",
    //         language: 'es',
    //         startDate: strDate_ini,
    //         endDate: endDate_ini,
    //      }).on('changeDate',
    //     function (selected) {
    //         $('#fecha_fin').datepicker('clearDates');
    //         $('#fecha_fin').datepicker('setStartDate', getDate(selected));
    //         console.log( $('#fecha_ini').val())
    //     });
    // };

</script>