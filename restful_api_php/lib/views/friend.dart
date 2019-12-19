//TODO  เพื่อใชในการจัดการกับขอมูลเพื่อน ทั้งการจัดขอมูลในรูปแบบของ JSON (fromJson) เพื่อสงขอมูลไปยัง Server และการแปลงขอมูล JSON (toJson) ที่ไดรับมาจาก Server มา ทําเปนขอมูลเพื่อพรอมใชงาน
class Friend{
  String id;
  String name;
  String email;
  String age;
  String status;
  String datetimeAdd;

  Friend({
    this.id,
    this.name,
    this.email,
    this.age,
    this.status,
    this.datetimeAdd,
});

  factory Friend.fromJson(Map<String, dynamic> json)=> Friend(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    age: json["age"],
    status: json["status"],
    datetimeAdd: json["datatime_add"],
  );

  Map<String, dynamic>toJson()=>{
    "id": id,
    "name": name,
    "email": email,
    "age": age,
    "status": status,
    "datatime_add": datetimeAdd,
  };
}