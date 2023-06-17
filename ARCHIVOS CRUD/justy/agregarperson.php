<?php 

	include 'database.php';

	
	$nombre = $_POST['nombre'];
	$apellidoM = $_POST['apellidoM'];
	$apellidoP = $_POST['apellidoP'];
	$telefono = $_POST['telefono'];

	$link->query("INSERT INTO persona(nombre,apellidoM,apellidoP,telefono)VALUES('".$nombre."','".$apellidoM."','".$apellidoP."','".$telefono."')");













































	// include 'database.php';

	// $fistname = $_POST['fistname'];
	// $lastname = $_POST['lastname'];
	// $phone = $_POST['phone'];
	// $address = $_POST['address'];

	// $link->query("INSERT INTO person(fistname,lastname,phone,address)VALUES('".$fistname."','".$lastname."','".$phone."','".$address."')");

