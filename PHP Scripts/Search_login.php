<?php

$uid = $_POST['username'];
$pwd = $_POST['password'];

$servername = 'localhost';
$username = "root";
$password = "981224Qq@";

$response = array(false,"","","","");

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
        if (strcmp($row["username"],$uid) == 0 && strcmp($row["userpassword"],$pwd) == 0 ){
            $response[0] = "true";
            
            $search_query= "SELECT * FROM profile_info WHERE username='$uid'";
            $profile_result = $connect->query($search_query);
            if ($profile_result->num_rows > 0){
                $profile_row = $profile_result->fetch_assoc();
                $response[1] = $profile_row['First_name'];
                $response[2] = $profile_row["Last_name"];
                $response[3] = $profile_row["Address"];
                $response[4] = $profile_row["Postcode"];
            }else{
                $response[1] ="";
                $response[2] ="";
                $response[3] ="";
                $response[4] ="";
            }
        }
        //printf("Name: " . $row["username"]. "    Password:" . $row["userpassword"]);
    }
} else {
    $response[0] = "false";
    $response[1] ="";
    $response[2] ="";
    $response[3] ="";
    $response[4] ="";
}
$string_response = implode(",", $response);
echo $string_response;

$connect->close();

?>
