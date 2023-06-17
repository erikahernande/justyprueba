<?php 

include 'database.php';

$materia = $_POST['materia'];
$per_id = $_POST['per_id'];

$link->query("INSERT INTO docente(materia,per_id)VALUES('".$materia."','".$per_id."')");