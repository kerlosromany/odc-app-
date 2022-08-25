import 'package:flutter/material.dart';
import 'package:instant_project/constants/components.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              signOut(context);
            },
            icon: const Icon(Icons.more_horiz),
          ),
        ],
        
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: const [
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.greenAccent,
                        radius: 40,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Text("Kerolos Romany" , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),),
                ],
               
              ),
              const SizedBox(height: 15.0,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                     const Card(
                      elevation: 1,
                      color: Color.fromARGB(255, 255, 252, 222),
                       child: ListTile(
                        leading: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.star , color: Colors.yellowAccent,),
                        ),
                        title: Text("You have 30 points"),
                                       ),
                     ),
                    const SizedBox(height: 15.0,),
                    const Text("Edit Profile" , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),),
                    const SizedBox(height: 15.0,),
                    buildEditProfile("Change Name"),
                    const SizedBox(height: 15.0,),
                    buildEditProfile("Change Email"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildEditProfile(String text) {
    return InkWell(
                    child: Card(
                      elevation: 10,
                      color: Colors.white,
                      child: ListTile(
                        leading: const CircleAvatar(
                          
                          backgroundColor: Color.fromARGB(255, 0, 30, 1),
                          
                          child: Icon(Icons.swap_horiz),
                        ),
                        title:  Text(text , style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),),
                        trailing:  const Icon(Icons.trending_flat , color: Colors.black,),
                      ),
                    ),
                  );
  }
}
