<?php
$servername = "localhost";
$username 	= "myondbco_projectadmin";
$password 	= "jqSXKPg3wwSC";
$dbname 	= "myondbco_project";
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>