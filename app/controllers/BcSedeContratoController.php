<?php

use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\DI\FactoryDefault;

class BcSedeContratoController extends ControllerBase
{
  public $user;

  public function initialize()
  {
    $this->tag->setTitle("Acta de Conteo");
    $this->user = $this->session->get('auth');
    $this->usuario = $this->user['usuario'];
    parent::initialize();
  }

  public function indexAction()
  {
    $modalidades = BcModalidad::find();
    $bc_sedes_contrato = BcSedeContrato::find();

    $this->assets
    ->addJs('js/jquery.tablesorter.min.js')
    ->addJs('js/jquery.tablesorter.widgets.js');

    $this->view->sedes_contrato = $bc_sedes_contrato;
    $this->view->usuario = $this->usuario;
    $this->view->nivel = $this->user['nivel'];
  }

  public function nuevoAction()
  {
    // $this->persistent->parameters = null;
    $contratos_get = BcOferente::find();
    $contratos = array();
    foreach ($contratos_get as $row) {
      $contratos[$row->id_contrato] = $row->id_contrato.' - '.$row->oferente_nombre;
    }
    $this->view->contratos = $contratos;
    $this->view->nivel = $this->user['nivel'];
  }

  public function crearAction()
  {
    if (!$this->request->isPost()) {
      return $this->response->redirect("bc_sede_contrato/");
    }

    $db = $this->getDI()->getDb();
    $config = $this->getDI()->getConfig();

    $ultima_sede = $db->query("SELECT MAX(id_sede) AS id_sede FROM bc_sede_contrato");
    $ultima_sede->setFetchMode(Phalcon\Db::FETCH_OBJ);
    foreach($ultima_sede->fetchAll() as $key => $row){
      $ultimo_id_sede = $row->id_sede;
    }

    $ultimo_id_sede_contrato = $db->query("SELECT MAX(id_sede_contrato) AS id_sede_contrato FROM bc_sede_contrato");
    $ultimo_id_sede_contrato->setFetchMode(Phalcon\Db::FETCH_OBJ);
    foreach($ultimo_id_sede_contrato->fetchAll() as $key => $row){
      $id_sede_contrato = $row->id_sede_contrato;
    }


    $bc_oferente =  BcOferente::findFirstByid_contrato($this->request->getPost("id_contrato"));
    $bc_sede_contrato =  new BcSedeContrato();
    $bc_sede_contrato->id_sede_contrato = $id_sede_contrato+1;
    $bc_sede_contrato->id_oferente = $bc_oferente->id_oferente;
    $bc_sede_contrato->oferente_nombre = $bc_oferente->oferente_nombre;
    $bc_sede_contrato->id_contrato = $bc_oferente->id_contrato;
    $bc_sede_contrato->id_sede = $ultimo_id_sede+1;
    $bc_sede_contrato->sede_nombre = $this->request->getPost("sede_nombre");
    $bc_sede_contrato->sede_barrio = $this->request->getPost("sede_barrio");
    $bc_sede_contrato->sede_comuna = $this->request->getPost("sede_comuna");
    $bc_sede_contrato->sede_direccion = $this->request->getPost("sede_direccion");
    $bc_sede_contrato->sede_telefono = $this->request->getPost("sede_telefono");
    $bc_sede_contrato->id_modalidad =  $bc_oferente->id_modalidad;
    $bc_sede_contrato->modalidad_nombre =  $bc_oferente->modalidad_nombre;
    $bc_sede_contrato->estado =  1;
    if (!$bc_sede_contrato->save()) {
      foreach ($bc_sede_contrato->getMessages() as $message) {
        $this->flash->error($message);
      }
      return $this->response->redirect("bc_sede_contrato/nuevo");
    }
    $this->flash->success("La sede fue creada exitosamente.");
    return $this->response->redirect("bc_sede_contrato/");
  }

  public function beneficiariosAction()
  {
    if (isset($this->usuario)) {

      $beneficiarios = CobOferentePersonaSimat::find([
        'id_contrato = '. $this->usuario.' and estado_activo = 1', 'order' => 'estado_certificacion desc' ]);

      $db = $this->getDI()->getDb();
      $config = $this->getDI()->getConfig();

       $count_beneficiarios = CobOferentePersonaSimat::count([
        'id_contrato = '. $this->usuario.' and estado_activo = "1"']);

       $beneficiarios_totales = CobOferentePersonaSimat::count([
        'id_contrato = '. $this->usuario.' and estado_activo = "1"']);

        $beneficiarios_activos = CobOferentePersonaSimat::count([
          'id_contrato = '. $this->usuario.' and estado_certificacion = "1" and estado_activo = "1"']);


        $beneficiariosEliminados = CobOferentePersonaEliminado::count([
          'id_contrato = '. $this->usuario]);

        $beneficiarios_contrato = $db->query(
            "SELECT cob_periodo_contratosedecupos.cuposTotal,
                    bc_sede_contrato.id_modalidad,
                    bc_sede_contrato.oferente_nombre,
                    cob_periodo_contratosedecupos.cuposSostenibilidad
            FROM  cob_periodo_contratosedecupos
            jOIN bc_sede_contrato on bc_sede_contrato.id_sede_contrato = cob_periodo_contratosedecupos.id_sede_contrato
            WHERE bc_sede_contrato.id_contrato = $this->usuario
            order by id_periodo desc
            limit 0,1");
        $beneficiarios_contrato->setFetchMode(Phalcon\Db::FETCH_OBJ);

        foreach ($beneficiarios_contrato->fetchAll() as $key => $value) {
          $cuposTotal=$value->cuposSostenibilidad;
          $id_modalidad=$value->id_modalidad;
          $oferente=$value->oferente_nombre;
        }

        $sedes = BcSedeContrato::find(['id_contrato = '. $this->usuario, 'order' => 'oferente_nombre asc']);
        $modalidad = BcModalidad::find(['id_modalidad = '. $id_modalidad]);

        $sedes_array = array();
        foreach ($sedes as $row) {
          $sedes_array[$row->id_sede] = $row->sede_nombre;
        }

        $porcentaje_cobertura= bcdiv((($beneficiarios_activos/ $cuposTotal)*100),"1",2);
        $this->view->beneficiarios = $beneficiarios;
        $this->view->total_beneficiarios = $count_beneficiarios;
        $this->view->beneficiarios_activos = $beneficiarios_activos;
        $this->view->beneficiarios_totales = $beneficiarios_totales;
        $this->view->beneficiarios_retirado = $beneficiariosEliminados;
        $this->view->cuposTotal =$cuposTotal;
        $this->view->modalidad =  $modalidad;
        $this->view->oferente =   $oferente;
        $this->view->porcentaje_cobertura =   $porcentaje_cobertura;
        // $this->view->sedes = $sedes_array;
        $this->view->id_contrato = $this->usuario;
        $this->view->fecha_fin_eliminado = date('Y-m-d');
        // $this->view->jornada = $this->elements->getSelect("jornada");
        // $this->view->sino = $this->elements->getSelect("sino");
        // $this->view->grados = $this->elements->getSelect("numeroGrados");
        // $this->view->grupos = $this->elements->getSelect("numeroGrupos");
        $this->assets->addJs('js/beneficiarios-oferente.js')
        ->addJs('js/jquery.fixedtableheader.min.js')
        ->addJs('js/alasql.min.js')
        // ->addJs('js/jquery.tablesorter.min.js')
        // ->addJs('js/jquery.tablesorter.widgets.js')
        ->addJs('js/xlsx.core.min.js');
        $this->assets
        ->addJs('js/parsley.min.js')
        ->addJs('js/parsley.extend.js')
        ->addJs('js/editarEvidencia.js');
      }
  }

  public function editar_personaAction()
  {

      $id_persona = $_GET['id_persona'];
      $sedes = BcSedeContrato::find(['id_contrato = '. $this->usuario, 'order' => 'oferente_nombre asc']);
      $beneficiario = CobOferentePersonaSimat::findFirst(['id_oferente_persona= '.  $id_persona]);

      $sedes_array = array();
      foreach ($sedes as $row) {
        $sedes_array[$row->id_sede] = $row->sede_nombre;
      }

       $grupo =substr($beneficiario->grupo_simat, -2);
      $this->view->jornada = $this->elements->getSelect("jornada");
      $this->view->tipo_documento = $this->elements->getSelect("tipo_documento");
      $this->view->grupos_simat =  $this->elements->getSelect("grupos_simat");
      $this->view->grados_simat = $this->elements->getSelect("grados_simat");
      $this->view->matricula_simat = $this->elements->getSelect("matricula_simat");
      $this->view->sedes = $sedes_array;
      $this->view->beneficiario = $beneficiario;
      $this->view->grupo = $grupo;

  }

  public function guardar_update_beneficiarioAction()
  {
      if (!$this->request->isPost()) {
        return $this->response->redirect("bc_sede_contrato/");
      }

      // return $this->request->getPost("id_oferente_persona");
      // $elementos = array(
        $id_oferente_persona = (int)$this->request->getPost("id_oferente_persona");
        $tipo_documento = $this->request->getPost("tipo_documento");
        $nombre1 = $this->request->getPost("nombre1");
        $nombre2 = $this->request->getPost("nombre2");
        $apellido1 = $this->request->getPost("apellido1");
        $apellido2 = $this->request->getPost("apellido2");
        $id_sede = $this->request->getPost("id_sede");
        $nombre_sede = $this->request->getPost("nombre_sede");
        $id_jornada = $this->request->getPost("id_jornada");
        $nombre_jornada = $this->request->getPost("nombre_jornada");
        $grado_cod_simat = $this->request->getPost("grado_cod_simat");
        $grupo_simat =  $grado_cod_simat.$this->request->getPost("grupo_simat");
        $codigo_dane = $this->request->getPost("codigo_dane");
        $matricula_simat = "SI";
        // $observaciones = $this->request->getPost("observaciones");
      // );

      $db = $this->getDI()->getDb();

      $query = $db->query("UPDATE cob_oferente_persona_simat
          SET
            tipo_documento='$tipo_documento',
            nombre1='$nombre1',
            nombre2='$nombre2',
            apellido1='$apellido1',
            apellido2='$apellido2',
            id_sede='$id_sede',
            nombre_sede='$nombre_sede',
            id_jornada='$id_jornada',
            nombre_jornada='$nombre_jornada',
            grado_cod_simat='$grado_cod_simat',
            grupo_simat='$grupo_simat',
            codigo_dane='$codigo_dane',
            matricula_simat='$matricula_simat'
            -- observaciones='$observaciones'
          WHERE id_oferente_persona='$id_oferente_persona'");


      // $sql = $this->conversiones->multipleupdate("cob_oferente_persona_simat", $elementos, "id_oferente_persona");
      //  var_dump($sql);
      // $query = $db->query($sql);
      if (!$query) {
        foreach ($query->getMessages() as $message) {
          $this->flash->error($message);
        }
        return $this->response->redirect("bc_sede_contrato/beneficiarios");
      }
      $this->flash->success("Él beneficiario fue actualizado exitosamente");
      return $this->response->redirect("bc_sede_contrato/beneficiarios");
  }

  public function guardarbeneficiariosAction()
  {

      // $this->view->disable();

      if (!$this->request->isPost()) {
        return $this->response->redirect("bc_sede_contrato/");
      }

      // return $this->request->getPost("id_oferente_persona");
      $elementos = array(
        'id_oferente_persona' => $this->request->getPost("id_oferente_persona"),
        'id_sede' => $this->request->getPost("id_sede"),
        'jornada' => $this->request->getPost("jornada"),
        'grado' => $this->request->getPost("grado"),
        'grupo' => $this->request->getPost("grupo"),
        'matriculadoSimat' => $this->request->getPost("matriculadoSimat"),
        'retirado' => $this->request->getPost("retirado")
      );

      $db = $this->getDI()->getDb();
      // $id_sede = $this->request->getPost("id_sede");
      // $jornada = $this->request->getPost("jornada");
      // $grado = $this->request->getPost("grado");
      // $grupo = $this->request->getPost("grupo");
      // $matriculadoSimat = $this->request->getPost("matriculadoSimat");
      // $retirado = $this->request->getPost("retirado");
      // $id_oferente_persona = $this->request->getPost("id_oferente_persona");
      // // var_dump($this->request->getPost("grado"));
      // for ($i=0; $i < count($this->request->getPost("id_oferente_persona")); $i++) {
      //   $db = $this->getDI()->getDb();
      //   $query = $db->query("UPDATE cob_oferente_persona
      //     SET
      //     id_sede='$id_sede[$i]',
      //     jornada='$jornada[$i]',
      //     grado='$grado[$i]',
      //     grupo='$grupo[$i]',
      //     matriculadoSimat='$matriculadoSimat[$i]',
      //     retirado='$retirado[$i]'
      //     WHERE id_oferente_persona='$id_oferente_persona[$i]'
      //     ");
      //   }
      // var_dump($elementos);

      $sql = $this->conversiones->multipleupdate("cob_oferente_persona", $elementos, "id_oferente_persona");
      // var_dump($sql)
      $query = $db->query($sql);
      if (!$query) {
        foreach ($query->getMessages() as $message) {
          $this->flash->error($message);
        }
        return $this->response->redirect("bc_sede_contrato/beneficiarios");
      }
      $this->flash->success("Los beneficiarios fueron actualizados exitosamente");
      return $this->response->redirect("bc_sede_contrato/beneficiarios");
  }

  public function crearBeneficiarioAction()
  {
      $documento =$this->request->getPost("documento");
      $activos =(int)$this->request->getPost("activos");
      $cuposTotal =(int)$this->request->getPost("cuposTotal");

      if ($activos>=$cuposTotal) {
        $this->flash->error("No es posible registrar un estudiante nuevo, su cobertura se encuentra al 100%");
        return $this->response->redirect("bc_sede_contrato/beneficiarios");
      }

      $beneficiario_simat = CobOferentePersonaSimat::findFirst([
          'columns'    => '*',
          'conditions' => 'documento = ?1 AND estado_activo = ?2',
          'bind'       => [
              1 => $documento,
              2 => 1,
          ]
      ]);
        if (!empty($beneficiario_simat)) {
          $this->flash->error("El documento ". $documento ." ya se encuentra registrado en su contrato o en otro contrato");
          return $this->response->redirect("bc_sede_contrato/beneficiarios");
        }

      $beneficiario = CobComitePersona::findFirst([
        'columns'    => '*',
        'conditions' => 'documento_identidad = ?1 AND id_contrato = ?2',
        'bind'       => [
            1 => $documento,
            2 => $this->usuario,
        ]
    ]);

    if (empty($beneficiario)) {
      $this->flash->error("El documento ". $documento ." no se encuentra registrado en ningún comité asociado a su contrato");
      return $this->response->redirect("bc_sede_contrato/beneficiarios");
    }

    $sedes = BcSedeContrato::find(['id_contrato = '. $this->usuario, 'order' => 'oferente_nombre asc']);
    $oferente = BcOferente::findFirst(['id_contrato= '.  $this->usuario]);

    $sedes_array = array();
    foreach ($sedes as $row) {
      $sedes_array[$row->id_sede] = $row->sede_nombre;
    }

    $fecha_inicio_min = new DateTime(date('Y-m-d'));
    $fecha_inicio_min->modify('-30 day');
    $fecha_fin_max = date('Y-m-d');


    $this->view->fecha_inicio_min=$fecha_inicio_min->format('Y-m-d');
    $this->view->fecha_fin_max=$fecha_fin_max;
    $this->view->fecha_fin=date('Y-m-d');
    $this->view->beneficiario = $beneficiario;
    $this->view->id_contrato =  $this->usuario;
    $this->view->jornada = $this->elements->getSelect("jornada");
    $this->view->tipo_documento = $this->elements->getSelect("tipo_documento");
    $this->view->grupos_simat = $this->elements->getSelect("grupos_simat");
    $this->view->grados_simat = $this->elements->getSelect("grados_simat");
    $this->view->matricula_simat = $this->elements->getSelect("matricula_simat");
    $this->view->estado_simat = $this->elements->getSelect("estado_simat");
    $this->view->jerarquia = $this->elements->getSelect("jerarquia");
    $this->view->oferente = $oferente;
    $this->view->prestacion_servicio = $this->elements->getSelect("prestacion_servicio");
    $this->view->calendario = $this->elements->getSelect("calendario");
    $this->view->sector = $this->elements->getSelect("sector");
    $this->view->modelo = $this->elements->getSelect("modelo");
    $this->view->estrato = $this->elements->getSelect("estrato");
    $this->view->genero = $this->elements->getSelect("genero");
    $this->view->matricula_contratada = $this->elements->getSelect("matricula_simat");
    $this->view->apoyo_acadmico_especial = $this->elements->getSelect("apoyo_academico");
    $this->view->srpa = $this->elements->getSelect("srpa");
    $this->view->zona_sede = $this->elements->getSelect("zona_sede");
    $this->view->tipo_sangre = $this->elements->getSelect("RH");
    $this->view->sedes = $sedes_array;
    $this->assets
			->addJs('js/parsley.min.js')
			->addJs('js/parsley.extend.js')
			->addJs('js/crearBeneficiario.js');
    // $this->view->beneficiario = $beneficiario;
  }

  public function guardar_beneficiarioAction()
  {
    if (!$this->request->isPost()) {
      return $this->response->redirect("bc_sede_contrato/");
    }

    $sede = BcSedeContrato::findFirst(['id_sede = '.  $this->request->getPost("id_sede")]);

    $beneficiario = CobOferentePersonaSimat::findFirst([
        'columns'    => '*',
        'conditions' => 'documento = ?1 AND estado_activo = ?2',
        'bind'       => [
            1 => $this->request->getPost("documento"),
            2 => 0,
        ]
    ]);

    if (empty($beneficiario)) {
      $beneficiario = new CobOferentePersonaSimat();
    }

    $fecha_fin = date('Y').'-12-31';
    $beneficiario->id_contrato = $this->request->getPost("id_contrato");
    $beneficiario->ano = date("Y");
    $beneficiario->etc = $this->request->getPost("etc");
    // $beneficiario->estado = $this->request->getPost("estado");
    $beneficiario->jerarquia = $this->request->getPost("jerarquia");
    $beneficiario->id_modalidad = $sede->id_modalidad;
    $beneficiario->modalidad_nombre =$sede->modalidad_nombre;
    $beneficiario->id_oferente = $sede->id_oferente;
    $beneficiario->institucion = $this->request->getPost("institucion");
    $beneficiario->codigo_dane = $this->request->getPost("codigo_dane");
    $beneficiario->prestacion_servicio = $this->request->getPost("prestacion_servicio");
    $beneficiario->calendario = $this->request->getPost("calendario");
    $beneficiario->sector = $this->request->getPost("sector");
    $beneficiario->sede_simat = $this->request->getPost("institucion");
    $beneficiario->codigo_dane_sede = $this->request->getPost("codigo_dane");
    $beneficiario->zona_sede = $this->request->getPost("zona_sede");
    // $beneficiario->jornada_simat = $this->request->getPost("id_jornada");
    $beneficiario->grado_cod_simat = $this->request->getPost("grado_cod_simat");
    $beneficiario->grupo_simat =  $this->request->getPost("grado_cod_simat").$this->request->getPost("grupo_simat");
    $beneficiario->modelo = $this->request->getPost("modelo");
    // $beneficiario->motivo = $this->request->getPost("motivo");borrar
    $beneficiario->fecha_ini = $this->request->getPost("fecha_ini");
    $beneficiario->fecha_fin = $fecha_fin;
    // $beneficiario->nui = $this->request->getPost("nui");borrar
    $beneficiario->estrato = $this->request->getPost("estrato");
    $beneficiario->sisben_tres = strval($this->request->getPost("sisben_tres"));
    // $beneficiario->id_persona_simat = $this->request->getPost("id_persona_simat");
    $beneficiario->documento = $this->request->getPost("documento");
    $beneficiario->tipo_documento = $this->request->getPost("tipo_documento");
    $beneficiario->apellido1 = $this->request->getPost("apellido1");
    $beneficiario->apellido2 = $this->request->getPost("apellido2");
    $beneficiario->nombre1 = $this->request->getPost("nombre1");
    $beneficiario->nombre2 = $this->request->getPost("nombre2");
    $beneficiario->genero = $this->request->getPost("genero");
    $beneficiario->fecha_nacimiento = $this->request->getPost("fecha_nacimiento");
    $beneficiario->barrio = $this->request->getPost("barrio");
    $beneficiario->eps = $this->request->getPost("eps");
    $beneficiario->tipo_sangre = $this->request->getPost("tipo_sangre");
    // $beneficiario->matricula_contratada = $this->request->getPost("matricula_contratada");
    $beneficiario->fuente_recursos = "SGP";
    // $beneficiario->internado = $this->request->getPost("internado");
    $beneficiario->internado = 'NINGUNO';
    $beneficiario->matricula_simat = 'SI';
    $beneficiario->apoyo_acadmico_especial = $this->request->getPost("apoyo_acadmico_especial");
    // $beneficiario->srpa = $this->request->getPost("srpa");
    $beneficiario->correo = $this->request->getPost("correo");
    $beneficiario->discapacidad = $this->request->getPost("discapacidad");
    $beneficiario->pais_origen = $this->request->getPost("pais_origen");
    $beneficiario->id_sede = $this->request->getPost("id_sede");
    $beneficiario->nombre_sede =$sede->sede_nombre;
    $beneficiario->id_jornada = $this->request->getPost("id_jornada");
    $beneficiario->nombre_jornada = $this->request->getPost("nombre_jornada");
    $beneficiario->ingreso = trim($this->request->getPost("ingreso"));
    $beneficiario->urlEvidenciaMatricula = $this->request->getPost("urlEvidenciaAtencion");
    $beneficiario->observaciones_prematricula = $this->request->getPost("observaciones_prematricula");
    $beneficiario->estado_activo = 1;
    $beneficiario->estado_certificacion = 2;
    $beneficiario->fecha_pre_matricula = date('Y-m-d');

    if (!$beneficiario->save()) {
      foreach ($beneficiario->getMessages() as $message) {
        $this->flash->error($message);
      }
      return $this->response->redirect("bc_sede_contrato/beneficiarios");
    }
    $this->flash->success("El beneficiario fue creado exitosamente.");
    return $this->response->redirect("bc_sede_contrato/beneficiarios");

  }

  public function eliminarAction($id_oferente_persona)
  {
    if (!$this->request->isPost()) {
      return $this->response->redirect("bc_sede_contrato/beneficiario");
    }

      $id_oferente_persona = (int)$this->request->getPost("id_oferente_persona");
      $observaciones = $this->request->getPost("observaciones");
      // $fecha= strval(date('Y')."-".date('m')."-".date('d'));
      $fecha= date('Y-m-d');

    $db = $this->getDI()->getDb();

    // $query = $db->query("UPDATE cob_oferente_persona_simat
    //     SET
    //       observaciones_retiro='$observaciones',
    //       fecha_retiro= '$fecha',
    //       estado_activo=0
    //     WHERE id_oferente_persona='$id_oferente_persona'");

    $beneficiario = CobOferentePersonaSimat::findFirst(['id_oferente_persona = '.  $id_oferente_persona]);
    $beneficiario->observaciones_retiro = $observaciones;
    $beneficiario->fecha_retiro = $fecha;
    $beneficiario->estado_activo= 0;

    $beneficiarioEliminado = new CobOferentePersonaEliminado();
    $beneficiarioEliminado->id_contrato = $beneficiario->id_contrato;
    $beneficiarioEliminado->ano = $beneficiario->ano;
    $beneficiarioEliminado->etc = $beneficiario->etc;
    $beneficiarioEliminado->estado = $beneficiario->estado;
    $beneficiarioEliminado->jerarquia = $beneficiario->jerarquia;
    $beneficiarioEliminado->institucion = $beneficiario->institucion;
    $beneficiarioEliminado->codigo_dane = $beneficiario->codigo_dane;
    $beneficiarioEliminado->prestacion_servicio = $beneficiario->prestacion_servicio;
    $beneficiarioEliminado->calendario = $beneficiario->calendario;
    $beneficiarioEliminado->sector = $beneficiario->sector;
    $beneficiarioEliminado->sede_simat = $beneficiario->institucion;
    $beneficiarioEliminado->codigo_dane_sede = $beneficiario->codigo_dane;
    $beneficiarioEliminado->zona_sede = $beneficiario->zona_sede;
    $beneficiarioEliminado->grado_cod_simat = $beneficiario->grado_cod_simat;
    $beneficiarioEliminado->grupo_simat =  $beneficiario->grupo_simat;
    $beneficiarioEliminado->modelo = $beneficiario->modelo;
    $beneficiarioEliminado->fecha_ini = $beneficiario->fecha_ini;
    $beneficiarioEliminado->fecha_fin = $beneficiario->fecha_fin;
    $beneficiarioEliminado->estrato = $beneficiario->estrato;
    $beneficiarioEliminado->sisben_tres = $beneficiario->sisben_tres;
    $beneficiarioEliminado->documento = $beneficiario->documento;
    $beneficiarioEliminado->tipo_documento = $beneficiario->tipo_documento;
    $beneficiarioEliminado->apellido1 = $beneficiario->apellido1;
    $beneficiarioEliminado->apellido2 = $beneficiario->apellido2;
    $beneficiarioEliminado->nombre1 = $beneficiario->nombre1;
    $beneficiarioEliminado->nombre2 = $beneficiario->nombre2;
    $beneficiarioEliminado->genero = $beneficiario->genero;
    $beneficiarioEliminado->fecha_nacimiento = $beneficiario->fecha_nacimiento;
    $beneficiarioEliminado->barrio = $beneficiario->barrio;
    $beneficiarioEliminado->eps = $beneficiario->eps;
    $beneficiarioEliminado->tipo_sangre = $beneficiario->tipo_sangre;
    $beneficiarioEliminado->matricula_contratada =$beneficiario->matricula_contratada;
    $beneficiarioEliminado->fuente_recursos = $beneficiario->fuente_recursos;
    $beneficiarioEliminado->internado = $beneficiario->internado;
    $beneficiarioEliminado->matricula_simat = $beneficiario->matricula_simat;
    $beneficiarioEliminado->apoyo_acadmico_especial = $beneficiario->apoyo_acadmico_especial;
    $beneficiarioEliminado->srpa = $beneficiario->srpa;
    $beneficiarioEliminado->correo = $beneficiario->correo;
    $beneficiarioEliminado->discapacidad = $beneficiario->discapacidad;
    $beneficiarioEliminado->pais_origen = $beneficiario->pais_origen;
    $beneficiarioEliminado->id_sede = $beneficiario->id_sede;
    $beneficiarioEliminado->nombre_sede =$beneficiario->nombre_sede;
    $beneficiarioEliminado->id_jornada = $beneficiario->id_jornada;
    $beneficiarioEliminado->nombre_jornada = $beneficiario->nombre_jornada;
    $beneficiarioEliminado->ingreso = $beneficiario->ingreso;
    $beneficiarioEliminado->urlEvidenciaMatricula = $beneficiario->urlEvidenciaMatricula;
    $beneficiarioEliminado->observaciones_prematricula =  $beneficiario->observaciones_prematricula;
    $beneficiarioEliminado->fecha_retiro =   $fecha;
    $beneficiarioEliminado->observaciones_retiro = $observaciones;
    $beneficiarioEliminado->estado_activo= 0;
    $beneficiarioEliminado->save();

    if (!$beneficiario->save()) {
      foreach ($beneficiario->getMessages() as $message) {
        $this->flash->error($message);
      }
      return $this->response->redirect("bc_sede_contrato/beneficiarios");
    }
    $this->flash->success("Él estudiante fue eliminado exitosamente");
    return $this->response->redirect("bc_sede_contrato/beneficiarios");
  }

  public function subirEvidenciaAction($documento) {
		$this->view->disable();
		$tipos = array("image/png", "image/jpeg", "image/jpg", "image/bmp", "image/gif", "application/pdf", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/vnd.ms-excel", "application/vnd.openxmlformatsofficedocument.spreadsheetml.sheet");
		if ($this->request->isPost()) {
			if ($this->request->hasFiles() == true) {
				$uploads = $this->request->getUploadedFiles();
				$isUploaded = false;
				foreach($uploads as $upload){
					if(!$upload->getName()){
						continue;
					}
					if(in_array($upload->gettype(), $tipos)){
						$nombre = $documento.date("ymdHis").".".$upload->getextension();
						$tamano_archivo=$upload->getsize();
						$peso_mb=100;
						$tamano_maximo = $peso_mb*1024*1024;
						$path = "files/excusas/".$nombre;
						if ($tamano_archivo>$tamano_maximo) {
							echo "Peso";
							exit;
						}
						($upload->moveTo($path)) ? $isUploaded = true : $isUploaded = false;
					} else {
						echo "Tipo";
						exit;
					}
				}
				if($isUploaded){
					chmod($path, 0777);
					echo $nombre;

				} else {
					echo "Error";
				}
			}else {
				return "Error";
			}
		}
  }

  public function solicitudEditarDocumentoAction()
  {
    if (!$this->request->isPost()) {
      return $this->response->redirect("bc_sede_contrato/beneficiarios");
    }

    $beneficiario_validacion = CobOferentePersonaSimat::findFirst(['documento = '.  $this->request->getPost("documento_nuevo")]);
    if (!empty($beneficiario_validacion)) {
      $this->flash->error("El nuevo documento que intenta ingresar ya esta registrado a nombre de otra persona en el sistema, con el operador ".  $beneficiario_validacion->institucion);
      return $this->response->redirect("bc_sede_contrato/beneficiarios");
    }

    $beneficiario_editado = CobEditarDocPersona::findFirst(['documento_anterior = '.  $this->request->getPost("documento_anterior")]);

    if (!empty($beneficiario_editado)) {
      $this->flash->error("El documento que intenta editar se modificó recientemente y no es posible editarlo, si cree que aún hay un error comuníquese con el administdor del sistema".  $beneficiario_validacion->institucion);
      return $this->response->redirect("bc_sede_contrato/beneficiarios");
    }

    $beneficiario = CobOferentePersonaSimat::findFirst(['documento = '.  $this->request->getPost("documento_anterior")]);

    $edit_documento = new CobEditarDocPersona();
    $edit_documento->id_contrato = $this->request->getPost("id_contrato");
    $edit_documento->id_oferente_persona = $beneficiario->id_oferente_persona;
    $edit_documento->documento_anterior = $this->request->getPost("documento_anterior");
    $edit_documento->documento_nuevo = $this->request->getPost("documento_nuevo");
    $edit_documento->urlEvidenciaDoc = $this->request->getPost("urlEvidenciaDoc");
    $edit_documento->estado = 1;


    if (!$edit_documento->save()) {
      foreach ($edit_documento->getMessages() as $message) {
        $this->flash->error($message);
      }
      return $this->response->redirect("bc_sede_contrato/beneficiarios");
    }
    $this->flash->success("La solicitud de edición se realizó satisfactoriamente");
    return $this->response->redirect("bc_sede_contrato/beneficiarios");

  }

  public function modificarDocumentosAction()
  {
      $db = $this->getDI()->getDb();
      $config = $this->getDI()->getConfig();

      $beneficiarios = $db->query(
        "SELECT cob_editar_doc_persona.id_contrato,
                cob_editar_doc_persona.documento_anterior,
                cob_editar_doc_persona.documento_nuevo,
                cob_editar_doc_persona.urlEvidenciaDoc,
                cob_oferente_persona_simat.nombre_sede,
                cob_oferente_persona_simat.institucion,
                cob_oferente_persona_simat.apellido1,
                cob_oferente_persona_simat.apellido2,
                cob_oferente_persona_simat.nombre1,
                cob_oferente_persona_simat.nombre2,
                cob_oferente_persona_simat.id_oferente_persona
        FROM  cob_editar_doc_persona
        jOIN cob_oferente_persona_simat on cob_oferente_persona_simat.id_oferente_persona = cob_editar_doc_persona.id_oferente_persona
        WHERE cob_editar_doc_persona.estado = 1");
      $beneficiarios->setFetchMode(Phalcon\Db::FETCH_OBJ);

      $this->view->beneficiarios = $beneficiarios->fetchAll();
  }

  public function actualizarDocumentoAction()
  {
      if (!$this->request->isPost()) {
         return $this->response->redirect("bc_sede_contrato/modificarDocumentos");
      }

      $db = $this->getDI()->getDb();

      $id_oferente_persona = $this->request->getPost("id_oferente_persona");
      if ($this->request->getPost("estado")==0) {

          $query = $db->query("UPDATE cob_editar_doc_persona
                              SET
                              estado=0
                              WHERE id_oferente_persona='$id_oferente_persona'");
          if (!$query) {
            foreach ($query->getMessages() as $message) {
              $this->flash->error($message);
            }
             return $this->response->redirect("bc_sede_contrato/modificarDocumentos");
          }
      }

      $documento= CobEditarDocPersona::find(['id_oferente_persona='. $id_oferente_persona ]);
      $doc= $documento[0]->documento_nuevo;
      $query = $db->query("UPDATE cob_oferente_persona_simat
                            SET
                            documento = '$doc'
                            WHERE id_oferente_persona='$id_oferente_persona'");

      $query1 = $db->query("UPDATE cob_editar_doc_persona
                            SET
                            estado=0
                            WHERE id_oferente_persona='$id_oferente_persona'");

      if (!$query) {
        foreach ($query->getMessages() as $message) {
          $this->flash->error($message);
        }
         return $this->response->redirect("bc_sede_contrato/modificarDocumentos");
      }
      $this->flash->success("El documento fue actualizado exitosamente");
       return $this->response->redirect("bc_sede_contrato/modificarDocumentos");

  }

  public function solicitudMatriculaAction(){
    //Estado certificado 1= Matricualdo(amariillo), 2=Pre-matriculado(verde), 3=Rechazado(rojo) 
    $beneficiarios = CobOferentePersonaSimat::find([
      'estado_certificacion =2 and estado_activo = 1']);

    $this->view->beneficiarios = $beneficiarios;
    $this->view->error_archivo = $this->elements->getSelect("error_archivo");;

  }

  public function cambiarEstadoMatriculaAction()
  {
    if (!$this->request->isPost()) {
      return $this->response->redirect("bc_sede_contrato/solicitudMatricula");
    }

    $beneficiario = CobOferentePersonaSimat::findFirst(['id_oferente_persona = '.  $this->request->getPost("id_oferente_persona")]);
    $beneficiario->estado_certificacion= $this->request->getPost("estado_certificacion");
    $beneficiario->motivo_certificacion= $this->request->getPost("error_archivo");

    if (!$beneficiario->save()) {
      foreach ($beneficiario->getMessages() as $message) {
        $this->flash->error($message);
      }
      return $this->response->redirect("bc_sede_contrato/solicitudMatricula");
    }
    $result = $this->request->getPost("estado_certificacion") ==1? "confirmada": "rechazada";
    $this->flash->success("La matricula fue ".$result." exitosamente.");
    return $this->response->redirect("bc_sede_contrato/solicitudMatricula");

  }

  public function editarEvidenciaSimatAction()
  {
    if (!$this->request->isPost()) {
      return $this->response->redirect("bc_sede_contrato/beneficiarios");
    }

    $beneficiario = CobOferentePersonaSimat::findFirst(['id_oferente_persona = '.  $this->request->getPost("id_oferente_persona")]);
    $beneficiario->urlEvidenciaMatricula= $this->request->getPost("urlEvidenciaAtencion");
    $beneficiario->estado_certificacion= 2;

    if (!$beneficiario->save()) {
      foreach ($beneficiario->getMessages() as $message) {
        $this->flash->error($message);
      }
      return $this->response->redirect("bc_sede_contrato/beneficiarios");
    }
    $this->flash->success("El documento se adjunto exitosamente.");
    return $this->response->redirect("bc_sede_contrato/beneficiarios");

  }


  //--------------------Crud Sede Contrato -----------------------------


  //Consultar las sedes por contrato
  public function sedeContratoAction(){
    if (isset($this->usuario)) {

      // count de esta consulta
      $sedes_contratos = BcSedeContrato::find(['estado= 1', 'order' => 'id_contrato asc']);

        $this->view->sedes_contratos = $sedes_contratos;
        $this->assets->addJs('js/beneficiarios-oferente.js')
        ->addJs('js/jquery.fixedtableheader.min.js')
        ->addJs('js/alasql.min.js')
        ->addJs('js/xlsx.core.min.js');
        $this->assets
        ->addJs('js/parsley.min.js')
        ->addJs('js/parsley.extend.js');
      }
  }

  public function eliminarSedeAction(){

      if (!$this->request->isPost()) {
        return $this->response->redirect("bc_sede_contrato/sedeContrato");
      }

      $id_sede_contrato=$this->request->getPost("id_sede_contrato");
      $db = $this->getDI()->getDb();

      $query = $db->query("UPDATE bc_sede_contrato
          SET
          estado=0
          WHERE id_sede_contrato='$id_sede_contrato'");

      if (!$query) {
        foreach ($query->getMessages() as $message) {
          $this->flash->error($message);
        }
        return $this->response->redirect("bc_sede_contrato/sedeContrato");
      }
      $this->flash->success("La sede fue eliminada exitosamente");
      return $this->response->redirect("bc_sede_contrato/sedeContrato");

  }

  public function crearSedeAction()
  {
    if (isset($this->usuario)) {
      $oferentes = BcOferente::find();
      $modalidades = BcModalidad::find();
      $this->view->oferentes = $oferentes;
      $this->view->modalidades = $modalidades;
    }
  }
  public function consultarContratosAction()
  {
    if (isset($this->usuario)) {
      $this->view->disable();
      $id_oferente = $_GET['valor_busqueda'];
      $contratos = BcSedeContrato::find(['id_oferente='. $id_oferente]);  
      echo json_encode($contratos);
    }
  }

  public function guardarSedeContratoAction()
  {
    if (!$this->request->isPost()) {
      return $this->response->redirect("bc_sede_contrato/sedeContrato");
    }

    $id_sede = BcSedeContrato::findFirst(['order' => 'id_sede desc']);

    $sede_contrato = new BcSedeContrato();
    $idSede= (int)$id_sede->id_sede + 1;
    $sede_contrato->id_oferente = $this->request->getPost("id_oferente");
    $sede_contrato->oferente_nombre = $this->request->getPost("oferente_nombre");
    $sede_contrato->id_contrato = $this->request->getPost("id_contrato");
    $sede_contrato->id_sede = $idSede;
    $sede_contrato->sede_nombre = $this->request->getPost("sede_nombre");
    $sede_contrato->sede_barrio = $this->request->getPost("sede_barrio");
    $sede_contrato->sede_comuna = $this->request->getPost("sede_comuna");
    $sede_contrato->sede_direccion = $this->request->getPost("sede_direccion");
    $sede_contrato->sede_telefono = $this->request->getPost("sede_telefono");
    $sede_contrato->id_modalidad = $this->request->getPost("id_modalidad");
    $sede_contrato->modalidad_nombre = $this->request->getPost("modalidad_nombre");
    $sede_contrato->cuposSostenibilidad = $this->request->getPost("cuposSostenibilidad");
    $sede_contrato->estado = 1;

    if (!$sede_contrato->save()) {
      foreach ($sede_contrato->getMessages() as $message) {
        $this->flash->error($message);
      }
      return $this->response->redirect("bc_sede_contrato/sedeContrato");
    }
    $this->flash->success("La sede fue creada exitosamente.");
    return $this->response->redirect("bc_sede_contrato/sedeContrato");

  }

  public function editarSedeAction()
  {
    if (isset($this->usuario)) {
      $id_sede_contrato = $_GET['id_sede_contrato'];
      $sedeContrato = BcSedeContrato::findFirst(['id_sede_contrato = '. $id_sede_contrato]);
      $oferentes = BcOferente::find();
      $modalidades = BcModalidad::find();
      $this->view->oferentes = $oferentes;
      $this->view->modalidades = $modalidades;
      $this->view->sedeContrato = $sedeContrato;
    }
  }

  public function guardarEdicionSedeAction()
  {
    if (!$this->request->isPost()) {
      return $this->response->redirect("bc_sede_contrato/sedeContrato");
    }

    // return $this->request->getPost("id_oferente_persona");
    // $elementos = array(
      $id_sede_contrato = (int)$this->request->getPost("id_sede_contrato");
      $id_oferente = $this->request->getPost("id_oferente");
      $oferente_nombre = $this->request->getPost("oferente_nombre");
      $id_contrato = $this->request->getPost("id_contrato");
      $sede_nombre = $this->request->getPost("sede_nombre");
      $sede_barrio = $this->request->getPost("sede_barrio");
      $sede_comuna = $this->request->getPost("sede_comuna");
      $sede_direccion = $this->request->getPost("sede_direccion");
      $sede_telefono = $this->request->getPost("sede_telefono");
      $id_modalidad = $this->request->getPost("id_modalidad");
      $modalidad_nombre = $this->request->getPost("modalidad_nombre");
      $cuposSostenibilidad = $this->request->getPost("cuposSostenibilidad");
    // );

    $db = $this->getDI()->getDb();

    $query = $db->query("UPDATE bc_sede_contrato
        SET
          id_oferente ='$id_oferente',
          oferente_nombre='$oferente_nombre',
          id_contrato='$id_contrato',
          id_sede='$id_sede_contrato',
          sede_nombre='$sede_nombre',
          sede_barrio='$sede_barrio',
          sede_comuna='$sede_comuna',
          sede_direccion='$sede_direccion',
          sede_telefono='$sede_telefono',
          id_modalidad='$id_modalidad',
          modalidad_nombre='$modalidad_nombre',
          cuposSostenibilidad='$cuposSostenibilidad'
        WHERE id_sede_contrato='$id_sede_contrato'");

    if (!$query) {
      foreach ($query->getMessages() as $message) {
        $this->flash->error($message);
      }
      return $this->response->redirect("bc_sede_contrato/sedeContrato");
    }
    $this->flash->success("La sede fue actualizada exitosamente");
    return $this->response->redirect("bc_sede_contrato/sedeContrato");
  }

}

?>
