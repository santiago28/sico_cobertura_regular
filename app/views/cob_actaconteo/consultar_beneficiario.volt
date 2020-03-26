{{ content() }}
<h1>Beneficiarios</h1>


<table class="table table-bordered table-hover">
    <thead>
        <tr>
            <th>Documento</th>
            <th>Nombre</th>
            <th>Contrato</th>
            <th>Sede</th>
            <th>Modalidad</th>
            <th>Grado</th>
            <th>Grupo</th>
            <th>Jornada</th>
            <th>Ver mas</th>
         </tr>
    </thead>
    <tbody>
    {% for beneficiario in beneficiarios %}
        <tr>
            <td>{{beneficiario.numDocumento}}</td>
            <td>{{beneficiario.nombreCompleto}}</td>
            <td>{{beneficiario.contrato}}</td>
            <td>{{beneficiario.sede_nombre}}</td>
            <td>{{beneficiario.modalidad}}</td>
            <td>{{beneficiario.grado}}</td>
            <td>{{beneficiario.grupo}}</td>
            <td>{{beneficiario.jornada}}</td>
            <td>{{ link_to("cob_actaconteo/datos_beneficiario/"~beneficiario.id_oferente_persona,  "Ver", "class": "btn btn-default") }}</td>
           
          
        </tr>
    {% endfor %}
    </tbody>
</table>