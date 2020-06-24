<?php

use Phalcon\Events\Event,
Phalcon\Mvc\Dispatcher,
Phalcon\Mvc\User\Plugin;

/**
* Security
*
* Gestiona los niveles de permisos de toda la aplicación
*/
class SecurityPlugin extends Plugin
{
  private $_permiso = array(
    'ibc_mensaje' => array(
      'index' => array(
        'nivelPermiso' => '4'
      ),
      'mensajes' => array(
        'nivelPermiso' => '4'
      ),
      'mensaje' => array(
        'nivelPermiso' => '4'
      ),
      'anuncios' => array(
        'nivelPermiso' => '4'
      ),
      'crear' => array(
        'nivelPermiso' => '4'
      ),
      'comentario' => array(
        'nivelPermiso' => '4'
      )
    ),
    'cob_periodo' => array(
      'index' => array(
        'nivelPermiso' => '3'
      ),
      'nuevo' => array(
        'nivelPermiso' => '1'
      ),
      'ver' => array(
        'nivelPermiso' => '3'
      ),
      'recorrido' => array(
        'nivelPermiso' => '3'
      ),
      'gdocumental' => array(
        'nivelPermiso' => '2'
      ),
      'rutear' => array(
        'nivelPermiso' => '2'
      ),
      'ruteoguardar' => array(
        'nivelPermiso' => '1'
      ),
      'nuevorecorrido' => array(
        'nivelPermiso' => '1'
      ),
      'nuevorecorrido1' => array(
        'nivelPermiso' => '1'
      ),
      'editar' => array(
        'nivelPermiso' => '1'
      ),
      'crear' => array(
        'nivelPermiso' => '1'
      ),
      'generarrecorrido1' => array(
        'nivelPermiso' => '1'
      ),
      'generarrecorrido' => array(
        'nivelPermiso' => '1'
      ),
      'guardar' => array(
        'nivelPermiso' => '1'
      ),
      'eliminar' => array(
        'nivelPermiso' => '1'
      ),
      'elegirfacturacion' => array(
        'nivelPermiso' => '1'
      )
    ),
    'bc_carga_cobertura' => array(
      'index' => array(
        'nivelPermiso' => '1'
      ),
      'nuevo' => array(
        'nivelPermiso' => '1'
      ),
      'crear' => array(
        'nivelPermiso' => '1'
      ),
      'beneficiarios' => array(
        'nivelPermiso' => '1'
      ),
    ),
    'bc_carga' => array(
      'index' => array(
        'nivelPermiso' => '1'
      ),
      'nuevo' => array(
        'nivelPermiso' => '1'
      ),
      'nuevoindividual' => array(
        'nivelPermiso' => '1'
      ),
      'crear' => array(
        'nivelPermiso' => '1'
      ),
      'crearindividual' => array(
        'nivelPermiso' => '1'
      ),
      'eliminar' => array(
        'nivelPermiso' => '1'
      )
    ),
    'mt_carga' => array(
      'index' => array(
        'nivelPermiso' => '1'
      ),
      'nuevo' => array(
        'nivelPermiso' => '1'
      ),
      'crear' => array(
        'nivelPermiso' => '1'
      ),
      'eliminar' => array(
        'nivelPermiso' => '1'
      )
    ),
    'ibc_usuario' => array(
      'index' => array(
        'nivelPermiso' => '3'
      ),
      'nuevo' => array(
        'nivelPermiso' => '1'
      ),
      'ver' => array(
        'nivelPermiso' => '1'
      ),
      'editar' => array(
        'nivelPermiso' => '1'
      ),
      'crear' => array(
        'nivelPermiso' => '2'
      ),
      'guardar' => array(
        'nivelPermiso' => '2'
      ),
      'eliminar' => array(
        'nivelPermiso' => '1'
      ),
      'interventores' => array(
        'nivelPermiso' => '1'
      ),
      'editarperfil' => array(
        'nivelPermiso' => '4'
      ),
      'actualizardatos' => array(
        'nivelPermiso' => '4'
      ),
      'returnPasswordEncrypt' => array(
        'nivelPermiso' => '-2'
      )
    ),
    'errores' => array(
      'error401' => array(
        'nivelPermiso' => '-2'
      ),
      'error404' => array(
        'nivelPermiso' => '-2'
      ),
      'error500' => array(
        'nivelPermiso' => '-2'
      )
    ),
    'cob_actaconteo' => array(
      'index' => array(
        'nivelPermiso' => '3'
      ),
      'ver' => array(
        'nivelPermiso' => '3'
      ),
      'datos' => array(
        'nivelPermiso' => '3'
      ),
      'guardardatos' => array(
        'nivelPermiso' => '3'
      ),
      'guardarbeneficiarios' => array(
        'nivelPermiso' => '3'
      ),
      'guardaradicionales' => array(
        'nivelPermiso' => '3'
      ),
      'beneficiarios' => array(
        'nivelPermiso' => '3'
      ),
      'adicionales' => array(
        'nivelPermiso' => '3'
      ),
      'empleados' => array(
        'nivelPermiso' => '3'
      ),
      'guardarempleados' => array(
        'nivelPermiso' => '3'
      ),
      'adicionalescapturas' => array(
        'nivelPermiso' => '3'
      ),
      'subiradicional' => array(
        'nivelPermiso' => '3'
      ),
      'subirexcusa' => array(
        'nivelPermiso' => '3'
      ),
      'cerrar' => array(
        'nivelPermiso' => '3'
      ),
      'abrir' => array(
        'nivelPermiso' => '2'
      ),
      'totalcertificar' => array(
        'nivelPermiso' => '1'
      ),
      'seguimientoitinerante' => array(
        'nivelPermiso' => '3'
      ),
      'cargaractas' => array(
        'nivelPermiso' => '3'
      ),
      'nuevo' => array(
        'nivelPermiso' => '3'
      ),
      'crear' => array(
        'nivelPermiso' => '3'
      ),
      'eliminar' => array(
        'nivelPermiso' => '1'
      ),
      'reportebeneficiario' => array(
        'nivelPermiso' => '1'
      ),
      'consultar_beneficiario' => array(
        'nivelPermiso' => '1'
      ),
      'datos_beneficiario' => array(
        'nivelPermiso' => '1'
      )

    ),'cob_actamuestreo' => array(
      'index' => array(
        'nivelPermiso' => '3'
      ),
      'ver' => array(
        'nivelPermiso' => '3'
      ),
      'datos' => array(
        'nivelPermiso' => '3'
      ),
      'beneficiarios' => array(
        'nivelPermiso' => '3'
      )

    ),
    'session' => array(
      'start' => array(
        'nivelPermiso' => '-2'
      ),'end' => array(
        'nivelPermiso' => '-2'
      )
    ),
    'cob_ajuste' => array(
      'index' => array(
        'nivelPermiso' => '3'
      ),'noasignados' => array(
        'nivelPermiso' => '3'
      ),'periodo' => array(
        'nivelPermiso' => '3'
      ),'reporte' => array(
        'nivelPermiso' => '3'
      ),'nuevo' => array(
        'nivelPermiso' => '3'
      ),'buscar' => array(
        'nivelPermiso' => '3'
      ),'asignar' => array(
        'nivelPermiso' => '1'
      ),'asignarperiodo' => array(
        'nivelPermiso' => '1'
      ),'asignarperiodos' => array(
        'nivelPermiso' => '1'
      ),'nuevafechareporte' => array(
        'nivelPermiso' => '1'
      ),'reportes' => array(
        'nivelPermiso' => '1'
      ),'reportesedes' => array(
        'nivelPermiso' => '1'
      ),'reportecontratos' => array(
        'nivelPermiso' => '1'
      ),'reportebeneficiarioscontrato' => array(
        'nivelPermiso' => '4'
      ),'subirexcusa' => array(
        'nivelPermiso' => '3'
      )

    ),
    'ibc_archivo_digital' => array(
      'index' => array(
        'nivelPermiso' => '4'
      ),
      'cargaprestador' => array(
        'nivelPermiso' => '4'
      )
    ),
    'ibc_instrumentos' => array(
      'index' => array(
        'nivelPermiso' => '4'
      )
    ),
    'index' => array(
      'index' => array(
        'nivelPermiso' => '-2'
      ),
      'quienessomos' => array(
        'nivelPermiso' => '-2'
      ),
      'directorio' => array(
        'nivelPermiso' => '-2'
      ),
      'contacto' => array(
        'nivelPermiso' => '-2'
      )
    ),
    'bc_reporte' => array(
      'oferente_periodos_consolidado' => array(
        'nivelPermiso' => '4'
      ),
      'beneficiarios_periodofacturacion' => array(
        'nivelPermiso' => '2'
      ),
      'beneficiarios_periodofacturacion_consolidado' => array(
        'nivelPermiso' => '2'
      ),
      'cob_contratos' => array(
        'nivelPermiso' => '1'
      ),
      'cob_sedes' => array(
        'nivelPermiso' => '1'
      ),
      'oferente_contratos' => array(
        'nivelPermiso' => '4'
      ),
      'oferentes_contratos' => array(
        'nivelPermiso' => '2'
      ),
      'oferente_periodos' => array(
        'nivelPermiso' => '4'
      ),
      'beneficiarios_contratoparcial' => array(
        'nivelPermiso' => '4'
      ),
      'beneficiarios_contrato_periodo' => array(
        'nivelPermiso' => '4'
      ),
      'beneficiarios_contratofinal' => array(
        'nivelPermiso' => '4'
      ),
      'beneficiarios_contratofacturacion' => array(
        'nivelPermiso' => '4'
      ),
      'beneficiarios_contratoajustes' => array(
        'nivelPermiso' => '4'
      ),'contratos_liquidacion' => array(
        'nivelPermiso' => '2'
      ),'contrato_liquidacion' => array(
        'nivelPermiso' => '2'
      ),'buscar_contratoliquidacion' => array(
        'nivelPermiso' => '2'
      )
    ),
    'cob_verificacion' => array(
      'index' => array(
        'nivelPermiso' => '3'
      ),
      'nuevo' => array(
        'nivelPermiso' => '1'
      ),
      'ver' => array(
        'nivelPermiso' => '3'
      ),
      'editar' => array(
        'nivelPermiso' => '1'
      ),
      'crear' => array(
        'nivelPermiso' => '1'
      ),
      'guardar' => array(
        'nivelPermiso' => '1'
      ),
      'eliminar' => array(
        'nivelPermiso' => '1'
      ),
      'rutear' => array(
        'nivelPermiso' => '2'
      ),
      'gdocumental' => array(
        'nivelPermiso' => '2'
      )
    ),
    'cob_actadocumentacion' => array(
      'ver' => array(
        'nivelPermiso' => '3'
      ),
      'datos' => array(
        'nivelPermiso' => '3'
      ),
      'guardardatos' => array(
        'nivelPermiso' => '3'
      ),
      'beneficiarios' => array(
        'nivelPermiso' => '3'
      ),
      'guardarbeneficiarios' => array(
        'nivelPermiso' => '3'
      )
    ),
    'cob_actatelefonica' => array(
      'ver' => array(
        'nivelPermiso' => '3'
      ),
      'datos' => array(
        'nivelPermiso' => '3'
      ),
      'guardardatos' => array(
        'nivelPermiso' => '3'
      ),
      'beneficiarios' => array(
        'nivelPermiso' => '3'
      ),
      'guardarbeneficiarios' => array(
        'nivelPermiso' => '3'
      )
    ),
    'cob_actacomputo' => array(
      'ver' => array(
        'nivelPermiso' => '3'
      ),
      'datos' => array(
        'nivelPermiso' => '3'
      ),
      'guardardatos' => array(
        'nivelPermiso' => '3'
      )
    ),
    'cob_actath' => array(
      'ver' => array(
        'nivelPermiso' => '3'
      ),
      'datos' => array(
        'nivelPermiso' => '3'
      ),
      'guardardatos' => array(
        'nivelPermiso' => '3'
      ),
      'talentohumano' => array(
        'nivelPermiso' => '3'
      ),
      'adicionales' => array(
        'nivelPermiso' => '3'
      ),
      'adicionales_listado' => array(
        'nivelPermiso' => '3'
      ),
      'guardarbeneficiarios' => array(
        'nivelPermiso' => '3'
      )
    ),
    'cob_actafocalizacion' => array(
      'ver' => array(
        'nivelPermiso' => '3'
      ),
      'datos' => array(
        'nivelPermiso' => '3'
      ),
      'guardardatos' => array(
        'nivelPermiso' => '3'
      ),
      'beneficiarios' => array(
        'nivelPermiso' => '3'
      ),
      'guardarbeneficiarios' => array(
        'nivelPermiso' => '3'
      )
    ),
    'bc_permiso' => array(
      'index' => array(
        'nivelPermiso' => '4'
      ),
      'nuevo' => array(
        'nivelPermiso' => '4'
      ),
      'crear_jornada_planeacion' => array(
        'nivelPermiso' => '4'
      ),
      'crear_jornada_formacion' => array(
        'nivelPermiso' => '4'
      ),
      'crear_incidente' => array(
        'nivelPermiso' => '4'
      ),'crear_general' => array(
        'nivelPermiso' => '4'
      ),
      'subir_archivo' => array(
        'nivelPermiso' => '4'
      ),
      'mes' => array(
        'nivelPermiso' => '4'
      ),
      'anio' => array(
        'nivelPermiso' => '4'
      ),
      'semana' => array(
        'nivelPermiso' => '4'
      ),
      'dia' => array(
        'nivelPermiso' => '4'
      ),
      'permiso' => array(
        'nivelPermiso' => '4'
      ),
      'revision' => array(
        'nivelPermiso' => '2'
      ),
      'reportes' => array(
        'nivelPermiso' => '2'
      ),
      'reporte' => array(
        'nivelPermiso' => '2'
      )
    ),
    'bc_hcb' => array(
      'index' => array(
        'nivelPermiso' => '4'
      ),
      'nuevoempleado' => array(
        'nivelPermiso' => '4'
      ),
      'ver' => array(
        'nivelPermiso' => '4'
      ),
      'empleados' => array(
        'nivelPermiso' => '4'
      ),
      'editarempleado' => array(
        'nivelPermiso' => '4'
      ),
      'cronograma' => array(
        'nivelPermiso' => '4'
      ),
      'guardarcronograma' => array(
        'nivelPermiso' => '4'
      ),
      'nuevo_periodo' => array(
        'nivelPermiso' => '1'
      ),
      'novedades' => array(
        'nivelPermiso' => '4'
      )
    ),
    'dashboard' => array(
      'index' => array(
        'nivelPermiso' => '1'
      )
    ),
    'bc_sede_contrato' => array(
      'index' => array(
        'nivelPermiso' => '4'
      ),
      'nuevo' => array(
        'nivelPermiso' => '4'
      ),
      'crear' => array(
        'nivelPermiso' => '1'
      ),
      'beneficiarios' => array(
        'nivelPermiso' => '4'
      ),
      'guardarbeneficiarios' => array(
        'nivelPermiso' => '4'
      ),
      'editar_persona' => array(
        'nivelPermiso' => '4'
      ),
      'guardar_update_beneficiario' => array(
        'nivelPermiso' => '4'
      ),
      'crearBeneficiario' => array(
        'nivelPermiso' => '4'
      ),
      'guardar_beneficiario' => array(
        'nivelPermiso' => '4'
      ),
      'eliminar' => array(
        'nivelPermiso' => '4'
      ),
      'subirEvidencia' => array(
      'nivelPermiso' => '4'
      ),
      'solicitudEditarDocumento' => array(
        'nivelPermiso' => '4'
      ),
      'solicitudMatricula' => array(
        'nivelPermiso' => '2'//2
      ),
      'cambiarEstadoMatricula' => array(
        'nivelPermiso' => '2'//2
      ),
      'modificarDocumentos' => array(
        'nivelPermiso' => '2'//2
      ),
      'actualizarDocumento' => array(
        'nivelPermiso' => '2'//2
      ),
      'editarEvidenciaSimat' => array(
        'nivelPermiso' => '4'
      ),
      'sedeContrato' => array(
        'nivelPermiso' => '1'
      ),
      'eliminarSede' => array(
        'nivelPermiso' => '1'
      ),
      'crearSede' => array(
        'nivelPermiso' => '1'
      ),
      'consultarContratos' => array(
        'nivelPermiso' => '1'
      ),
      'guardarSedeContrato' => array(
        'nivelPermiso' => '1'
      ),
      'editarSede' => array(
        'nivelPermiso' => '1'
      ),
      'guardarEdicionSede' => array(
        'nivelPermiso' => '1'
      ),
    )

  );

  /**
  * This action is executed before execute any action in the application
  *
  * @param Event $event
  * @param Dispatcher $dispatcher
  */
  public function beforeDispatch(Event $event, Dispatcher $dispatcher)
  {
    $controlador = $dispatcher->getControllerName();
    $accion = $dispatcher->getActionName();
    $user = $this->session->get('auth');
    if ($user && $controlador !== "index") {
      if(!$controlador || !$accion){
        return TRUE;
      }
      if($user['estado'] == 0 && "ibc_usuario/actualizardatos" !== $controlador . "/" . $accion){
        return $this->response->redirect("ibc_usuario/actualizardatos");
      }
      if($user['nivel'] <= $this->_permiso[$controlador][$accion]['nivelPermiso'] || $this->_permiso[$controlador][$accion]['nivelPermiso'] == -2){
        return TRUE;
      } else {
        return $this->response->redirect('errores/error401');
      }
    } else if($this->_permiso[$controlador][$accion]['nivelPermiso'] == -2) {
      return TRUE;
    } else if($controlador !== "session" && $controlador !== "index") {
      $this->session->set("last_url", str_replace('/sico_cobertura_regular/', '', $_SERVER["REQUEST_URI"]));
      $url_return = "http://".$_SERVER['SERVER_NAME'].':10001/2020/interventoria/principal.php';
      return $this->response->redirect($url_return);
    } else {
      return TRUE;
    }
  }
}
