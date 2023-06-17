<?php 

	$hostname = 'localhost';
	$username = 'root';
	$pass = '';
	$dbname = 'justy';

	$link = new mysqli($hostname,$username,$pass,$dbname);

	if ($link->connect_errno) {
		printf('faild database connect',$link->connect_errno);
		exit();
	}

?>