<?php 

	include 'database.php';

	$nomenclatura = $_POST['nomenclatura'];
	$aula = $_POST['aula'];


	$link->query("UPDATE grupo SET nomenclatura = '".$nomenclatura."',aula = '".$aula."' WHERE idPersona = '".$idPersona."'");


