
 {{ content() }}
 
 <h1>Matrícula Estudiantes</h1>
 <br>
 <br>
 <table class="table table-bordered table-hover">
   <thead>
       <tr>
           <th>Nombre Completo</th>
           <th>Documento</th>
           <th>Contrato</th>
           <th>Prestador</th>
           <th>Sede</th>
           <th>Evidencia</th>
           <th>Acción</th>
        </tr>
   </thead>
   <tbody>
 
   {% for beneficiario in beneficiarios %}
       <tr>
           <td>{{beneficiario.nombre1}} {{beneficiario.nombre2}} {{beneficiario.apellido1}} {{beneficiario.apellido2}}</td>
           <td>{{beneficiario.documento}}</td>
           <td>{{beneficiario.id_contrato}}</td>
           <td>{{beneficiario.institucion}}</td>
           <td>{{beneficiario.id_sede}} {{beneficiario.nombre_sede}}</td>
           <td><p><a class="captura" target="_blank" href="/sico_cobertura_regular/files/excusas/{{ beneficiario.urlEvidenciaMatricula }}">{% if beneficiario.urlEvidenciaMatricula %}Clic para ver{% endif %}</a></p></td>
           <td>
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-success" onclick="abrilModal(1, '{{beneficiario.id_oferente_persona}}')"><i class="glyphicon glyphicon-ok"></i></button>
                <button type="button" class="btn btn-danger" onclick="abrilModal(3, '{{beneficiario.id_oferente_persona}}')"><i class="glyphicon glyphicon-remove"></i></button>                
              </div>
           </td>
       </tr>
   {% endfor %}
 
   </tbody>
 </table>

 <!-- Modal confirmar matricula-->
<div class="modal fade" id="modalMatriula" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLongTitle">Confirmar Matrícula</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          {{ form("bc_sede_contrato/cambiarEstadoMatricula/", "method":"post", "parsley-validate" : "", "id" : "beneficiarios_form") }}
          {{ hidden_field("estado_certificacion") }}
          {{ hidden_field("id_oferente_persona") }}
            <div class="form-group">
              <label id="texto"></label>
            </div>
            <div class="form-group" id="rechazo">
              <label for="inputEmail4">Motivo Rechazo</label>
              {{ select("error_archivo", error_archivo,  "class" : "form-control", "required":"required") }}
            </div>
            <div class="modal-footer">
               <button type="submit" class="btn btn-primary">Aceptar</button>
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
            </div>
         </form>
        </div>
      </div>
    </div>
  </div>
 
  <script>
       function abrilModal(opc, id){
           if (opc==1) {
               $("#texto").text("¿Esta seguro que desea confirmar la matrícula?")
               $('#error_archivo').removeAttr("required");
               $("#rechazo").hide();
           }else{
               $("#texto").text("¿Esta seguro que desea rechazar la matrícula?")
               $("#rechazo").show();
           }
           $("#id_oferente_persona").val(id);
           $("#estado_certificacion").val(opc);
           $("#modalMatriula").modal("show");
      }
  </script>