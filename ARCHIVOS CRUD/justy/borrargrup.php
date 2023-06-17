<?php include 'database.php';

	$nomenclatura = $_POST['nomenclatura'];

	$link->query("DELETE FROM grupo WHERE nomenclatura = '".$nomenclatura."'");