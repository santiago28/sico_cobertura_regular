{# <nav class="navbar navbar-default navbar-inverse" role="navigation">
<div class="container-fluid">
<div class="navbar-header">
<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
<span class="sr-only">Toggle navigation</span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
</button>
<a class="navbar-brand dropdown-toggle" data-toggle="dropdown" aria-expanded="false" href="#">{{ image("img/logo_pascual.png", "alt": "Interventoría Buen Comienzo") }} <span class="caret"></span></a>
<div class="dropdown-menu list-group" role="menu">
{{ elements.getMenuInicio() }}
</div>
</div>
{{ elements.getMenu() }}
</div>
</nav> #}
<div class="barra-menu noPrint">
  <div class="col-md-12">

    <div style="margin-top: 1%; float: right; color:white;">
      {# <a class="glyphicon glyphicon-home" href="homeadmin.php" style="font-size:35px; color:#ffffff; text-decoration:none;" role="button"></a> #}

      Cobertura
      {{ image("img/index/logo_pascual.png", "alt": "", "style": "width:40px;") }}
    </div>
  </div>
</div>
<div id="MenuPrincipal" class="noPrint">
  <i class="material-icons icono-menu">&#xE5D2;</i>
  <div class="sobre-menu-principal"></div>
  <div class="menu-principal">
    <div class="header-menu-principal">
      <div>
        <img id="avatarprincipal" src="" />
        <br />
        {# <b>Nombre:&ensp;</b><span id="username">Pruebas</span> #}
      </div>
    </div>
    <div class="body-menu-principal">
      {{ elements.getMenu() }}
    </div>
    <div class="footer-menu-principal">
      <div></div>
      {# <div>{{ link_to("/2020/interventoria/principal.php", '<i class="material-icons">&#xE8AC;</i>') }}</div> #}
      <div><a href="/2020/interventoria/principal.php"><i class="material-icons">&#xE8AC;</i></a></div>
      <div></div>
    </div>
  </div>
</div>
<div class="container">
  <br><br><br>
  <br><br><br>
  <div class="row">
    {{ flash.output() }}
  </div>
  <div class="row">
    <div class="col-xs-12 col-sm-12">
      {{ content() }}
      {{ javascript_include('js/jquery/jquery.min.js') }}
    </div>
    {# <div class="col-xs-6 col-sm-3" id="sidebar" style="padding-right: 0px !important;">
    <div class="list-group">
    {{ elements.getMenuInicio() }}
  </div>
  <div class="well">
  <h4>Enlaces</h4>
  <ul style="padding-left: 15px !important;">
  <li><a href="http://www.interventoriabuencomienzo.org/webmail" target="_blank">Correo Institucional</a></li>
  <li><a href="http://190.248.150.222:842/2016/delfi/" target="_blank">delFI 2016: Sistema de Información Financiera</a></li>
  <li><a href="http://190.248.150.222:842/2017/delfi/" target="_blank">delFI 2017: Sistema de Información Financiera</a></li>
  <li><a href="http://www.pascualbravo.edu.co/" target="_blank">Institución Universitaria Pascual Bravo</a></li>
  <li><a href="http://www.medellin.gov.co/buencomienzo" target="_blank">Buen Comienzo</a></li>
  <li><a href="http://www.medellin.gov.co" target="_blank">Alcaldía de Medellín</a></li>
  <li><a href="https://www.sisben.gov.co/ConsultadePuntaje.aspx" target="_blank">Consulta SISBEN</a></li>
</ul>
</div>
</div> #}
</div>
<hr>
<footer>
  <p>Interventoría Cobertura Regular</p>
</footer>
</div>
<script>

$(".icono-menu").click(function () {

  $(".sobre-menu-principal").fadeIn();
  $(".menu-principal").animate({
    left: "0"
  }, 500);
});

$(".sobre-menu-principal").click(function () {

  $(".sobre-menu-principal").fadeOut();
  $(".menu-principal").animate({
    left: "-1000px"
  }, 500);
});

</script>
