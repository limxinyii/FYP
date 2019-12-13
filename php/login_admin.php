<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$password = $_POST['password'];
//$passwordsha = sha1($_POST['password']);

$sql = "SELECT * FROM Admin WHERE email = '$email' AND password = '$password' AND verify ='1'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        echo "Login Successful,".$row["name"].",".$row["email"];
    }
}else{
    echo "Enter wrong email or password,null,null";
}