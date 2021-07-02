import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:weichatdemo/signature/signature_draw.dart';

class TestSignatureDraw extends StatefulWidget {
  const TestSignatureDraw({Key key}) : super(key: key);

  @override
  _TestSignatureDrawState createState() => _TestSignatureDrawState();
}

class _TestSignatureDrawState extends State<TestSignatureDraw> {

  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 10, // 线条宽度
    penColor: Colors.black, // 线条颜色
    exportBackgroundColor: Colors.transparent, // 导出图片背景色
  );

  bool landScape = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: FittedBox(
          fit: BoxFit.contain,
          child: DrawView(
            signatureController: _signatureController,
            width: 370,
            height: 690,
            landScape: false,
            biggerCallback: () {
              setState(() {
                landScape = false;
              });
            },
            resetCallback: () {
              setState(() {
                landScape = false;
              });
            },
          ),
        ),
      ),
    );
  }
}
