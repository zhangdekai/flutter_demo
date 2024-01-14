import 'package:flutter/material.dart';
// import 'package:niuzhuang/Utils/Utils.dart';
import 'package:signature/signature.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawView extends StatefulWidget {
  final signatureController;
  final biggerCallback; // 放大回调
  final resetCallback; // 还原大小回调
  final double width;
  final double height;
  final bool? landScape; // 是否横屏
  DrawView(
      {Key? key,
        this.signatureController,
        this.biggerCallback,
        this.resetCallback,
        required this.width,
        required this.height,
        this.landScape = false})
      : super(key: key);

  @override
  _DrawViewState createState() => _DrawViewState();
}

class _DrawViewState extends State<DrawView> {
  bool isEmpty = true;

  @override
  void initState() {
    super.initState();

    if (widget.signatureController.value.length > 0) {
      isEmpty = false;
    } else {
      isEmpty = true;
    }

    // 监听画板
    widget.signatureController.addListener(() {
      bool tmpIsEmpty = true;
      if (widget.signatureController.value.length > 0) {
        tmpIsEmpty = false;
      } else {
        tmpIsEmpty = true;
      }
      if (isEmpty != tmpIsEmpty) {
        if (this.mounted) {
          setState(() {
            isEmpty = tmpIsEmpty;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: widget.landScape! ? 1 : 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Signature(
            controller: widget.signatureController,
            width: widget.width,
            height: widget.height,
            backgroundColor: Colors.white,
          ),
          // 暂无签名
          Offstage(
            offstage: isEmpty ? false : true,
            child: Text(
              '签名（必填）',
              style: TextStyle(
                fontSize: 44,
                color: Color(0xFFA5ACB4),
              ),
            ),
          ),
          // 放大按钮
          Positioned(
            top: 10,
            right: widget.landScape! ? 0 : 10,
            child: IconButton(
              icon: Icon(Icons.baby_changing_station),
              onPressed: () {
                widget.biggerCallback();
              },
            ),
          ),
          // 橡皮 & 完成 按钮
          Positioned(
            bottom: 10,
            right: widget.landScape! ? 0 : 10,
            child: Row(
              children: [
                // 橡皮
                IconButton(
                  icon: Icon(Icons.ac_unit),
                  onPressed: () {
                    setState(() {
                      widget.signatureController.clear();
                    });
                  },
                ),
                // 完成
                Offstage(
                  offstage: widget.landScape! ? false : true,
                  child: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.amberAccent,
                    ),
                    child: TextButton(
                      child: Text(
                        '完成',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        widget.resetCallback();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}