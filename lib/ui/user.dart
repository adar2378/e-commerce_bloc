import 'package:flutter/material.dart';
import 'package:just_like_this/ui/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends StatefulWidget {
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  void initState() {
    super.initState();
    getLayout();
    
  }
  
  navigate(){
    
      
    
     
  }

  String user;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: user == "Adar"?
        Container(child: Text(user),):
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: getLayout,
              child: Text(user ?? "GG"),
            ),
             RaisedButton(
              onPressed: deletUser,
              child: Text("Remove"),
            )
          ],
        ),
      ),
    );
  }


  deletUser() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('user');
    setState(() {
      user = pref.getString('user') ?? "0";
    });
  }
  getLayout() async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('user', 'Adar');

    print("Was here : " + pref.getString('user'));
    setState(() {
      user = pref.getString('user') ?? "0";
    });
    if(pref.getString('user') == "Adar"){
       Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Menu()
                    ));
    }
  }
}
