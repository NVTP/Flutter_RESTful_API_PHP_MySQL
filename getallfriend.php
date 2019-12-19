<?php
#เป็น service เพื่อใช้ค้นหาและนำข้อมูลทั้งหมดจากตาราง myfriend_tb มาใช้งาน
    //require headers
    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json; charset=UTF-8");

    //database connection will be here and include database and object files
    include_once 'database.php';
    include_once 'friend.php';

    //instantiate database and friend object
    $database = new Database();
    $db = $database->getConnection();

    //initialize object
    $friend = new Friend($db);

    //read friend will be here and query friend
    $stmt = $friend->getallfriend();
    $num = $stmt->rowCount();

    if ($num>0) {
        $friend_arr = array();

        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            //extract row
            extract($row);
            $friend_item = array(
                "id"=>$id,
                "name"=>$name,
                "email"=>$email,
                "age"=>$age,
                "status"=>$status,
                "datatime_add"=>$datetime_add,
            );
            array_push($friend_arr,$friend_item);
        }

        //set response code - 200 OK
        http_response_code(200);

        #show products data in json format
        echo json_encode($friend_arr);
    }
?>