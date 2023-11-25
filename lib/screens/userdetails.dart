import 'package:flutter/material.dart';

class UserDetailsScreeen extends StatefulWidget {
  final String username;
  final String userEmail;
  final String createdAt;

  const UserDetailsScreeen(
      {super.key,
      required this.username,
      required this.userEmail,
      required this.createdAt});

  @override
  State<UserDetailsScreeen> createState() => _UserDetailsScreeenState();
}

class _UserDetailsScreeenState extends State<UserDetailsScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UserDetails"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.supervised_user_circle),
                  ),

                  const SizedBox(
                    height: 20,
                  ),



                  Text(
                    widget.username,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.userEmail),
                  const Expanded(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Created on :"),
                      Text(widget.createdAt),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
