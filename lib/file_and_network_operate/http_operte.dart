import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/*

1:
使用 Dart:io 库的 HttpClient来发起Http请求，以及相关的
请求配置、代理设置以及证书校验等，可以发现直接通过HttpClient发起网络请求还是比较麻烦的。值得注意的是，
HttpClient提供的大所数属性和方法最终会作用在请求的header里，我们完全可以通过手动去设置header来实现，
之所以提供这些方法，只是为了方便开发者而已。

dart:io 提供的 HTTP 相关配置可以参考 ： https://book.flutterchina.club/chapter11/http.html#_11-2-5-证书校验

另外，Http协议是一个非常重要的、使用最多的网络协议，每一个开发者都应该对 http 协议非常熟悉。


2: Dio: https://github.com/cfug/dio/blob/main/dio/README-ZH.md
dio是一个强大的Dart Http请求库，支持Restful API、FormData、拦截器、请求取消、Cookie管理、
文件上传/下载、超时等。dio的使用方式随着其版本升级可能会发生变化，如果本节所述内容和最新dio功能有差异，请以最新的dio文档为准。

 Dio 是对HTTPClient 的封装，request 是采用dart 库 自有的HTTPClient。
 */

class HttpOperateTest extends StatefulWidget {
  const HttpOperateTest({super.key});

  @override
  State<HttpOperateTest> createState() => _HttpOperateTestState();
}

class _HttpOperateTestState extends State<HttpOperateTest> {
  Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Network')),
      body: Center(
        child: FutureBuilder(
            future: _dio
                .get("https://api.github.com/orgs/flutterchina/repos"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //请求完成
              //请求完成
              if (snapshot.connectionState == ConnectionState.done) {
                Response response = snapshot.data;
                //发生错误
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                //请求成功，通过项目信息构建用于显示项目名称的ListView
                return ListView(
                  children: response.data
                      .map<Widget>(
                          (e) => ListTile(title: Text(e["full_name"])))
                      .toList(),
                );
              }
              //请求未完成时弹出loading
              return CircularProgressIndicator();
            }),
      ),
    );
  }


  /// 一个 Dart 库 提供的 HTTP HttpClient 请求 sample，只供参考
  void request() async {
    // setState(() {
    //   _loading = true;
    //   _text = "正在请求...";
    // });

    var result;
    final PEM = ''; // 可以从文件读取

    try {
      /// 对于自签名的证书，我们也可以将其添加到本地证书信任链中，这样证书验证时就会自动通过，
      /// 而不会再走到badCertificateCallback回调中
      /// 通过setTrustedCertificates()设置的证书格式最好为 PEM 。
      SecurityContext sc = SecurityContext();
      sc.setTrustedCertificates(File('path').path);

      //创建一个HttpClient
      HttpClient httpClient = HttpClient(context: sc);

      Uri _uri = Uri.parse("https://www.baidu.com");

      /// Add credentials to be used for authorizing HTTP requests.
      /// 请求认证
      httpClient.addCredentials(
        _uri,
        "admin",
        HttpClientBasicCredentials("username", "password"), //Basic认证凭据
        // HttpClientDigestCredentials("username","password")
      );

      /// add proxy
      httpClient.findProxy = (uri) {
        return 'DIRECT';
      }; // DIRECT: no need proxy};
      // httpClient.addProxyCredentials(host, port, realm, credentials);

      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        if (cert.pem == PEM) {
          return true; //证书一致，则允许发送数据
        }
        return false;
      };

      //打开Http连接
      HttpClientRequest request = await httpClient.getUrl(_uri);
      //使用iPhone的UA
      request.headers.add(
        "user-agent",
        "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1",
      );
      //等待连接服务器（会将请求信息发送给服务器）
      HttpClientResponse response = await request.close();
      //读取响应内容
      result = await response.transform(utf8.decoder).join();
      //输出响应头
      print(response.headers);

      //关闭client后，通过该client发起的所有请求都会终止。
      httpClient.close();
    } catch (e) {
      result = "请求失败：$e";
    } finally {
      // setState(() {
      //   _loading = false;
      // });
    }
  }
}
