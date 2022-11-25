import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/account_controller.dart';
import 'package:graduation_thesis_project/views/setting_screen/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passIsClick = false, rePassIsClick = false;

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 2, offset: Offset(0, 5))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            margin: const EdgeInsets.only(top: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: 45,
                              height: 45,
                              child: SvgPicture.asset("images/logo_money.svg"),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: const Text(
                              "Money Spending",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                "Đăng ký",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: Color(0xE5AAAAAA)),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 35, right: 35, top: 30),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          TextField(
                            controller: userNameController,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                hintText: "Nhập tài khoản",
                                hintStyle: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.grey)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              TextField(
                                controller: passwordController,
                                obscureText: !passIsClick,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintText: "Nhập mật khẩu",
                                  hintStyle: TextStyle(
                                      fontSize: size.width * 0.04,
                                      color: Colors.grey),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    passIsClick = !passIsClick;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black, blurRadius: 2)
                                      ]),
                                  child: passIsClick
                                      ? Icon(
                                          CupertinoIcons.eye_slash_fill,
                                          size: size.width * 0.05,
                                        )
                                      : Icon(
                                          Icons.remove_red_eye,
                                          size: size.width * 0.05,
                                        ),
                                ),
                              )
                            ],
                          ),
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              TextField(
                                controller: rePasswordController,
                                obscureText: !rePassIsClick,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintText: "Nhập lại mật khẩu",
                                  hintStyle: TextStyle(
                                      fontSize: size.width * 0.04,
                                      color: Colors.grey),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    rePassIsClick = !rePassIsClick;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black, blurRadius: 2)
                                      ]),
                                  child: rePassIsClick
                                      ? Icon(
                                          CupertinoIcons.eye_slash_fill,
                                          size: size.width * 0.05,
                                        )
                                      : Icon(
                                          Icons.remove_red_eye,
                                          size: size.width * 0.05,
                                        ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final check = await AccountController().signUp(
                            userNameController.text,
                            passwordController.text,
                            rePasswordController.text);

                        if (check == true) {
                          Fluttertoast.showToast(msg: "Đăng ký thành công !");
                          userNameController.clear();
                          passwordController.clear();
                          rePasswordController.clear();
                        } else {
                          Fluttertoast.showToast(msg: "Đăng ký thất bại !");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          minimumSize: const Size(250, 30),
                          primary: const Color(0xFFEE1D1D)),
                      child: const Text("Đăng ký"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          minimumSize: const Size(250, 30)),
                      child: const Text("Trở về"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
