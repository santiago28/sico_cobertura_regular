<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        {{ get_title() }}
        {{ stylesheet_link('css/bootstrap.min.css') }}
        {{ stylesheet_link('css/bootstrap-datepicker.min.css') }}
        {{ stylesheet_link('css/style.css') }}
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        {{ assets.outputCss() }}
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Sistema de Información de la Interventoría Buen Comienzo">
        <meta name="author" content="Julián Camilo Marín Sánchez">
        <link href="http://fonts.googleapis.com/css?family=Inconsolata" rel="stylesheet" type="text/css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
    </head>
    <body style="font-family: 'Roboto', sans-serif !important; font-weight: normal;">
        {{ content() }}
        {{ javascript_include('js/jquery/jquery.min.js') }}
        {{ javascript_include('js/jquery.tablesorter.js') }}
        {{ javascript_include('js/jquery.tablesorter.widgets.js') }}
        {{ javascript_include('js/bootstrap.min.js') }}
        {{ javascript_include('js/utils.js') }}
        {{ javascript_include('js/bootstrap-datepicker.min.js') }}
        {{ javascript_include('js/bootstrap-datepicker.es.min.js') }}

        {{ assets.outputJs() }}
    </body>
</html>
