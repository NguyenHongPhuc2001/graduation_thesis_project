import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                      margin: const EdgeInsets.only(left: 35),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: SvgPicture.asset("images/logo_money.svg"),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
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
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Đăng ký",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Color(0xE5AAAAAA)
                                  ),
                                )
                            ),
                          ],
                      ),
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
                          ),
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              const TextField(
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintText: "Nhập lại mật khẩu",
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
                    ElevatedButton(
                      onPressed: (){

                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          minimumSize: const Size(250, 30)
                      ),
                      child: const Text(
                          "Trở về"
                      ),
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
