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

}
?>
