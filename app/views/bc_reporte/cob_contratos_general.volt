{% if (not(contratos is empty)) %}
<table class="table table-bordered table-hover" id="reporte">
  <thead>
    <tr>
      <th>Periodo Verificado</th>
      <th>Entidad Prestadora</th>
      <th>Número de Contrato</th>
      <th>Modalidad de Atención</th>
      <th>Cupos de Ampliación Contratados</th>
      <th>Cupos de Sostenibilidad Contratados</th>
      {# <th>Total de cupos Contratados</th> #}
      <th>Total de cupos en el Sistema Información</th>
      {# <th>Total de cupos a certificar Menores de 2 años</th>
      <th>Total de cupos a certificar Igual o mayor de 2 años y menor de 4 años</th>
      <th>Total de cupos a certificar Igual o mayor de 4 años y menor de 6 años</th>
      <th>Total de cupos a certificar Igual o mayor de 6 años</th> #}
      <th>Total beneficiarios certificados</th>
      <th>Porcentaje de Cobertura certificado</th>
      <th>Porcentaje de Cobertura matriculado SIMAT</th>
    </tr>
  </thead>
  <tbody>
    {% for contrato in contratos %}
    <?php $edades = $contrato->getEdadesContrato($contrato->id_contrato, $contrato->id_periodo); ?>
    <?php $certificados = $contrato->countBeneficiarioscertcontrato($contrato->id_contrato, $contrato->id_periodo); ?>
    <?php $cuposTotal = $contrato->CobPeriodoContratosedecupos->cuposTotal; ?>
    <?php $cuposSIBC = $contrato->countBeneficiarioscontrato($contrato->id_contrato, $contrato->id_periodo); ?>
    <?php $cuposSostenibilidad = $contrato->CobPeriodoContratosedecupos->cuposSostenibilidad; ?>
    <tr>
      <td>{{ contrato.CobPeriodo.getFechaDetail() }}</td>
      <td>{{ contrato.CobActaconteo.oferente_nombre }}</td>
      <td>{{ contrato.id_contrato }}</td>
      <td>{{ contrato.CobActaconteo.modalidad_nombre }}</td>
      <td>
        {% if(contrato.CobPeriodoContratosedecupos) %}
        {{ contrato.CobPeriodoContratosedecupos.cuposAmpliacion }}
        {% endif %}
      </td>
      <td>
        {% if(contrato.CobPeriodoContratosedecupos) %}
        {{ contrato.CobPeriodoContratosedecupos.cuposSostenibilidad }}
        {% endif %}
      </td>
      {# <td>{{ cuposTotal }}</td> #}
      <td>{{ cuposSIBC }}</td>
      {# <td>{{ edades['menor2'] }}</td>
      <td>{{ edades['mayorigual2menor4'] }}</td>
      <td>{{ edades['mayorigual4menor6'] }}</td>
      <td>{{ edades['mayorigual6'] }}</td> #}
      <td>{% if (certificados > cuposSostenibilidad) %}Se pasó{% else %}{{ certificados }}{% endif %}</td>
      <td>{% if (certificados > cuposSostenibilidad) %}Se pasó{% else %}<?php echo number_format($certificados / $cuposSostenibilidad * 100, 2, '.', ''); ?>%{% endif %}</td>
      <td>{% if (certificados > cuposSostenibilidad) %}Se pasó{% else %}<?php echo number_format($certificados / $cuposSIBC * 100, 2, '.', ''); ?>%{% endif %}</td>
    </tr>
    {% endfor %}
  </tbody>
</table>
{% endif %}
