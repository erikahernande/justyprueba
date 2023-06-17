<?php 

	include 'database.php';

	$idPersona = $_POST['idPersona'];
	$nombre = $_POST['nombre'];
	$apellidoM = $_POST['apellidoM'];
	$apellidoP = $_POST['apellidoP'];
	$telefono = $_POST['telefono'];

	$link->query("UPDATE persona SET nombre = '".$nombre."',apellidoM = '".$apellidoM."',apellidoP = '".$apellidoP."',telefono = '".$telefono."' WHERE idPersona = '".$idPersona."'");


?>