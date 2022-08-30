<?php

$uid = $_POST['username'];
$fn = $_POST['first_name'];
$ln = $_POST['last_name'];
$ad = $_POST['address'];
$pc = $_POST['postcode'];

$servername = 'localhost';
$username = "root";
$password = "981224Qq@";


///creat connect
$connect = new mysqli($servername, $username, $password);

if($connect -> connect_error){
    die("Connect database failed" .$connect->connect_error);
}
//print("Connect database successful");


$connect->query("use Login");

$exist_query = "SELECT COUNT(*) FROM profile_info WHERE username = '$uid' ";
$exist_result = $connect->query($exist_query);
if ($exist_result->fetch_assoc()["COUNT(*)"]) {
    $sql = "UPDATE profile_info SET First_name = '$fn', Last_name ='$ln', Address = '$ad', Postcode = '$pc' WHERE username = '$uid'";
    $result = $connect->query($sql);

    echo json_encode($result);
    
} else {
    $sql = "INSERT INTO profile_info (username, First_name, Last_name, Address, Postcode) VALUES ('$uid','$fn','$ln','$ad','$pc')";
    $result = $connect->query($sql);

    echo json_encode($result);
}

$connect->close();

?>
