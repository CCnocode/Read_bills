<?php

$uid = $_POST['username'];
$pwd = $_POST['password'];

$servername = 'localhost';
$username = "root";
$password = "981224Qq@";

$status = false;


///creat connect
$connect = new mysqli($servername, $username, $password);

if($connect -> connect_error){
    die("Connect database failed" .$connect->connect_error);
}
//print("Connect database successful");


$connect->query("use Login");

$sql = "SELECT username, userpassword FROM Login_user";
$result = $connect->query($sql);

if ($result->num_rows > 0) {
    // show the data
    while($row = $result->fetch_assoc()) {
        if (strcmp($row["username"],$uid) == 0){
            $status = false;
            exit(Json_encode($status));
        }
    }
}

$insert_sql = "INSERT INTO login_user (username, userpassword) VALUES ('$uid','$pwd')";
$status = $connect->query($insert_sql);

echo json_encode($status);

$connect->close();

?>
