<?php 

	
$db = mysqli_connect('localhost','root','','justy');

	$query = $db->query("SELECT `docentes`.*, `persona`. * FROM `docentes`  LEFT JOIN `persona` ON `docentes`.`per_id` = `persona`.`idPersona`;");
	$result = array();

	while ($rowData = $query->fetch_assoc()) {
		$result[] = $rowData;
	}


	echo json_encode($result);
	