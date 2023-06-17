<?php 

	include 'database.php';

	$idDoc = $_POST['idDoc'];

	$link->query("DELETE FROM docente WHERE idDoc = '".$idDoc."'");