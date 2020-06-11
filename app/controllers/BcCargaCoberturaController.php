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

      $db = $this->getDI()->getDb();
			$config = $this->getDI()->getConfig();

				$numDocumento = $_GET['valor_busqueda'];
				$beneficiarios = $db->query(
					 "SELECT * FROM cob_comite_persona
					  -- WHERE (documento_identidad = '$numDocumento' or nombreCompleto LIKE '%$numDocumento%') and retirado = 2
					  WHERE id_contrato = '$numDocumento' or documento_identidad = '$numDocumento'");
        $beneficiarios->setFetchMode(Phalcon\Db::FETCH_OBJ);

        
        $beneficiario=$beneficiarios->fetchAll();
        if (empty($beneficiario)) {
          $this->flash->error("No se encontraron beneficiarios con el número de documento o de contrato ". 	$numDocumento );
         	return $this->response->redirect("bc_carga_cobertura/nuevo");
        }

        $this->view->beneficiarios =$beneficiario;
        
			}
  }

  public function guardarbeneficiariosAction()
    {

      if (!$this->request->isPost()) {
        return $this->response->redirect("bc_sede_contrato/nuevo");
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
