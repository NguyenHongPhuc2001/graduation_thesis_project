import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_thesis_project/utils/style.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white
        ),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(0, 5)
                      )
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              offset: const Offset(0, 0), // changes position of shadow
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
                            "Đăng nhập",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Color(0xE5AAAAAA)
                            ),
                          )
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 35, right: 35, top: 30),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            const TextField(
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintText: "Nhập tài khoản",
                                  hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black
                                  )
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                const TextField(
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    hintText: "Nhập mật khẩu",
                                    hintStyle: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 2
                                      )
                                    ]
                                  ),
                                  child: const Icon(
                                      Icons.remove_red_eye,
                                      size: 15,
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
                      const Text(
                        "Quên mật khẩu...",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    color: const Color(0xE5E5E5E5),
                    width: MediaQuery.of(context).size.width * 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: (){

                            },
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              minimumSize: const Size(250, 30)
                            ),
                            child: const Text(
                                "Đăng nhập"
                            ),
                        ),
                        ElevatedButton(
                          onPressed: (){

                          },
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              minimumSize: const Size(250, 30),
                              primary: const Color(0xFFEE1D1D)
                          ),
                          child: const Text(
                              "Đăng ký"
                          ),
                        ),
                      ]
                    ),
                  ),
              )
            ],
          ),
        ),
    );
  }
}
