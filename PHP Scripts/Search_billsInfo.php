<?php

$uid = $_POST['username'];

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

$sql = "SELECT * FROM user_bills_info WHERE username='$uid'";
$result = $connect->query($sql);


$obj = Array();
$id = 1;
$date = "";
$amount = 0;
$merchant = "";
$category = "";
$type = "";
$categoryID = 1;

$type_ref = "Paycheque";
$electric = "Electric";
$water = "Water";
$gas = "Gas";

if ($result->num_rows > 0) {
    // show the data
    while($row = $result->fetch_assoc()) {
        
        $date = $row["date"];
        $amount = $row["amount"];
        $merchant = $row["merchant"];
        $category = $row["energy_type"];
        if (strcmp($category, $type_ref) == 0){
            $type = "receive";
        }
        else{
            $type = "pay";
        }
            
        if (strcmp($category, $electric) == 0) {
            $categoryID = 103;
        }
        elseif (strcmp($category, $water) == 0) {
            $categoryID = 102;
        }
        elseif (strcmp($category, $gas) == 0) {
            $categoryID = 101;
        }
        else {
            $categoryID = 201;
        }
        $temp_array = Array("id" => $id,
                       "date" => $date,
                       "merchant" => $merchant,
                       "amount" => $amount + 0.0,
                       "type" => $type,
                       "categoryID" => $categoryID,
                       "category" => $category,
                       "isExpense" => true
        );
        $obj[$id-1] = $temp_array;

        $id = ($id + 1);
                
        //printf("Name: " . $row["username"]. "    Password:" . $row["userpassword"]);
    }
} else {
    $temp_array = Array("id" => $id,
        "date" => $date,
        "merchant" => $merchant,
        "amount" => $amount + 0.0,
        "type" => $type,
        "categoryID" => $categoryID,
        "category" => $category,
        "isExpense" => true
    );

    $obj[0] = $temp_array;
}
//$string_response = implode(",", $response);
$json = json_encode($obj);
echo ($json);
//file_put_contents('./bills_info.json', $json);

$connect->close();

?>
