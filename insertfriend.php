<?php
#เป็น service เพื่อใช้บันทึกเพิ่มข้อมูลลงตาราง myfriend_tb
//required headers
    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json; charset=UTF-8");

    //database connection will be here and include database and object files
    include_once'database.php';
    include_once'friend.php';

    //instantiate database and friend object
    $database = new Database();
    $db = $database->getConnection();

    //initialize object
    $friend = new Friend($db);

    //get posted data
    $data = json_decode(file_get_contents("php://input"));

    //set friend property values
    $friend->name = $data->name;
    $friend->email = $data->email;
    $friend->age = $data->age;
    $friend->status = $data->status;
    $friend->datetime_add = date('Y-m-d h:i:sa');

    //insert the friend
    if($friend->insertfriend()){
        //set response code - 200 created
        http_response_code(200);

        //tell the user
        echo json_encode(array("message" => "1"));
    }else{
        //set response code - 503 service unavailable
        http_response_code(503);

        //tell the user
        echo json_encode(array("message" => "2"));
    }
?>