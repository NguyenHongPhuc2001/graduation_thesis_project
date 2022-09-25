import 'package:flutter/material.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xE9ECEFED),
      appBar: AppBar(
        title: const Text(
          "Quản lý tài khoản",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.0
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20.0,
          ),
        ),
        elevation: 2,
      ),
      body: Scrollbar(
        child: Column(
          children: [
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
                            height : 40,
                            child: TextField(
                              autofocus: false,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 15, top: 5, bottom: 15),
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Mật khẩu hiện tại",
                                hintStyle: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300
                                ),
                              ),
                        ),
                          ),
                        Container(
                          padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        SizedBox(
                          height : 40,
                          child: TextField(
                            autofocus: false,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 15, top: 5, bottom: 15),
                              enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Mật khẩu mới",
                              hintStyle: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        SizedBox(
                          height : 40,
                          child: TextField(
                            autofocus: false,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 15, top: 5, bottom: 15),
                              enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Nhập lại mật khẩu mới",
                              hintStyle: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: (){

                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: const Size(230.0, 30.0),
                ),
                child: const Text(
                  "Cập nhật",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10
                  ),
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}
