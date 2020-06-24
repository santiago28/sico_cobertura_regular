<?php

class CobOferentePersonaSimat extends \Phalcon\Mvc\Model
{

  /**
  *
  * @var integer
  */
  public $id_oferente_persona;

  /**
  *
  * @var string
  */
  public $id_contrato;

  /**
  *
  * @var string
  */
  public $ano;

  /**
  *
  * @var string
  */
  public $etc;

  /**
  *
  * @var string
  */
  public $estado;

  /**
  *
  * @var string
  */
  public $jerarquia;

  /**
  *
  * @var string
  */
  public $institucion;

  /**
  *
  * @var string
  */
  public $codigo_dane;

  /**
  *
  * @var string
  */
  public $prestacion_servicio;

  /**
  *
  * @var string
  */
  public $calendario;

  /**
  *
  * @var string
  */
  public $sector;

  /**
  *
  * @var string
  */
  public $sede_simat;

  /**
  *
  * @var string
  */
  public $codigo_dane_sede;

  /**
  *
  * @var string
  */
  public $zona_sede;
  /**
  *
  * @var string
  */
  public $jornada_simat;
  /**
  *
  * @var string
  */
  public $grado_cod_simat;
  /**
  *
  * @var string
  */
  public $grupo_simat;
  /**
  *
  * @var string
  */
  public $modelo;
  /**
  *
  * @var string
  */
  public $motivo;
  /**
  *
  * @var string
  */
  public $fecha_ini;
  /**
  *
  * @var string
  */
  public $fecha_fin;
  /**
  *
  * @var string
  */
  public $nui;
  /**
  *
  * @var string
  */
  public $estrato;
  /**
  *
  * @var string
  */
  public $sisben_tres;
  /**
  *
  * @var integer
  */
  public $id_persona_simat;
  /**
  *
  * @var string
  */
  public $documento;
  /**
  *
  * @var string
  */
  public $tipo_documento;
  /**
  *
  * @var string
  */
  public $apellido1;
  /**
  *
  * @var string
  */
  public $apellido2;
  /**
  *
  * @var string
  */
  public $nombre1;
  /**
  *
  * @var string
  */
  public $nombre2;
  /**
  *
  * @var string
  */
  public $genero;
  /**
  *
  * @var string
  */
  public $fecha_nacimiento;
  /**
  *
  * @var string
  */
  public $barrio;
  /**
  *
  * @var string
  */
  public $eps;
  /**
  *
  * @var string
  */
  public $tipo_sangre;
  /**
  *
  * @var string
  */
  public $matricula_contratada;
  /**
  *
  * @var string
  */
  public $fuente_recursos;
  /**
  *
  * @var string
  */
  public $internado;
  /**
  *
  * @var string
  */
  public $num_contrato;
  /**
  *
  * @var string
  */
  public $apoyo_acadmico_especial;
  /**
  *
  * @var string
  */
  public $srpa;
  /**
  *
  * @var string
  */
  public $discapacidad;
  /**
  *
  * @var string
  */
  public $pais_origen;
  /**
  *
  * @var string
  */
  public $correo;
  /**
  *
  * @var integer
  */
  public $id_sede;
  /**
  *
  * @var string
  */
  public $nombre_sede;
  /**
  *
  * @var integer
  */
  public $id_jornada;
  /**
  *
  * @var string
  */
  public $nombre_jornada;
  /**
  *
  * @var string
  */
  public $matricula_simat;
  /**
  *
  * @var string
  */
  public $ingreso;
  /**
  *
  * @var string
  */
  public $estado_certificacion;

  /**
  *
  * @var string
  */
  public $observaciones_retiro;

  /**
  *
  * @var integer
  */
  public $estado_activo;

  /**
  *
  * @var string
  */
  public $fecha_retiro;


  /**
  *
  * @var string
  */
  public $urlEvidenciaMatricula;



  public function initialize()
  {
    $this->belongsTo(array('id_contrato', 'id_sede'), 'BcSedeContrato', array('id_contrato', 'id_sede'));
  }

}
