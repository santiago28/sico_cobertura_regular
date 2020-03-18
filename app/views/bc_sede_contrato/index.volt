{{ content() }}

<h1>Sedes</h1>
{{ link_to("bc_sede_contrato/nuevo", '<i class="glyphicon glyphicon-plus"></i> Nueva Sede', "class": "btn btn-primary menu-tab-first") }}
{% if (not(sedes_contrato is empty)) %}
<table class="table table-bordered table-hover">
  <thead>
    <tr>
      <th>Contrato</th>
      <th>Nombre sede</th>
      <th>Comuna</th>
      <th>Barrio</th>
      <th>Dirección</th>
    </tr>
  </thead>
  <tbody>
    {% for sedes_contrato in sedes_contrato %}
      {% if (nivel <= 1 or (sedes_contrato.id_contrato == usuario)) %}
      <tr>
        <td>{{ sedes_contrato.id_contrato }}</td>
        <td>{{ sedes_contrato.sede_nombre }}</td>
        <td>{{ sedes_contrato.sede_comuna }}</td>
        <td>{{ sedes_contrato.sede_barrio }}</td>
        <td>{{ sedes_contrato.sede_direccion }}</td>
      </tr>
      {% endif %}
    {% endfor %}
  </tbody>
</table>
{% endif %}
