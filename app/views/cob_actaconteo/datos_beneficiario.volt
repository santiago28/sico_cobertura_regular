{{ content() }}
<div class="col-md-12" style="justify-content: center;">
    <h3>BENEFICIARIO </h3>
    <h5><b>{{oferente_persona.nombreCompleto }}</b></h5>
    <h5><b> DOCUMENTO</b> {{oferente_persona.numDocumento}}</h5>
    <h5><b> CONTRATO:</b> {{sede.id_contrato }}</h5>
    <h5><b> OFERENTE: </b> {{sede.oferente_nombre}}</h5>
    <h5><b> SEDE: </b> {{sede.sede_nombre}}</h5>
    <br>
</div>
<table class="table table-bordered table-hover">
    <thead>
        <tr>
            <th>Sede</th>
            <th>Periodo</th>
            <th>Contrato</th>
            <th>Nombre Oferente</th>
            <th>Certificacion Facturación</th>
         </tr>
    </thead>
    <tbody>
    {% for factura in facturas %}
        <tr>
            <td>{{factura.sede_nombre}}</td>
            <td>{{factura.fecha}}</td>
            <td>{{factura.id_contrato}}</td>
            <td>{{factura.oferente_nombre}}</td>
            <td> 
                {% if(factura.certificacionRecorridos ==1) %}
                    <span>CERTIFICAR ATENCIÓN</span>
                {% else %}
                    <span>NO CERTIFICAR ATENCIÓN</span>
                {% endif %}
            </td>
        </tr>
    {% endfor %}
    </tbody>
</table>