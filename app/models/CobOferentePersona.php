<?php
class CobOferentePersona extends \Phalcon\Mvc\Model
{
  public $id_oferente_persona;

  public $id_oferente;

  public $id_contrato;

  public $numDocumento;

  public $nombreCompleto;

  public $id_sede;

  public $jornada;

  public $grado;

  public $grupo;

  public $matriculadoSimat;

  public $retirado;

  public $ingreso;


  public function getAsistenciaDetail()
  {
    if ($this->grupo != '') {
      return " class='success'";
    }
  }

  public function initialize()
  {
    $this->belongsTo('id_sede', 'BcSedeContrato', 'id_sede', array(
        'reusable' => true
    ));
  }
}
?>
