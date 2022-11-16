import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: const Text(
            "Thông tin liên hệ",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20.0,
            ),
          ),
          elevation: 2,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset("images/about_us.svg"),
              ),
              RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "ỨNG DỤNG ĐƯỢC XÂY DỰNG BỞI"
                      ),
                      TextSpan(
                        text: " CP TEAM \n",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      ),
                      TextSpan(
                        text: "MỌI THÔNG TIN LIÊN HỆ \n"
                      ),
                      TextSpan(
                        text: "1800-0909"
                      )
                    ],
                    style: TextStyle(
                      color: Colors.black
                    )
                  ),
                textAlign: TextAlign.center,
              )

              // const Text(
              //   "ỨNG DỤNG ĐƯỢC XÂY DỰNG BỞI CP TEAM \n MỌI THÔNG TIN LIÊN HỆ \n 1800-0909",
              //   textAlign: TextAlign.center,
              // ),
            ],
          ),
        )
    );

  }
}
