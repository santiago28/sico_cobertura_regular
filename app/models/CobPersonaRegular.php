<?php

class CobPersonaRegular extends \Phalcon\Mvc\Model
{

  /**
  *
  * @var integer
  */
  public $id_persona_regular;


  public $entidad;


  public $grado;


  public $numDocumento;


  public $primerNombre;


  public $segundoNombre;


  public $primerApellido;


  public $segundoApellido;


  public $legalizaMatricula;


  public $confirmeGrado;


  public $confirmeNumDocumento;


  public $fechaMatricula;


  public $numeroFolio;


  public $confirmeSedeLegalizaMatricula;

  public function cargarBdRegularConfesiones($carga){
    $db = $this->getDI()->getDb();
    $config = $this->getDI()->getConfig();
    $timestamp = new DateTime();
    $tabla_mat = "m" . $timestamp->getTimestamp();
    $archivo_mat = $config->application->basePath . "public/files/bc_bd/" . $carga->nombreMat;
    $db->query("CREATE TEMPORARY TABLE $tabla_mat (id_modalidad INT, numeroContrato VARCHAR(15), entidad VARCHAR(100), 	institucion VARCHAR(100), grado2019 varchar(3), grado2020 varchar(3), numDocumento VARCHAR(100), primerNombre VARCHAR(100), segundoNombre VARCHAR(100), primerApellido VARCHAR(100), segundoApellido VARCHAR(100), 	legalizaMatricula VARCHAR(5), confirmeGrado VARCHAR(30), confirmeNumDocumento VARCHAR(30), 	fechaMatricula DATE, numeroFolio VARCHAR(29), confirmeSedeLegalizaMatricula VARCHAR(100), valRepit VARCHAR(30), valIdRepitModalidad VARCHAR(30)) CHARACTER SET utf8 COLLATE utf8_bin");
    $db->query("LOAD DATA INFILE '$archivo_mat' IGNORE INTO TABLE $tabla_mat FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES (@ID_MODALIDAD, @CONTRATO, @ENTIDAD, @INSTITUCION, @GRADO_2019, @GRADO_2020, @DOCUMENTO, @APELLIDO1, @APELLIDO2, @NOMBRE1, @NOMBRE2, @LEGALIZA_MATRICULA, @CONFIRME_GRADO, @CONFIRME_DOCUMENTO, @FECHA_MATRICULA, @NUMERO_FOLIO, @CONFIRME_SEDE_MATRICULA, @VAL_REPIT, @VAL_ID_REPIT_MODALIDAD) SET id_modalidad = @ID_MODALIDAD, numeroContrato = @CONTRATO, entidad = @ENTIDAD, 	institucion = @INSTITUCION, grado2019 = @GRADO_2019, grado2020 = @GRADO_2020, numDocumento = @DOCUMENTO, primerNombre = REPLACE(@NOMBRE1, '\"',\"\"), segundoNombre = REPLACE(@NOMBRE2, '\"',\"\"), primerApellido = TRIM(REPLACE(@APELLIDO1, '\"',\"\")), segundoApellido = TRIM(REPLACE(@APELLIDO2, '\"',\"\")), legalizaMatricula = @LEGALIZA_MATRICULA, confirmeGrado = @CONFIRME_GRADO, confirmeNumDocumento = @CONFIRME_DOCUMENTO, fechaMatricula = @FECHA_MATRICULA, 	numeroFolio = @NUMERO_FOLIO, confirmeSedeLegalizaMatricula = @CONFIRME_SEDE_MATRICULA, valRepit = @VAL_REPIT, valIdRepitModalidad = @VAL_ID_REPIT_MODALIDAD");

    $db->query("INSERT IGNORE INTO cob_persona_regular_confesiones (id_modalidad, numeroContrato, entidad, institucion, grado2019, grado2020 , numDocumento, primerNombre, segundoNombre, primerApellido, segundoApellido, legalizaMatricula, confirmeGrado, confirmeNumDocumento, fechaMatricula, numeroFolio, confirmeSedeLegalizaMatricula, valRepit, valIdRepitModalidad) SELECT id_modalidad, numeroContrato, entidad, institucion, grado2019, grado2020, numDocumento, primerNombre, segundoNombre, primerApellido, segundoApellido, legalizaMatricula, confirmeGrado, confirmeNumDocumento, fechaMatricula, numeroFolio, confirmeSedeLegalizaMatricula, valRepit, valIdRepitModalidad FROM $tabla_mat WHERE $tabla_mat.confirmeNumDocumento NOT IN (SELECT confirmeNumDocumento FROM cob_persona_regular_confesiones WHERE numeroContrato = $tabla_mat.numeroContrato)");
    return TRUE;
  }

  public function cargarBdRegularAdultos($carga){
    $db = $this->getDI()->getDb();
    $config = $this->getDI()->getConfig();
    $timestamp = new DateTime();
    $tabla_mat = "m" . $timestamp->getTimestamp();
    $archivo_mat = $config->application->basePath . "public/files/bc_bd/" . $carga->nombreMat;
    $db->query("CREATE TEMPORARY TABLE $tabla_mat (id_modalidad INT, numeroContrato VARCHAR(15), entidad VARCHAR(100), 	sede VARCHAR(100), ciclo2020 varchar(20), numDocumento VARCHAR(100), nombreCompleto varchar(100), primerNombre VARCHAR(100), segundoNombre VARCHAR(100), primerApellido VARCHAR(100), segundoApellido VARCHAR(100), 	legalizaMatricula VARCHAR(5), confirmeCiclo VARCHAR(20), confirmeNumDocumento VARCHAR(30), 	fechaMatricula DATE, numeroFolio VARCHAR(29), confirmeSedeLegalizaMatricula VARCHAR(100),valRepit VARCHAR(30), valIdRepitModalidad VARCHAR(30)) CHARACTER SET utf8 COLLATE utf8_bin");
    $db->query("LOAD DATA INFILE '$archivo_mat' IGNORE INTO TABLE $tabla_mat FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES (@ID_MODALIDAD, @CONTRATO, @ENTIDAD, @SEDE, @CICLO_2020, @DOCUMENTO, @NOMBRE_COMPLETO, @APELLIDO1, @APELLIDO2, @NOMBRE1, @NOMBRE2, @LEGALIZA_MATRICULA, @CONFIRME_CICLO, @CONFIRME_DOCUMENTO, @FECHA_MATRICULA, @NUMERO_FOLIO, @CONFIRME_SEDE_MATRICULA,@VAL_REPIT, @VAL_ID_REPIT_MODALIDAD) SET id_modalidad = @ID_MODALIDAD, numeroContrato = @CONTRATO, entidad = @ENTIDAD, 	sede = @SEDE, ciclo2020 = @CICLO_2020, numDocumento = @DOCUMENTO, nombreCompleto = @NOMBRE_COMPLETO, primerNombre = REPLACE(@NOMBRE1, '\"',\"\"), segundoNombre = REPLACE(@NOMBRE2, '\"',\"\"), primerApellido = TRIM(REPLACE(@APELLIDO1, '\"',\"\")), segundoApellido = TRIM(REPLACE(@APELLIDO2, '\"',\"\")), legalizaMatricula = @LEGALIZA_MATRICULA, confirmeCiclo = @CONFIRME_CICLO, confirmeNumDocumento = @CONFIRME_DOCUMENTO, fechaMatricula = @FECHA_MATRICULA, 	numeroFolio = @NUMERO_FOLIO, confirmeSedeLegalizaMatricula = @CONFIRME_SEDE_MATRICULA,valRepit = @VAL_REPIT, valIdRepitModalidad = @VAL_ID_REPIT_MODALIDAD");

    $db->query("INSERT IGNORE INTO cob_persona_regular_adultos (id_modalidad, numeroContrato, entidad, sede, ciclo2020, numDocumento, nombreCompleto, primerNombre, segundoNombre, primerApellido, segundoApellido, legalizaMatricula, confirmeCiclo, confirmeNumDocumento, fechaMatricula, numeroFolio, confirmeSedeLegalizaMatricula,valRepit, valIdRepitModalidad) SELECT id_modalidad, numeroContrato, entidad, sede, ciclo2020, numDocumento, nombreCompleto, primerNombre, segundoNombre, primerApellido, segundoApellido, legalizaMatricula, confirmeCiclo, confirmeNumDocumento, fechaMatricula, numeroFolio, confirmeSedeLegalizaMatricula,valRepit, valIdRepitModalidad FROM $tabla_mat WHERE $tabla_mat.confirmeNumDocumento NOT IN (SELECT confirmeNumDocumento FROM cob_persona_regular_adultos WHERE numeroContrato = $tabla_mat.numeroContrato)");
    return TRUE;
  }

  public function cargarBdRegularOferentes($carga){
    $db = $this->getDI()->getDb();
    $config = $this->getDI()->getConfig();
    $timestamp = new DateTime();
    $tabla_mat = "m" . $timestamp->getTimestamp();
    $archivo_mat = $config->application->basePath . "public/files/bc_bd/" . $carga->nombreMat;
    $db->query("CREATE TEMPORARY TABLE $tabla_mat (id_modalidad INT, numeroContrato VARCHAR(15), entidad VARCHAR(100), 	establecimientoEducativo VARCHAR(100), grado2019 varchar(3), grupo2019 varchar(10), grado2020 varchar(3), nivel2020 varchar(10), numDocumento VARCHAR(100), nombreCompleto VARCHAR(100), legalizaMatricula VARCHAR(5), confirmeGrado VARCHAR(30), confirmeNumDocumento VARCHAR(30), 	fechaMatricula DATE, numeroFolio VARCHAR(29), confirmeSedeLegalizaMatricula VARCHAR(100),valRepit VARCHAR(30), valIdRepitModalidad VARCHAR(30)) CHARACTER SET utf8 COLLATE utf8_bin");
    $db->query("LOAD DATA INFILE '$archivo_mat' IGNORE INTO TABLE $tabla_mat FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES (@ID_MODALIDAD, @CONTRATO, @ENTIDAD, @ESTABLECIMIENTO, @GRADO_2019, @GRUPO_2019, @GRADO_2020, @NIVEL_2020, @DOCUMENTO, @NOMBRE_COMPLETO, @LEGALIZA_MATRICULA, @CONFIRME_GRADO, @CONFIRME_DOCUMENTO, @FECHA_MATRICULA, @NUMERO_FOLIO, @CONFIRME_SEDE_MATRICULA,@VAL_REPIT, @VAL_ID_REPIT_MODALIDAD) SET id_modalidad = @ID_MODALIDAD, numeroContrato = @CONTRATO, entidad = @ENTIDAD, 	establecimientoEducativo = @ESTABLECIMIENTO, grado2019 = @GRADO_2019, grupo2019 = @GRUPO_2019, grado2020 = @GRADO_2020, nivel2020 = @NIVEL_2020, numDocumento = @DOCUMENTO, nombreCompleto = @NOMBRE_COMPLETO, legalizaMatricula = @LEGALIZA_MATRICULA, confirmeGrado = @CONFIRME_GRADO, confirmeNumDocumento = @CONFIRME_DOCUMENTO, fechaMatricula = @FECHA_MATRICULA, 	numeroFolio = @NUMERO_FOLIO, confirmeSedeLegalizaMatricula = @CONFIRME_SEDE_MATRICULA,valRepit = @VAL_REPIT, valIdRepitModalidad = @VAL_ID_REPIT_MODALIDAD");

    $db->query("INSERT IGNORE INTO cob_persona_regular_oferentes (id_modalidad, numeroContrato, entidad, establecimientoEducativo, grado2019, grupo2019, grado2020, nivel2020, numDocumento, nombreCompleto, legalizaMatricula, confirmeGrado, confirmeNumDocumento, fechaMatricula, numeroFolio, confirmeSedeLegalizaMatricula,valRepit, valIdRepitModalidad) SELECT id_modalidad, numeroContrato, entidad, establecimientoEducativo, grado2019, grupo2019, grado2020, nivel2020, numDocumento, nombreCompleto, legalizaMatricula, confirmeGrado, confirmeNumDocumento, fechaMatricula, numeroFolio, confirmeSedeLegalizaMatricula,valRepit, valIdRepitModalidad FROM $tabla_mat WHERE $tabla_mat.confirmeNumDocumento NOT IN (SELECT confirmeNumDocumento FROM cob_persona_regular_oferentes WHERE numeroContrato = $tabla_mat.numeroContrato)");
    return TRUE;
  }

  public function cargarBdRegularOtrasPoblaciones($carga){
    $db = $this->getDI()->getDb();
    $config = $this->getDI()->getConfig();
    $timestamp = new DateTime();
    $tabla_mat = "m" . $timestamp->getTimestamp();
    $archivo_mat = $config->application->basePath . "public/files/bc_bd/" . $carga->nombreMat;
    $db->query("CREATE TEMPORARY TABLE $tabla_mat (id_modalidad INT, numeroContrato VARCHAR(15), modalidad VARCHAR(30), entidad VARCHAR(100), 	establecimientoEducativo VARCHAR(100), grado2019 varchar(3), grupo2019 varchar(10), grado2020 varchar(3), nivel2020 varchar(10), numDocumento VARCHAR(100), nombreCompleto VARCHAR(100), legalizaMatricula VARCHAR(5), confirmeGrado VARCHAR(30), confirmeNumDocumento VARCHAR(30), 	fechaMatricula DATE, numeroFolio VARCHAR(29), confirmeSedeLegalizaMatricula VARCHAR(100),valRepit VARCHAR(30), valIdRepitModalidad VARCHAR(30)) CHARACTER SET utf8 COLLATE utf8_bin");
    $db->query("LOAD DATA INFILE '$archivo_mat' IGNORE INTO TABLE $tabla_mat FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES (@ID_MODALIDAD, @CONTRATO, @MODALIDAD, @ENTIDAD, @ESTABLECIMIENTO, @GRADO_2019, @GRUPO_2019, @GRADO_2020, @NIVEL_2020, @DOCUMENTO, @NOMBRE_COMPLETO, @LEGALIZA_MATRICULA, @CONFIRME_GRADO, @CONFIRME_DOCUMENTO, @FECHA_MATRICULA, @NUMERO_FOLIO, @CONFIRME_SEDE_MATRICULA,@VAL_REPIT, @VAL_ID_REPIT_MODALIDAD) SET id_modalidad = @ID_MODALIDAD, numeroContrato = @CONTRATO, modalidad = @MODALIDAD, entidad = @ENTIDAD, establecimientoEducativo = @ESTABLECIMIENTO, grado2019 = @GRADO_2019, grupo2019 = @GRUPO_2019, grado2020 = @GRADO_2020, nivel2020 = @NIVEL_2020, numDocumento = @DOCUMENTO, nombreCompleto = @NOMBRE_COMPLETO, legalizaMatricula = @LEGALIZA_MATRICULA, confirmeGrado = @CONFIRME_GRADO, confirmeNumDocumento = @CONFIRME_DOCUMENTO, fechaMatricula = @FECHA_MATRICULA, 	numeroFolio = @NUMERO_FOLIO, confirmeSedeLegalizaMatricula = @CONFIRME_SEDE_MATRICULA,valRepit = @VAL_REPIT, valIdRepitModalidad = @VAL_ID_REPIT_MODALIDAD");

    $db->query("INSERT IGNORE INTO cob_persona_regular_otras_poblaciones (id_modalidad, numeroContrato, modalidad, entidad, establecimientoEducativo, grado2019, grupo2019, grado2020, nivel2020, numDocumento, nombreCompleto, legalizaMatricula, confirmeGrado, confirmeNumDocumento, fechaMatricula, numeroFolio, confirmeSedeLegalizaMatricula,valRepit, valIdRepitModalidad) SELECT id_modalidad, numeroContrato, modalidad, entidad, establecimientoEducativo, grado2019, grupo2019, grado2020, nivel2020, numDocumento, nombreCompleto, legalizaMatricula, confirmeGrado, confirmeNumDocumento, fechaMatricula, numeroFolio, confirmeSedeLegalizaMatricula,valRepit, valIdRepitModalidad FROM $tabla_mat WHERE $tabla_mat.confirmeNumDocumento NOT IN (SELECT confirmeNumDocumento FROM cob_persona_regular_otras_poblaciones WHERE numeroContrato = $tabla_mat.numeroContrato)");
    return TRUE;
  }

  //carga db comite  

  public function cargarBdComite($carga){
    $db = $this->getDI()->getDb();
    $config = $this->getDI()->getConfig();
    $timestamp = new DateTime();
    $tabla_mat = "m" . $timestamp->getTimestamp();
    $archivo_mat = $config->application->basePath . "public/files/bc_bd/" . $carga->nombreMat;
    $db->query("CREATE TEMPORARY TABLE $tabla_mat 
    (
      nucleo VARCHAR(100),
      id_contrato VARCHAR(50),
      operador VARCHAR(150),
      sede_atencion VARCHAR(200), 
      documento_identidad VARCHAR(20), 
      primer_nombre VARCHAR(60),
      segundo_nombre varchar(60),
      primer_apellido varchar(50),
      segundo_apellido varchar(50), 
      ciclo varchar(50), 
      respuesta_comite VARCHAR(100), 
      proviene VARCHAR(100)) CHARACTER SET utf8 COLLATE utf8_bin");
    $db->query("LOAD DATA INFILE '$archivo_mat' IGNORE INTO TABLE $tabla_mat FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES 
    (      
        @NUCLEO,
        @CONTRATO,
        @OPERADOR, 
        @SEDE_ATENCION, 
        @DOCUMENTO_IDENTIDAD, 
        @PRIMER_NOMBRE, 
        @SEGUNDO_NOMBRE,
        @PRIMER_APELLIDO, 
        @SEGUNDO_APELLIDO, 
        @CICLO, 
        @RESPUESTA_COMITE, 
        @PROVIENE
      ) SET 
          nucleo = @NUCLEO, 
          id_contrato = @CONTRATO, 
          operador = @OPERADOR, 
          sede_atencion = @SEDE_ATENCION, 
          documento_identidad = @DOCUMENTO_IDENTIDAD, 
          primer_nombre = @PRIMER_NOMBRE, 
          segundo_nombre = @SEGUNDO_NOMBRE, 
          primer_apellido = @PRIMER_APELLIDO, 
          segundo_apellido = @SEGUNDO_APELLIDO, 
          ciclo = @CICLO, 
          respuesta_comite = @RESPUESTA_COMITE,
          proviene = @PROVIENE");

    $db->query("INSERT IGNORE INTO cob_comite_persona 
    (
      nucleo,
      id_contrato,
      operador,
      sede_atencion, 
      documento_identidad, 
      primer_nombre,
      segundo_nombre,
      primer_apellido,
      segundo_apellido, 
      ciclo, 
      respuesta_comite, 
      proviene
      ) SELECT 
          nucleo,
          id_contrato,
          operador,
          sede_atencion, 
          documento_identidad, 
          primer_nombre,
          segundo_nombre,
          primer_apellido,
          segundo_apellido,
          ciclo, 
          respuesta_comite, 
          proviene
      FROM $tabla_mat WHERE $tabla_mat.documento_identidad NOT IN (SELECT documento_identidad FROM cob_comite_persona WHERE id_contrato = $tabla_mat.id_contrato)");
    return TRUE;
  }
}
