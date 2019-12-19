// todo เพื่อใช้ในการติดต่อกับ WebService (RESTful API) เพื่อส่ง request หรือรับ response จาก Server เพื่อการทำงานใดๆ ของตัว Application
import 'dart:io';
import 'friend.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//TODO------------- เรียกใช้ Service เพื่อดึงข้อมูลเพื่อนทั้งหมดมาแสดง
Future<List<Friend>>getallfriend()async{
  final response = await http.get(
    Uri.encodeFull('http://192.168.1.15/myfriend/getallfriend.php'),
    headers: {"Content-Type":"application/json"},
  );

  if(response.statusCode == 200){
    final response_data = jsonDecode(response.body);

    final friend_data = await response_data.map<Friend>((json){
      return Friend.fromJson(json);
    }).toList();

    return friend_data;
  }else{
    throw Exception('Fail to load Todo from the Internet');
  }
}

//TODO--------------------------- เรียกใช้ Service เพื่อส่งข้อมูลไปบันทึกเพิ่มลงตารางในฐานข้อมูล
Future<String> insertfriend(String name, String email, String age, String status)async{
  Friend friend = Friend(name: name, email: email, age: age, status: status);

  final response = await http.post(
    Uri.encodeFull('http://192.168.1.15/myfriend/insertfriend.php'),
    body: json.encode(friend.toJson()), //TODO แปลงข้อมูลเป็น JSON ก่อนส่งไป
    headers: {"Content-Type":"application/json"},
  );

  if(response.statusCode == 200){
    final response_data = await json.decode(response.body);
    return response_data['message'];
  }else{
    throw Exception('Failed to insert a Task. Error: ${response.toString()}');
  }
}

//TODO--------------------------- เรียกใช้ Service เพื่อส่งข้อมูลไปบันทึกแก้ไขลงตารางในฐานข้อมูล
Future<String>updatefriend(String id, String name, String email, String age, String status)async{
  Friend friend = Friend(id: id, name: name, email: email, age: age, status: status);

  final response = await http.post(
    Uri.encodeFull('http://192.168.1.15/myfriend/updatefriend.php'),
    body: json.encode(friend.toJson()),
    headers: {"Content-Type":"application/json"},
  );
  
  if(response.statusCode == 200){
    final response_data = await json.decode(response.body);
    return response_data['message'];
  }else{
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}

//TODO--------------------------- เรียกใช้ Serveice เพื่อส่งข้อมูลเพื่อไปลบข้อมูลออกจากตารางในฐานข้อมูล
Future<String>deletefriend(String id)async{
  Friend friend = Friend(id: id);

  final response = await http.post(
    Uri.encodeFull('http://192.168.1.15/myfriend/deletefriend.php'),
    body: json.encode(friend.toJson()),
    headers: {"Content-Type":"application/json"},
  );

  if(response.statusCode == 200){
    final response_data = await json.decode(response.body);
    return response_data['message'];
  }else{
    throw Exception('Failed to delete a Task. Error: ${response.toString()}');
  }
}