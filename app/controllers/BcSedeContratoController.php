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

      // count de esta consulta
      $beneficiarios = CobOferentePersonaSimat::find([
        'id_contrato = '. $this->usuario.' and estado_activo = "1"']);
     
        $db = $this->getDI()->getDb();
      $config = $this->getDI()->getConfig();

       $count_beneficiarios = CobOferentePersonaSimat::count([
        'id_contrato = '. $this->usuario.' and estado_activo = "1"']);

      $beneficiarios_retirado = CobOferentePersonaSimat::count([
        'id_contrato = '. $this->usuario.' and estado != "MATRICULADO" and estado_activo = "1"']);

        $beneficiarios_activos = CobOferentePersonaSimat::count([
          'id_contrato = '. $this->usuario.' and estado = "MATRICULADO" and estado_activo = "1"']);

        $beneficiarios_contrato = $db->query(
            "SELECT cob_periodo_contratosedecupos.cuposTotal, 
                    bc_sede_contrato.id_modalidad,
                    bc_sede_contrato.oferente_nombre 
            FROM  cob_periodo_contratosedecupos
            jOIN bc_sede_contrato on bc_sede_contrato.id_sede_contrato = cob_periodo_contratosedecupos.id_sede_contrato
            WHERE bc_sede_contrato.id_contrato = $this->usuario
            order by id_periodo desc
            limit 0,1");
        $beneficiarios_contrato->setFetchMode(Phalcon\Db::FETCH_OBJ);

        foreach ($beneficiarios_contrato->fetchAll() as $key => $value) {
          $cuposTotal=$value->cuposTotal;
          $id_modalidad=$value->id_modalidad;
          $oferente=$value->oferente_nombre;
        }

        $sedes = BcSedeContrato::find(['id_contrato = '. $this->usuario, 'order' => 'oferente_nombre asc']);
        $modalidad = BcModalidad::find(['id_modalidad = '. $id_modalidad]);

        $sedes_array = array();
        foreach ($sedes as $row) {
          $sedes_array[$row->id_sede] = $row->sede_nombre;
        }

        $porcentaje_cobertura= round(($beneficiarios_activos/ $cuposTotal)*100);
        $this->view->beneficiarios = $beneficiarios;
        $this->view->total_beneficiarios = $count_beneficiarios;
        $this->view->beneficiarios_activos = $beneficiarios_activos;
        $this->view->beneficiarios_retirado = $beneficiarios_retirado;
        $this->view->cuposTotal =$cuposTotal;
        $this->view->modalidad =  $modalidad;
        $this->view->oferente =   $oferente;
        $this->view->porcentaje_cobertura =   $porcentaje_cobertura;
        // $this->view->sedes = $sedes_array;
        $this->view->id_contrato = $this->usuario;
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

      $this->view->jornada = $this->elements->getSelect("jornada");
      $this->view->tipo_documento = $this->elements->getSelect("tipo_documento");
      $this->view->grupos_simat = $this->elements->getSelect("grupos_simat");
      $this->view->grados_simat = $this->elements->getSelect("grados_simat");
      $this->view->matricula_simat = $this->elements->getSelect("matricula_simat");
      $this->view->sedes = $sedes_array;
      $this->view->beneficiario = $beneficiario;
    
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
        $id_jornada = $this->request->getPost("id_jornada");
        $grado_cod_simat = $this->request->getPost("grado_cod_simat");
        $grupo_simat =  $grado_cod_simat.$this->request->getPost("grupo_simat");
        $codigo_dane = $this->request->getPost("codigo_dane");
        $matricula_simat = $this->request->getPost("matricula_simat");
        $observaciones = $this->request->getPost("observaciones");
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
            id_jornada='$id_jornada',
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

    $beneficiario = CobComitePersona::findFirst(['documento_identidad= '.  $documento, 'id_contrato='.  $this->usuario]);
    // // $beneficiario = CobComitePersona::findFirst(['documento_identidad= '.  $documento]);
    if (empty($beneficiario)) {
      $this->flash->error("El documento ". $documento ." no se encuentra registrado en ningún comité asociado a su contrato");
      return $this->response->redirect("bc_sede_contrato/beneficiarios");
    }

    $beneficiario_simat = CobOferentePersonaSimat::findFirst(['documento= '. $documento, 'estado_retirado='. 1]);
    if (!empty($beneficiario_simat)) {
      $this->flash->error("El documento ". $documento ." ya se encuentra registrado en su contrato o en otro contrato");
      return $this->response->redirect("bc_sede_contrato/beneficiarios");
    }

    $sedes = BcSedeContrato::find(['id_contrato = '. $this->usuario, 'order' => 'oferente_nombre asc']);
    $oferente = BcOferente::findFirst(['id_contrato= '.  $this->usuario]);
   
    $sedes_array = array();
    foreach ($sedes as $row) {
      $sedes_array[$row->id_sede] = $row->sede_nombre;
    }

    $this->view->beneficiario = $beneficiario;
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

      if ($this->request->hasFiles()) {
        $files = $this->request->getUploadedFiles();
        // Print the real file names and sizes
        foreach ($files as $file) {
            // Print file details
            $this->logger->info($file->getName(). ' '. $file->getSize());
            // Move the file into the application
            $file->moveTo('img/' . $file->getName());
        }
    }

    $sede = BcSedeContrato::findFirst(['id_sede = '.  $this->request->getPost("id_sede")]);
    
    $beneficiario = new CobOferentePersonaSimat();
    $beneficiario->id_contrato = $this->request->getPost("id_contrato");
    $beneficiario->ano = date("Y");
    $beneficiario->etc = $this->request->getPost("etc");
    $beneficiario->estado = $this->request->getPost("estado");
    $beneficiario->jerarquia = $this->request->getPost("jerarquia");
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
    $beneficiario->fecha_fin = $this->request->getPost("fecha_fin");
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
    $beneficiario->matricula_contratada = $this->request->getPost("matricula_contratada");
    $beneficiario->fuente_recursos = $this->request->getPost("fuente_recursos");
    $beneficiario->internado = $this->request->getPost("internado");
    $beneficiario->matricula_simat = $this->request->getPost("matricula_simat");
    $beneficiario->apoyo_acadmico_especial = $this->request->getPost("apoyo_acadmico_especial");
    $beneficiario->srpa = $this->request->getPost("srpa");
    $beneficiario->correo = $this->request->getPost("correo");
    $beneficiario->discapacidad = $this->request->getPost("discapacidad");
    $beneficiario->pais_origen = $this->request->getPost("pais_origen");
    $beneficiario->id_sede = $this->request->getPost("id_sede");
    $beneficiario->nombre_sede =$sede->sede_nombre;
    $beneficiario->id_jornada = $this->request->getPost("id_jornada");
    $beneficiario->nombre_jornada = $this->request->getPost("id_jornada");
    $beneficiario->ingreso = trim($this->request->getPost("ingreso"));
    $beneficiario->urlEvidenciaMatricula = $this->request->getPost("urlEvidenciaAtencion");
    // $beneficiario->estado_certificacion = $this->request->getPost("estado_certificacion");


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

    $query = $db->query("UPDATE cob_oferente_persona_simat
        SET
          observaciones_retiro='$observaciones',
          fecha_retiro= '$fecha',
          estado_activo=0
        WHERE id_oferente_persona='$id_oferente_persona'");

    if (!$query) {
      foreach ($query->getMessages() as $message) {
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
}

?>
