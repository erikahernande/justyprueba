<?php 

include 'database.php';

$nomenclatura = $_POST['nomenclatura'];
$aula = $_POST['aula'];

$link->query("INSERT INTO grupo(nomenclatura,aula)VALUES('".$nomenclatura."','".$aula."')");