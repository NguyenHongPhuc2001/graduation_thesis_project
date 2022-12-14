import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/views/setting_screen/about_us.dart';
import 'package:graduation_thesis_project/views/setting_screen/change_password.dart';
import 'package:graduation_thesis_project/views/setting_screen/login.dart';
import 'package:graduation_thesis_project/views/transaction_screen/wallet_screen/wallet_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountManagement extends StatefulWidget {
  const AccountManagement({Key? key}) : super(key: key);

  @override
  State<AccountManagement> createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      backgroundColor: const Color(0xE9ECEFED),
      appBar: AppBar(
        title: const Text(
          "Quản lý tài khoản",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Scrollbar(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                const SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "images/simple_avatar.png")),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 2,
                                        )
                                      ]),
                                  child: SvgPicture.asset("images/camera.svg"),
                                )
                              ],
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "USER NAME",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletList(isTransaction:false)));
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                minimumSize: const Size(230.0, 30.0),
                                primary: const Color(0xfffaefe7),
                              ),
                              child: const Text(
                                "Ví của tôi",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  minimumSize: const Size(230.0, 30.0),
                                  primary: Colors.white),
                              child: const Text(
                                "Cài đặt ứng dụng",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AboutUs(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  minimumSize: const Size(230.0, 30.0),
                                  primary: Colors.white),
                              child: const Text(
                                "Liên hệ chúng tôi",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(const ChangePassword());
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(230.0, 30.0),
                  ),
                  child: const Text(
                    "Thay đổi mật khẩu",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
                ElevatedButton(
                  onPressed: ()async {
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    pref.clear();
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => Login()), (
                            route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(230.0, 30.0),
                  ),
                  child: const Text(
                    "Đăng xuất",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
                SizedBox(height: size.width * 0.1)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
