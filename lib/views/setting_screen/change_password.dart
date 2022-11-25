import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/services/remote_services.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String? password;
  String? newPassword;
  String? rePassword;

  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final rePasswordController = TextEditingController();

  bool currentPassIsClick = false,
      newPassIsClick = false,
      rePassIsClick = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPassIsClick = false;
    newPassIsClick = false;
    rePassIsClick = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: const Text(
            "Thay đổi mật khẩu",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20.0,
            ),
          ),
          elevation: 2,
        ),
        body: Scrollbar(
            child: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: passwordController,
                          onChanged: (value) => password = value,
                          autofocus: false,
                          obscureText: !currentPassIsClick,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 15, top: 5, bottom: 15),
                            enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Mật khẩu hiện tại",
                            hintStyle: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            currentPassIsClick=!currentPassIsClick;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: const [
                                BoxShadow(color: Colors.black, blurRadius: 2)
                              ]),
                          child: Icon(
                            (currentPassIsClick ==  true)?CupertinoIcons.eye_slash_fill:Icons.remove_red_eye,
                            size: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: newPasswordController,
                          onChanged: (value) => newPassword = value,
                          autofocus: false,
                          obscureText: !newPassIsClick,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 15, top: 5, bottom: 15),
                            enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Mật khẩu mới",
                            hintStyle: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            newPassIsClick = !newPassIsClick;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: const [
                                BoxShadow(color: Colors.black, blurRadius: 2)
                              ]),
                          child: Icon(
                            (newPassIsClick==true)?CupertinoIcons.eye_slash_fill:Icons.remove_red_eye,
                            size: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: rePasswordController,
                          onChanged: (value) => rePassword = value,
                          autofocus: false,
                          obscureText: !rePassIsClick,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 15, top: 5, bottom: 15),
                            enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Nhập lại mật khẩu mới",
                            hintStyle: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            rePassIsClick = !rePassIsClick;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: const [
                                BoxShadow(color: Colors.black, blurRadius: 2)
                              ]),
                          child: Icon(
                            (rePassIsClick==true)?CupertinoIcons.eye_slash_fill:Icons.remove_red_eye,
                            size: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                RemoteService()
                    .changePassword("ChuTT", password, newPassword, rePassword);
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                minimumSize: const Size(230.0, 30.0),
              ),
              child: const Text(
                "Cập nhật",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ),
          ),
        ])));
  }
}
