import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name = 'Muhammad Abdullah';
  final String email = 'abdullahwale@gmail.com';
  final String phone = '+923046983794';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Stack Widget - Simple example
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('images/abd.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Column Widget - Simple example
              Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    email,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    phone,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Row Widget - Simple example
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Email'),
                  Text('Phone'),
                  Text('Address'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('abdullahwale@gmail.com'),
                  Text('+923046983794'),
                  Text('Aljannat Colony vehari'),
                ],
              ),
              SizedBox(height: 20),
              // ListView Widget - Simple example
              Container(
                height: 150,
                child: ListView(
                  children: [
                    Text('Flutter Development'),
                    Text('Mobile App Development'),
                    Text('Web Development'),
                    Text('Database Management'),
                    Text('UI/UX Design'),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: null),
      )
    );
  }
}