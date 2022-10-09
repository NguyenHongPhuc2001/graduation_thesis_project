import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  final String data;

  const AddNote({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _noteController = TextEditingController();

  var noteData;

  @override
  void initState() {
    noteData = widget.data;
    _noteController.text = widget.data;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            "Nhập ghi chú",
            style: TextStyle(
              fontSize: size.width * 0.065,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  noteData = _noteController.text;
                });
                Navigator.pop(context, noteData);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.03),
                    child: _textContainer(
                      text: "LƯU",
                      textColor: Colors.black,
                      textSize: size.width * 0.06,
                      textFontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Container(
          width: size.width,
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.03, top: size.width * 0.03),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _noteController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Nhập ghi chú",
                hintStyle: TextStyle(
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                focusedBorder: InputBorder.none,
                isDense: true,
              ),
              enabled: true,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: size.width * 0.05,
                color: Colors.black,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _textContainer extends StatelessWidget {
  final String text;
  final Color textColor;
  final double textSize;
  final FontWeight textFontWeight;
  final TextDecoration decoration;

  const _textContainer({
    Key? key,
    required this.text,
    required this.textColor,
    required this.textSize,
    required this.textFontWeight,
    required this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textSize,
        color: textColor,
        fontWeight: textFontWeight,
        decoration: decoration,
      ),
    );
  }
}
