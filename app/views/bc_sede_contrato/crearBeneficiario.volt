{{ content() }}

<h1>Crear Beneficiario</h1>

<br>
<br>
<!-- <form style="margin-top: 4%;" action="bc_sede_contrato/guardar_update_beneficiario" method="POST" > -->
{{ form("bc_sede_contrato/guardar_beneficiario/", "method":"post", "parsley-validate" : "", "id" : "beneficiarios_form") }}
{{ hidden_field("id_contrato", "value": beneficiario.id_contrato) }}
{{ hidden_field("ingreso", "value": beneficiario.proviene) }}

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
                required>
            </input>
        </div>

        <div class="form-group col-md-4">
            <label for="">Código Dane *</label>
            <input
                type="text"
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
            <label for="inputEmail4">Etc</label>

            <input
                type="text"
                class="form-control"
                name="etc"
                placeholder="Etc"
                value="MEDELLÍN">
            </input>
        </div>

        <div class="form-group col-md-4">
            <label for="">Estado Matricula *</label>

            {{ select("estado", estado_simat, "class" : "form-control") }}
        </div>

        <div class="form-group col-md-4">
            <label for="">Jerarquía *</label>

            {{ select("jerarquia", jerarquia, "class" : "form-control") }}
        </div>
    </div>

    <!-- fila 3 -->

    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="">Calendario Estudiantil *</label>
            {{ select("calendario", prestacion_servicio, "class" : "form-control") }}
        </div>

        <div class="form-group col-md-4">
            <label for="">Sector *</label>
            {{ select("sector", sector, "class" : "form-control") }}
        </div>

        <div class="form-group col-md-4">
            <label for="">Prestación de Servicio *</label>
            {{ select("prestacion_servicio", prestacion_servicio, "class" : "form-control") }}
        </div>
    </div>

    <!-- fila 4 -->

    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputEmail4">Tipo Documento *</label>
            {{ select("tipo_documento", tipo_documento, "class" : "form-control") }}
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">Documento *</label>
            <input
                type="text"
                class="form-control"
                name="documento"
                placeholder="Documento"
                value="{{beneficiario.documento_identidad}}"
                required>
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
                value="{{beneficiario.primer_apellido}}"
                required>
            </input>
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">Segundo Apellido *</label>
            <input
                type="text"
                class="form-control"
                name="apellido2"
                placeholder="Segundo Apellido"
                value="{{beneficiario.segundo_apellido}}"
                required>
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
        
            {{ select("id_jornada", jornada,  "class" : "form-control") }}
        </div>
        
        <div class="form-group col-md-4">
            <label for="inputEmail4">Grado *</label>
        
            {{ select("grado_cod_simat", grados_simat, "class" : "form-control") }}
        </div>
    </div>

    <!-- fila 7 -->
    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputEmail4">Grupo *</label>

            {{ select("grupo_simat", grupos_simat, "class" : "form-control") }}
        </div>

        <div class="form-group col-md-4">
            <label for="inputEmail4">Modelo *</label>

            {{ select("modelo", modelo, "class" : "form-control") }}
        </div>

        <div class="form-group col-md-4">
            <label for="inputEmail4">Zona *</label>

            {{ select("zona_sede", zona_sede,  "class" : "form-control") }}
        </div>
    </div>

    <!-- fila 8 -->
    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputPassword4">Fecha Inicio *</label>
            <input
                type="date"
                class="form-control"
                name="fecha_ini"
                placeholder="Segundo Nombre"
                required>
            </input>
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">Fecha Finalización</label>
            <input
                type="date"
                class="form-control"
                name="fecha_fin"
                placeholder="Segundo Nombre">
            </input>
        </div>

        <div class="form-group col-md-4">
            <label for="inputEmail4">Matriculado en Simat *</label>

            {{ select("matricula_simat", matricula_simat,  "class" : "form-control") }}
        </div>
    </div>

    <!-- fila 9 -->

    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputPassword4">Puntaje Sisben</label>
            <input
                type="number"
                class="form-control"
                name="sisben_tres"
                placeholder="Puntaje Sisben">
            </input>
        </div>

        <div class="form-group col-md-4">
            <label for="inputEmail4">Genero *</label>
            {{ select("genero", genero,  "class" : "form-control") }}
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">Fecha Nacimiento *</label>
            <input
                type="date"
                class="form-control"
                name="fecha_nacimiento"
                placeholder="Segundo Nombre"
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
        <div class="form-group col-md-4">
            <label for="inputEmail4">Matrícula Contratada *</label>
            {{ select("matricula_contratada", matricula_contratada,  "class" : "form-control") }}
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">FUENTE DE RECURSOS</label>
            <input
                type="text"
                class="form-control"
                name="fuente_recursos"
                placeholder="FUENTE DE RECURSOS"
                value="SGP"
            ></input>
        </div>

        <div class="form-group col-md-4">
            <label for="inputPassword4">Internado</label>
            <input
                type="text"
                class="form-control"
                name="internado"
                placeholder="Internado"
                value="NINGUNO"
            ></input>
        </div>
    </div>

    <!-- fila 12 -->

    <div class="form-row">
        <div class="form-group col-md-4">
            <label for="inputEmail4">Apoyo Academico Especial *</label>
            {{ select("apoyo_acadmico_especial", apoyo_acadmico_especial,  "class" : "form-control") }}
        </div>

        <div class="form-group col-md-4">
            <label for="inputEmail4">SRPA *</label>
            {{ select("srpa", srpa,  "class" : "form-control") }}
        </div>

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
            {{ select("estrato", estrato,  "class" : "form-control") }}
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

    <button type="submit" class="btn btn-primary">GUARDAR</button>  

</form>