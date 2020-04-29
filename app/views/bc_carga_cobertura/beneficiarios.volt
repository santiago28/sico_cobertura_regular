
 {{ content() }}
<h2>Beneficiarios contrato número {{beneficiarios[0].id_contrato}}</h2>

<br>
{{ link_to("bc_carga_cobertura/nuevo", '<i class="glyphicon glyphicon-chevron-left"></i> Regresar', "class": "btn btn-primary menu-tab") }}
<table class="table table-bordered table-hover">
  <thead>
      <tr>
          <th>Nucleo</th>
          <th>Operador</th>
          <th>Sede atencón</th>
          <th>Documento identidad</th>
          <th>Nombres</th>
          <th>Apellidos</th>
          <th>Ciclos</th>
          <th>Comité</th>
          <th>Acta</th>
       </tr>
  </thead>
  <tbody>

  {% for beneficiario in beneficiarios %}
      <tr>
          <td>{{beneficiario.nucleo}}</td>
          <td>{{beneficiario.operador}}</td>
          <td>{{beneficiario.sede_atencion}}</td>
          <td>{{beneficiario.documento_identidad}}</td>
          <td>{{beneficiario.primer_nombre}} {{beneficiario.segundo_nombre}}</td>
          <td>{{beneficiario.primer_apellido}} {{beneficiario.segundo_apellido}}</td>
          <td>{{beneficiario.ciclo}}</td>
          <td>{{beneficiario.respuesta_comite}}</td>
          <td>{{beneficiario.proviene}}</td>
      </tr>
  {% endfor %}

  </tbody>
</table>
