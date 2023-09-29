import 'package:fire_base_conn/helper/firebase_helper.dart';
import 'package:fire_base_conn/screen/home_screen/contoller/home_contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.userDetails = FirebaseHelper.firebaseHelper.userDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Profile view',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),

              CircleAvatar(
                radius: 55,
                backgroundImage:
                    NetworkImage("${controller.userDetails!['photo']}"),
              ),
              controller.userDetails!['photo'] == null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.camera,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.photo,
                            size: 25,
                          ),
                        ),
                      ],
                    )
                  : Container(),
              // detail
              const SizedBox(
                height: 10,
              ),
              buildListTile(Icons.person,
                  "${controller.userDetails!['name'] ?? 'Name not verify'}"),
              buildListTile(Icons.email,
                  "${controller.userDetails!['email'] ?? 'Email not verify'}"),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            "home Screen",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            //image
            SizedBox(
              height: 10,
            ),

            CircleAvatar(
              radius: 55,
              backgroundImage:
                  NetworkImage("${controller.userDetails!['photo']}"),
            ),

            // pickimage
            controller.userDetails!['photo'] == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.photo,
                          size: 25,
                        ),
                      ),
                    ],
                  )
                : Container(),
            // detail
            const SizedBox(
              height: 10,
            ),
            buildListTile(Icons.person,
                "${controller.userDetails!['name'] ?? 'Name not verify'}"),
            buildListTile(Icons.email,
                "${controller.userDetails!['email'] ?? 'Email not verify'}"),
            // buildListTile(Icons.phone,
            //     "${controller.userDetails!['phone'] ?? 'Phone number not verify'}"),
            //sign out
            SizedBox(
              height: 30.h,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                              radius: 35,
                              child: Icon(Icons.admin_panel_settings_outlined)),
                          const Text(
                            "you are shore  !",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Are you sure to signout",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black38),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              String msg =
                                  await FirebaseHelper.firebaseHelper.signOut();
                              if (msg == "SignOut Successfully") {
                                Get.offAllNamed("/");
                              } else {
                                Get.snackbar("", "$msg",
                                    colorText: Colors.black,
                                    backgroundColor: Colors.blue.shade50);
                              }
                            },
                            child: const Text("Sign Out"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}

ListTile buildListTile(IconData i1, String data) {
  return ListTile(
    leading: Icon(
      i1,
    ),
    title: Text(
      "$data",
      style: const TextStyle(fontSize: 15, color: Colors.black),
    ),
  );
}
