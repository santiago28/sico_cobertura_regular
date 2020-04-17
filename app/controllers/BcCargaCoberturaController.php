<?php
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;

class BcCargaCoberturaController extends ControllerBase
{
  public function initialize()
  {
    $this->tag->setTitle("Carga Cobertura");
    $auth = $this->session->get('auth');
    parent::initialize();
  }

  public function indexAction()
  {
    $this->persistent->parameters = null;
    $bc_carga = BcCarga::find();
    if (count($bc_carga) == 0) {
      $this->flash->notice("No se ha agregado ninguna carga hasta el momento");
      $bc_carga = null;
    }
    $this->view->bc_carga = $bc_carga;
  }

  public function nuevoAction()
  {
    $bc_sedes_contrato = BcOferente::find();

		$this->view->sedes_contrato = $bc_sedes_contrato;
    $this->view->meses = $this->elements->getSelect("meses");
  }

  /**
  * Para crear una carga, aquí es a donde se dirige el formulario de nuevoAction
  */
  public function crearAction()
  {
    if (!$this->request->isPost()) {
      return $this->response->redirect("bc_carga/");
    }

    $bc_carga = new BcCarga();
    $bc_carga->mes = $this->request->getPost("mes");
    $bc_carga->fecha = date('Y-m-d H:i:s');

    if($this->request->hasFiles() == true){
      $uploads = $this->request->getUploadedFiles();
      $isUploaded = false;
      $i = 1;
      foreach($uploads as $upload){
        $path = "files/bc_bd/".$upload->getname();
        if($i == 1){
          $bc_carga->nombreMat = $upload->getname();
        }
        ($upload->moveTo($path)) ? $isUploaded = true : $isUploaded = false;
        $i++;
      }

      if($isUploaded){
        if (!$bc_carga->save()) {
          foreach ($bc_carga->getMessages() as $message) {
            $this->flash->error($message);
          }

          return $this->response->redirect("bc_carga_cobertura/nuevo");
        }

        // $id_modalidad = $this->request->getPost("id_modalidad");
        // if ($id_modalidad == "1") {
        //   CobPersonaRegular::cargarBdRegularConfesiones($bc_carga);
        // }else if ($id_modalidad == "2") {
        //   CobPersonaRegular::cargarBdRegularAdultos($bc_carga);
        // }else if ($id_modalidad == "3") {
        //   CobPersonaRegular::cargarBdRegularOferentes($bc_carga);
        // }else if ($id_modalidad == "4") {
        //   CobPersonaRegular::cargarBdRegularOtrasPoblaciones($bc_carga);
        // }
        CobPersonaRegular::cargarBdComite($bc_carga);
        
        $this->flash->success("La carga fue realizada exitosamente.");

        return $this->response->redirect("bc_carga_cobertura/");
      } else {
        $this->flash->error("Ocurrió un error al cargar los archivos");
        return $this->response->redirect("bc_carga_cobertura/nuevo");
      }
    }else{
      $this->flash->error("Debes de seleccionar los archivos");
      return $this->response->redirect("bc_carga_cobertura/nuevo");
    }
  }
  
  public function beneficiariosAction()
  {
    if ($this->request->isGet()) {

      $id_contrato =$this->request->get("id_contrato");
      $beneficiarios = CobOferentePersona::find([
        'id_contrato = '. $id_contrato,
        'order' => 'nombreCompleto asc']);

        $beneficiarios_retirado = CobOferentePersona::find([
          'id_contrato = '. $id_contrato.' and retirado = 1']);

          $beneficiarios_activos = CobOferentePersona::find([
            'id_contrato = '. $id_contrato.' and retirado = 2']);

            $db = $this->getDI()->getDb();
		      	$config = $this->getDI()->getConfig();
            $beneficiarios_contrato = $db->query(
               "SELECT cuposTotal, id_modalidad FROM  cob_periodo_contratosedecupos
                jOIN bc_sede_contrato on bc_sede_contrato.id_sede_contrato = cob_periodo_contratosedecupos.id_sede_contrato
                WHERE bc_sede_contrato.id_contrato = $id_contrato
                order by id_periodo desc
                limit 0,1");
            $beneficiarios_contrato->setFetchMode(Phalcon\Db::FETCH_OBJ);

            foreach ($beneficiarios_contrato->fetchAll() as $key => $value) {
              $cuposTotal=$value->cuposTotal;
              $id_modalidad=$value->id_modalidad;
            }

        $sedes = BcSedeContrato::find(['id_contrato = '. $id_contrato, 'order' => 'oferente_nombre asc']);
        $modalidad = BcModalidad::find(['id_modalidad = '. $id_modalidad]);

        $sedes_array = array();
        foreach ($sedes as $row) {
          $sedes_array[$row->id_sede] = $row->sede_nombre;
        }

        $this->view->beneficiarios = $beneficiarios;
        $this->view->total_beneficiarios = count($beneficiarios);
        $this->view->beneficiarios_activos = count($beneficiarios_activos);
        $this->view->beneficiarios_retirado = count($beneficiarios_retirado);
        $this->view->cuposTotal =$cuposTotal;
        $this->view->modalidad =  $modalidad ;
        $this->view->sedes = $sedes_array;
        $this->view->id_contrato = $id_contrato;
        $this->view->jornada = $this->elements->getSelect("jornada");
        $this->view->sino = $this->elements->getSelect("sino");
        $this->view->grados = $this->elements->getSelect("numeroGrados");
        $this->view->grupos = $this->elements->getSelect("numeroGrupos");
        $this->assets->addJs('js/beneficiarios-oferente.js')
        ->addJs('js/jquery.fixedtableheader.min.js')
        ->addJs('js/alasql.min.js')
        // ->addJs('js/jquery.tablesorter.min.js')
        // ->addJs('js/jquery.tablesorter.widgets.js')
        ->addJs('js/xlsx.core.min.js');
      }
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
        return $this->response->redirect("bc_carga_cobertura/beneficiarios");
      }
      $this->flash->success("Los beneficiarios fueron actualizados exitosamente");
      return $this->response->redirect("bc_carga_cobertura/beneficiarios?id_contrato=".$this->request->getPost("id_contrato"));
    }
}
?>
