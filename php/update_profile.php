<?php
error_reporting(0);
include_once("dbconnect.php");

$email = $_POST['email'];
$password = $_POST['password'];
$phone = $_POST['phone'];
$name = $_POST['name'];
$dob = $_POST['dob'];
$address = $_POST['address'];

$usersql = "SELECT * FROM User WHERE email = '$email'";

if (isset($name) && (!empty($name))){
    $sql = "UPDATE User SET name = '$name' WHERE email = '$email'";
}
if (isset($password) && (!empty($password))){
    $sql = "UPDATE User SET password = sha1($password) WHERE email = '$email'";
}
if (isset($phone) && (!empty($phone))){
    $sql = "UPDATE User SET phone = '$phone' WHERE email = '$email'";
}
if (isset($dob) && (!empty($dob))){
    $sql = "UPDATE User SET dob = '$dob' WHERE email = '$email'";
}
if (isset($address) && (!empty($address))){
    $sql = "UPDATE User SET address = '$address' WHERE email = '$email'";
}
if ($conn->query($sql) === TRUE) {
    $result = $conn->query($usersql);
if ($result->num_rows > 0) {
        while ($row = $result ->fetch_assoc()){
        echo "success,".$row["name"].",".$row["email"].",".$row["phone"].",".$row["dob"].",".$row["address"].",".$row["date"];
        }
    }else{
        echo "failed,null,null,null,null,null,null";
    }
} else {
    echo "error";
}

$conn->close();
?>