
{{ content() }}
<h1>Buscar Beneficiario</h1>
<!-- {{ link_to("cob_periodo/index", '<i class="glyphicon glyphicon-chevron-left"></i> Regresar', "class": "btn btn-primary menu-tab") }} -->
{{ form("cob_actaconteo/consultar_beneficiario", "method":"get", "class":"form-container form-horizontal", "parsley-validate" : "") }}
        <div class="form-group">
            <label class="col-sm-2 control-label" for="fecha">Documento o Nombre Completo</label>
            <div class="col-sm-10" >
                    {{ text_field("valor_busqueda", "type" : "text", "class" : "form-control", "placeholder" : "Documento o Nombre Completo") }}
            </div>
        </div>
       <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            {{ submit_button("Buscar", "class" : "btn btn-default") }}
        </div>
     </div>
</form>




