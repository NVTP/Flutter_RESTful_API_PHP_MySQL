import 'package:flutter/material.dart';
import 'update_delete_friend_ui.dart';
import 'add_friend_ui.dart';
import 'api_service.dart';
import 'progress_dialog.dart';

class ShowAllFriendUI extends StatefulWidget {
  @override
  _ShowAllFriendUIState createState() => _ShowAllFriendUIState();
}

class _ShowAllFriendUIState extends State<ShowAllFriendUI> {
  ProgressDialog progressDialog = ProgressDialog.getProgressDialog('Processing....', true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Show All Friend'
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getallfriend(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.separated(
              separatorBuilder: (context, index){
                return Divider(
                  color: Colors.grey,
                  height: 0.0,
                );
              },
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return ListTile(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return UpdateDeleteFriendUI(
                              id: snapshot.data[index].id,
                              name: snapshot.data[index].name,
                              email: snapshot.data[index].email,
                              age: snapshot.data[index].age,
                              status: snapshot.data[index].status,
                            );
                          },
                        ),
                    );
                  },
                  leading: Icon(
                    Icons.person,
                    color: index % 2 == 0 ? Colors.red : Colors.green,
                  ),
                  title: Text(
                      '${snapshot.data[index].name}',
                  ),
                  subtitle: Text(
                    '${snapshot.data[index].email}',
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                  ),
                );
              },
            );
          }else if(snapshot.hasError){
            return Text('${snapshot.error}');
          }else{
            return progressDialog;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context){
                return AddFriendUI();
              }
            ),
          );
        },
      ),
    );
  }
}
