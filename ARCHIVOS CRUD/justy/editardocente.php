<?php 

include 'database.php';

$materia = $_POST['materia'];
$per_id = $_POST['per_id'];

$link->query("UPDATE docente SET materia = '".$materia."',per_id = '".$per_id."' WHERE idDoc = '".$idDoc."'");