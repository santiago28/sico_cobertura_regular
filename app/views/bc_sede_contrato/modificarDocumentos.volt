{{ content() }}

<h1>Modificar Documentos</h1>
<br>
<br>
<table class="table table-bordered table-hover">
  <thead>
      <tr>
          <th>Contrato</th>
          <th>Prestador</th>
          <th>Sede</th>
          <th>Nombres</th>
          <th>Doc. Actual</th>
          <th>Doc. Nuevo</th>
          <th>Evidencia</th>
          <th>Acciones</th>
       </tr>
  </thead>
  <tbody>

  {% for beneficiario in beneficiarios %}
      <tr>
          <td>{{beneficiario.id_contrato}}</td>
          <td>{{beneficiario.institucion}}</td>
          <td>{{beneficiario.nombre_sede}}</td>
          <td>{{beneficiario.nombre1}} {{beneficiario.nombre2}} {{beneficiario.apellido1}} {{beneficiario.apellido2}}</td>
          <td>{{beneficiario.documento_anterior}}</td>
          <td>{{beneficiario.documento_nuevo}}</td>
          <td><p><a class="captura" target="_blank" href="/sico_cobertura_regular/files/excusas/{{ beneficiario.urlEvidenciaDoc }}">{% if beneficiario.urlEvidenciaDoc %}Clic para ver{% endif %}</a></p></td>
          <td>
           <div class="btn-group" role="group">
               <button type="button" class="btn btn-success" onclick="abrilModal(1, '{{beneficiario.id_oferente_persona}}')"><i class="glyphicon glyphicon-ok"></i></button>
               <button type="button" class="btn btn-danger" onclick="abrilModal(0, '{{beneficiario.id_oferente_persona}}')"><i class="glyphicon glyphicon-remove"></i></button>                
             </div>
          </td>
      </tr>
  {% endfor %}

  </tbody>
</table>

<!-- Modal cambiar documento -->
<div class="modal fade" id="modalCambioDoc" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered" role="document">
     <div class="modal-content">
       <div class="modal-header">
         <h5 class="modal-title" id="exampleModalLongTitle">Confirmar Actualizacion del Documento</h5>
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
           <span aria-hidden="true">&times;</span>
         </button>
       </div>
       <div class="modal-body">
         {{ form("bc_sede_contrato/actualizarDocumento/", "method":"post", "parsley-validate" : "", "id" : "beneficiarios_form") }}
         {{ hidden_field("estado") }}
         {{ hidden_field("id_oferente_persona") }}
           <div class="form-group">
             <label id="texto"></label>
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
              $("#texto").text("¿Esta seguro que desea confirmar la actualización del documento?")
          }else{
              $("#texto").text("¿Esta seguro que desea rechazar la actualización del documento?")
          }
          $("#id_oferente_persona").val(id);
          $("#estado").val(opc);
          $("#modalCambioDoc").modal("show");
     }
 </script>
 