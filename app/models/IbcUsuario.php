<?php

use Phalcon\Validation;
use Phalcon\Validation\Validator\Email as EmailValidator;
use Phalcon\Validation\Validator\Uniqueness as UniquenessValidator;

class IbcUsuario extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $id_usuario;

    /**
     *
     * @var integer
     */
    public $id_componente;

    /**
     *
     * @var string
     */
    public $usuario;

    /**
     *
     * @var string
     */
    public $nombre;

    /**
     *
     * @var integer
     */
    public $telefono;

    /**
     *
     * @var integer
     */
    public $celular;

    /**
     *
     * @var string
     */
    public $email;

    /**
     *
     * @var integer
     */
    public $id_usuario_cargo;

    /**
     *
     * @var string
     */
    public $foto;

    /**
     *
     * @var string
     */
    public $password;

    /**
     *
     * @var integer
     */
    public $estado;

    public function initialize()
    {
    	$this->belongsTo('id_usuario_cargo', 'IbcUsuarioCargo', 'id_usuario_cargo', array(
    			'reusable' => true
    	));
    	$this->belongsTo('id_componente', 'IbcComponente', 'id_componente', array(
    			'reusable' => true
    	));
    	$this->belongsTo('id_usuario', 'IbcUsuarioOferente', 'id_usuario', array(
    			'reusable' => true
    	));
    }

    public function validation()
    {
      $validation = new Validation();

      $validation
          ->add('email', new EmailValidator())
          ->add('email', new UniquenessValidator(array(
              'model'   => $this,
              'message' => 'Correo electrónico ya se encuentra en uso'
          )))
          ->add('usuario', new UniquenessValidator(array(
              'model'   => $this,
              'message' => 'Nombre de usuario ya se encuentra en uso'
          )));

      return $this->validate($validation);
    }

}
