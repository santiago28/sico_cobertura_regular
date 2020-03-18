<?php

/**
* SessionController
*
* Permite autenticar a los usuarios
*/
class SessionController extends ControllerBase
{
  public function initialize()
  {
    $this->tag->setTitle('Iniciar Sesión');
    parent::initialize();
  }

  public function indexAction()
  {
  }

  /**
  * Registra el usuario autenticado en los datos de la sesión (session)
  *
  * @param IbcUsuario $user
  */
  private function _registerSession($user)
  {
    $this->session->set('auth', array(
      'id_usuario' => $user->id_usuario,
      'id_componente' => $user->id_componente,
      'componente' => $user->IbcComponente->nombre,
      'usuario' => $user->usuario,
      'email' => $user->email,
      'nombre' => $user->nombre,
      'id_usuario_cargo' => $user->id_usuario_cargo,
      'foto' => $user->foto,
      'estado' => $user->estado,
      'nivel' => $user->IbcUsuarioCargo->nivelPermiso
    ));
  }

  /**
  * Autenticación y logueo del usuario en la aplicación
  *
  */

  public function startAction()
  {
    // $this->view->disable();
    // if ($this->request->isGet()) {
    //   $password = $this->request->get('password');
    //   $usuario = $this->request->get('usuario');
    //   // return $password;
    //   $user = IbcUsuario::findFirst(array("email='$usuario' OR usuario = '$usuario'"));
    //   if ($user) {
    //     if ($this->security->checkHash($password, $user->password)) {
    //       $this->_registerSession($user);
    //       $this->flash->success('Bienvenido(a) ' . $user->nombre);
    //       if ($this->session->has("last_url")) {
    //         return $this->response->redirect($this->session->get("last_url"));
    //         return "true";
    //       }
    //       if ($user->id_usuario_cargo == 6) {
    //         return $this->response->redirect('bc_permiso/mes');
    //         return "true";
    //       }else {
    //         return $this->response->redirect('ibc_mensaje/anuncios');
    //         return "true";
    //       }
    //     }
    //   }
    //   $this->flash->error('Contraseña o usuario inválido');
    //   return "false";
    // }
    // return $this->response->redirect('session/index');
    // return "false";

    $this->view->disable();
    if ($this->request->isGet()) {
      $passincodificar = $this->request->get('password');
      $usuario = $this->request->get('usuario');

      $password=md5(htmlspecialchars($passincodificar));
      // var_dump($usuario,$password);
      $user = IbcUsuario::findFirst(array("usuario='$usuario' AND password = '$password'"));
      // var_dump($user);
      if ($user) {
        $this->_registerSession($user);
        return "true";
        // return $this->response->redirect("bc_carga_cobertura");
      }
      return "false";
    }
  }

  public function restartAction($id_usuario)
  {
    $usuario = IbcUsuario::findFirstByid_usuario($id_usuario);
    if ($usuario) {
      $this->_registerSession($usuario);
      return $this->response->redirect('ibc_mensaje/anuncios');
    } else {
      return $this->response->redirect('session/index');
    }
    return $this->response->redirect('session/index');
  }

  /**
  * Finalización de la sesión redireccionando al inicio
  *
  * @return unknown
  */
  public function endAction()
  {
    $this->session->remove('auth');
    $this->flash->success('¡Hasta pronto!');
    return $this->response->redirect('session/index');
  }
}
