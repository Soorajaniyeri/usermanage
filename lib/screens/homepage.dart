import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:machintest/screens/userdetails.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List listUsers = [];
  final myBox = Hive.box('fav');

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  String? date;

  getData() {
    Box myBox = Hive.box("fav");

    if (myBox.get("users") != null) {
      listUsers = myBox.get("users");
    } else {
      print("null");
    }
  }

  addData(
      {required String userName,
      required String userEmail,
      required String date}) async {
    listUsers.add({"name": userName, "email": userEmail, "date": date});
    await myBox.put("users", listUsers);
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(date);
    print(listUsers);
    getData();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          nameCtrl.clear();
          emailCtrl.clear();
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameCtrl,
                          decoration: const InputDecoration(
                              hintText: "Enter user name",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: emailCtrl,
                          decoration: const InputDecoration(
                              hintText: "Enter user email",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              print(date);
                              DateTime? store = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2025));
                              if (store != null) {
                                date = store.toString();
                              } else {}
                            },
                            child: const Text("select date")),
                        ElevatedButton(
                            onPressed: () {
                              if (nameCtrl.text.isNotEmpty &&
                                  emailCtrl.text.isNotEmpty &&
                                  date != null) {
                                addData(
                                    userName: nameCtrl.text,
                                    userEmail: emailCtrl.text,
                                    date: date!);

                                Navigator.pop(context);

                                setState(() {});
                              } else {
                                Fluttertoast.showToast(
                                    backgroundColor: Colors.red,
                                    msg: "Please fill all fields");
                              }
                            },
                            child: const Text("Submit"))
                      ],
                    ),
                  ));
        },
      ),
      appBar: AppBar(
        title: const Text("Manage Users"),
        centerTitle: true,
      ),
      body:
          
          listUsers.isEmpty? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    Image(
                height: 150,
                    image: AssetImage("assets/nouse.png")),
                
                Text("No users found")
                  ],
            ),
          ):
      
      Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return UserDetailsScreeen(
                        username: listUsers[index]['name'],
                        userEmail: listUsers[index]['email'],
                        createdAt: listUsers[index]['date'],
                      );
                    },
                  )),
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      listUsers.removeAt(index);
                                      myBox.put("users", listUsers);

                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: const Text("Delete now"))
                              ],
                              title: const Text(
                                "Are you sure want to delete this user data ??",
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey.shade600,
                      )),
                  title: Text(listUsers[index]['name']),
                  subtitle: Text(listUsers[index]['email']),
                  leading: const CircleAvatar(
                    child: Icon(Icons.supervised_user_circle),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
