import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerCard extends StatelessWidget {

 List<Widget> _listWidget;

   DrawerCard(this._listWidget);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Image.asset("assets/profile.jpg"),
              ),
              accountName: Text("Zian Fahrudy"),
              accountEmail: Text("zianfahrudy@gmail.com")),
          GestureDetector(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.offNamed('/category');
            },
            child: ListTile(
              leading: Icon(Icons.category),
              title: Text("Category"),
            ),
          ),

          Column(children: _listWidget,),
        ],
      ),
    );
  }
}
