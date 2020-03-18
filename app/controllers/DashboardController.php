<?php

use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;

class DashboardController extends ControllerBase
{
  public $user;

  public function initialize()
  {
    $this->tag->setTitle("Dashboard");
    $this->user = $this->session->get('auth');
    $this->id_usuario = $this->user['id_usuario'];
    parent::initialize();
  }

  public function indexAction()
  {

    $db = $this->getDI()->getDb();

    $id_cargo = $this->user['id_usuario_cargo'];
    $query_dashboard = null;
    if ($id_cargo == 1) {
      $query_dashboard = $db->query("select sum(IF(estado = 0,1,0)) as abiertas, sum(IF(estado = 2,1,0)) as cerradas from cob_actaconteo");
    }else if ($id_cargo == 5) {
      $query_dashboard = $db->query("select c.id_usuario, u.nombre, u.usuario, sum(IF(c.estado = 0,1,0)) as abiertas, sum(IF(c.estado = 1 or c.estado = 2 or c.estado = 4,1,0)) as cerradas
      from cob_actaconteo c join ibc_usuario u on c.id_usuario = u.id_usuario
      where u.id_usuario_cargo = 3
      GROUP by c.id_usuario");
    }else if ($id_cargo == 3) {
      $query_dashboard = $db->query("select id_usuario, sum(IF(estado = 0,1,0)) as abiertas, sum(IF(estado = 1 or estado = 2 or estado = 4,1,0)) as cerradas
      from cob_actaconteo
      where id_usuario = '$this->id_usuario'
      group by id_usuario");
    }

    $query_dashboard->setFetchMode(Phalcon\Db::FETCH_ASSOC);
    // $this->assets->addJs('/js/chart.js');
    $this->view->datos_dashboard = json_encode($query_dashboard->fetchAll());
    $this->view->id_cargo = $id_cargo;

  }
}

?>
