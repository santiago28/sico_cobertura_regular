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

  public function crearAction(){
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

      //count de esta consulta
      $beneficiarios = CobOferentePersona::find([
        'id_contrato = '. $this->usuario,
        'order' => 'nombreCompleto asc']);

        $beneficiarios_retirado = CobOferentePersona::find([
          'id_contrato = '. $this->usuario.' and retirado = 1']);

          $beneficiarios_activos = CobOferentePersona::find([
            'id_contrato = '. $this->usuario.' and retirado = 2']);

            $db = $this->getDI()->getDb();
		      	$config = $this->getDI()->getConfig();
            $beneficiarios_contrato = $db->query(
               "SELECT cuposTotal, id_modalidad FROM  cob_periodo_contratosedecupos
                jOIN bc_sede_contrato on bc_sede_contrato.id_sede_contrato = cob_periodo_contratosedecupos.id_sede_contrato
                WHERE bc_sede_contrato.id_contrato = $this->usuario
                order by id_periodo desc
                limit 0,1");
            $beneficiarios_contrato->setFetchMode(Phalcon\Db::FETCH_OBJ);

            foreach ($beneficiarios_contrato->fetchAll() as $key => $value) {
              $cuposTotal=$value->cuposTotal;
              $id_modalidad=$value->id_modalidad;
            }

        $sedes = BcSedeContrato::find(['id_contrato = '. $this->usuario, 'order' => 'oferente_nombre asc']);
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
        $this->view->id_contrato = $this->usuario;
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
        return $this->response->redirect("bc_sede_contrato/beneficiarios");
      }
      $this->flash->success("Los beneficiarios fueron actualizados exitosamente");
      return $this->response->redirect("bc_sede_contrato/beneficiarios");
    }
  }

  ?>
