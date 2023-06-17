<?php 

	include 'database.php';

	$idPersona = $_POST['idPersona'];

	$link->query("DELETE FROM persona WHERE idPersona = '".$idPersona."'");