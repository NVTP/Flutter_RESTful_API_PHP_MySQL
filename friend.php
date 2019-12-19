<?php
//เพื่อใช้จัดการ(insert/update/delete/select) กับข้อมูลที่จะทำงานกับฐานข้อมูล
    class Friend{
        //database connection
        private $conn;

        //object properties
        public $id;
        public $name;
        public $email;
        public $age;
        public $status;
        public $datetime_add;

        //construtor with $db as database connection
        public function __construct($db){
            $this->conn = $db;
        }

        //--------------------------------------------------
        //get all friend
        function getallfriend(){

            //delect all query
            $query = "SELECT * FROM myfriend_tb";

            //prepare query statement
            $stmt = $this->conn->prepare($query);

            //execute query
            $stmt->execute();

            return $stmt;
        }

        //------------------------------------------------
        //insert friend
        function insertfriend(){
            //query to insert record
            $query = "INSERT INTO  myfriend_tb SET
                        name=:name,
                        email=:email,
                        age=:age,
                        status=:status,
                        datetime_add=:datetime_add";
            //prepare query
            $stmt = $this->conn->prepare($query);
            
            //sanitize
            $this->name=htmlspecialchars(strip_tags($this->name));
            $this->email=htmlspecialchars(strip_tags($this->email));
            $this->age=htmlspecialchars(strip_tags($this->age));
            $this->status=htmlspecialchars(strip_tags($this->status));
            $this->datetime_add=htmlspecialchars(strip_tags($this->datetime_add));

            //bind values
            $stmt->bindParam(":name",$this->name);
            $stmt->bindParam(":email",$this->email);
            $stmt->bindParam(":age",intval($this->age));
            $stmt->bindParam(":status",intval($this->status));
            $stmt->bindParam(":datetime_add",$this->datetime_add);

            //execute query
            if ($stmt->execute()) {
                return true;
            }

            return false;
        }

        //-------------------------------------------------
        //update the friend
        function updatefriend(){
            //update query
            $query = "UPDATE myfriend_tb SET
                        name=:name,
                        email=:email,
                        age=:age,
                        status=:status
                    WHERE
                        id=:id";

            //prepare query statement
            $stmt = $this->conn->prepare($query);

            //sanitize
            $this->id=htmlspecialchars(strip_tags($this->id));
            $this->name=htmlspecialchars(strip_tags($this->name));
            $this->email=htmlspecialchars(strip_tags($this->email));
            $this->age=htmlspecialchars(strip_tags($this->age));
            $this->status=htmlspecialchars(strip_tags($this->status));

            //bind new values
            $stmt->bindParam(":id",intval($this->id));
            $stmt->bindParam(":name",($this->name));
            $stmt->bindParam(":email",($this->email));
            $stmt->bindParam(":age",intval($this->age));
            $stmt->bindParam(":status",intval($this->status));

            //execute the query
            if($stmt->execute()){
                return true;
            }

            return false;
        }

        //----------------------------------------------------.
        //delete the friend
        function deletefriend(){

            //delete query
            $query = "DELETE FROM myfriend_tb WHERE id=:id";

            //prepare query
            $stmt = $this->conn->prepare($query);

            //sanitize
            $this->id=htmlspecialchars(strip_tags($this->id));

            //bind id of record to delete
            $stmt->bindParam(":id",intval($this->id));

            //execute query
            if($stmt->execute()){
                return true;
            }

            return false;
        }
    }
?>