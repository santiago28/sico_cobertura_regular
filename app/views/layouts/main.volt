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
    {# <div class="header-menu-principal">
        <div>
          <img id="avatarprincipal" src="" />
          <br />
          <b>Nombre:&ensp;</b><span id="username"></span>
        </div>
      </div>
      <div class="body-menu-principal"> #}
        {{ elements.getMenu() }}
      {# </div> #}
    <div class="footer-menu-principal">
      <div></div>
      {# <div>{{ link_to("/interventoria/principal.php", '<i class="material-icons">&#xE8AC;</i>') }}</div> #}
      <div><a href="/2020/interventoria/principal.php"><i class="material-icons">&#xE8AC;</i></a></div>
      <div></div>
    </div>
  </div>
</div>
<div class="container">
  <br><br><br>
  <br>
    {{ flash.output() }}
    {{ content() }}
    {{ javascript_include('js/jquery/jquery.min.js') }}
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
