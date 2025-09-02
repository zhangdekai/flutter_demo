import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class QuillEditorDemo extends StatefulWidget {
  const QuillEditorDemo({super.key});

  @override
  _QuillEditorDemoState createState() => _QuillEditorDemoState();
}

class _QuillEditorDemoState extends State<QuillEditorDemo> {
  // 富文本控制器 - 11.0.0版本中保持核心功能，但内部实现有优化
  late QuillController _controller;

  // 编辑模式开关
  bool _isEditing = true;

  // 图片选择器
  final ImagePicker _imagePicker = ImagePicker();

  // 焦点节点 - 11.0.0版本中对焦点管理有改进
  late FocusNode _focusNode;

  @override
  void initState() {
    _initController();
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _editorScrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // 初始化控制器并加载示例内容
  Future<void> _initController() async {
    // 11.0.0版本中Document构造方式不变，但内部处理更高效
    // final doc = Document()..insert(0, _getSampleContent());

    final doc = Document.fromJson(_getSampleContent());

    _controller = QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );

    // 监听文本变化 - 11.0.0版本中回调触发更及时
    _controller.addListener(() {
      //TODO: -  可以在这里处理实时保存等逻辑
    });

    setState(() {});
  }

  // 示例富文本内容 - Delta格式
  List<dynamic> _getSampleContent() {
    return [
      {
        "insert": "Flutter Quill 11.0.0 示例\n",
        "attributes": {"header": 1}
      },
      {"insert": "这个示例针对 11.0.0 版本优化，包含各种富文本元素。\n\n"},
      {
        "insert": "1. 文本样式\n",
        "attributes": {"header": 2}
      },
      {"insert": "普通文本\n"},
      {
        "insert": "加粗文本\n",
        "attributes": {"bold": true}
      },
      {
        "insert": "斜体文本\n",
        "attributes": {"italic": true}
      },
      {
        "insert": "下划线文本\n",
        "attributes": {"underline": true}
      },
      {
        "insert": "红色文本\n",
        "attributes": {"color": "#ff0000"}
      },
      {
        "insert": "红色文本-1-divider不好使\n",
        "attributes": {"color": "#ff0000"}
      },
      {
        "insert": {"divider": true}
      },
      {
        "insert": "\n2. 列表\n",
        "attributes": {"header": 2}
      },
      {
        "insert": "无序列表项 1\n",
        "attributes": {"list": "bullet"}
      },
      {
        "insert": "无序列表项 2\n",
        "attributes": {"list": "bullet"}
      },
      {
        "insert": "嵌套列表\n",
        "attributes": {"list": "bullet", "indent": 1}
      },
      {
        "insert": "有序列表项 1\n",
        "attributes": {"list": "ordered"}
      },
      {
        "insert": "有序列表项 2\n",
        "attributes": {"list": "ordered"}
      },
      {
        "insert": {"divider": true}
      },
      {
        "insert": "\n3. 代码块\n",
        "attributes": {"header": 2}
      },
      {
        "insert": "void main() {\n  runApp(const MyApp());\n}\n",
        "attributes": {"code-block": true}
      },
      {
        "insert": {"divider": true}
      },
      {
        "insert": "\n4. 引用块\n",
        "attributes": {"header": 2}
      },
      {
        "insert": "这是一个引用块示例，11.0.0版本中渲染更美观\n",
        "attributes": {"blockquote": true}
      },
      {
        "insert": {"divider": true}
      },
      {
        "insert": "\n5. 图片\n",
        "attributes": {"header": 2}
      },
      {
        "insert": {"image": "https://picsum.photos/800/400"}
      },
      {"insert": "\n示例图片，支持点击工具栏按钮添加本地图片\n\n"},
      {
        "insert": {"divider": true}
      },
      {
        "insert": "\n6. 视频\n",
        "attributes": {"header": 2}
      },
      {
        "insert": {
          "video":
              "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"
        }
      },
      {
        "insert": {"divider": true}
      },
      {
        "insert": "\n7. 公式\n",
        "attributes": {"header": 2}
      },
      {
        "insert": {"formula": "E = mc^2"}
      },
      {"insert": "\n质能方程\n\n"},
      {
        "insert": {"formula": "a^2 + b^2 = c^2"}
      },
      {"insert": "\n勾股定理\n"},
    ];
  }

  final ScrollController _editorScrollController = ScrollController();

  // 切换编辑/预览模式
  void _toggleEditing() {
    setState(() => _isEditing = !_isEditing);
  }

  // 导出文档
  Future<void> _exportDocument() async {
    try {
      // 11.0.0版本中toDelta()方法保持稳定
      final jsonData = jsonEncode(_controller.document.toDelta().toJson());
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/quill_11_doc.json');
      await file.writeAsString(jsonData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导出成功: ${file.path}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导出失败: $e')),
        );
      }
    }
  }

  // 导入文档
  Future<void> _importDocument() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/quill_11_doc.json');

      if (await file.exists()) {
        final jsonData = await file.readAsString();
        final delta = Delta.fromJson(jsonDecode(jsonData));
        final doc = Document()..compose(delta, ChangeSource.local);

        setState(() {
          _controller = QuillController(
            document: doc,
            selection: const TextSelection.collapsed(offset: 0),
          );
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('导入成功')),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('未找到文档')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导入失败: $e')),
        );
      }
    }
  }

  // 插入图片 - 11.0.0版本中嵌入内容处理更高效
  Future<void> _insertImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(imageBytes);
      final imageUrl = 'data:image/png;base64,$base64Image';

      // 11.0.0版本中insertEmbed方法参数不变，但内部优化了性能
      // _controller.insertEmbed(
      //   _controller.selection.baseOffset,
      //   BlockEmbed.image(imageUrl),
      //   null,
      // );

      insertEmbed(_controller, BlockEmbed.image(imageUrl));

      // 保持焦点在编辑器
      _focusNode.requestFocus();
    }
  }

  // 封装一个类似insertEmbed的方法
  void insertEmbed(QuillController controller, BlockEmbed embed) {
    final delta = Delta()
      ..retain(controller.selection.baseOffset)
      ..insert(embed);
    controller.compose(
      delta,
      controller.selection,
      ChangeSource.local,
    );
  }

  // 插入视频
  void _insertVideo() {
    showDialog(
      context: context,
      builder: (context) {
        final videoUrlController = TextEditingController(
          text:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        );

        return AlertDialog(
          title: const Text('插入视频'),
          content: TextField(controller: videoUrlController),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                final url = videoUrlController.text.trim();
                if (url.isNotEmpty) {
                  // _controller.insertEmbed(
                  //   _controller.selection.baseOffset,
                  //   BlockEmbed.video(url),
                  //   null,
                  // );
                  insertEmbed(_controller, BlockEmbed.video(url));
                }
                Navigator.pop(context);
              },
              child: const Text('插入'),
            ),
          ],
        );
      },
    );
  }

  // 插入公式
  void _insertFormula() {
    showDialog(
      context: context,
      builder: (context) {
        final formulaController = TextEditingController();

        return AlertDialog(
          title: const Text('插入公式'),
          content: TextField(
            controller: formulaController,
            decoration: const InputDecoration(
              hintText: '输入LaTeX公式，如 a^2 + b^2 = c^2',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                final formula = formulaController.text.trim();
                if (formula.isNotEmpty) {
                  // _controller.insertEmbed(
                  //   _controller.selection.baseOffset,
                  //   BlockEmbed.formula(formula),
                  //   null,
                  // );
                  insertEmbed(_controller, BlockEmbed.formula(formula));
                }
                Navigator.pop(context);
              },
              child: const Text('插入'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Quill 11.0.0'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.visibility : Icons.edit),
            onPressed: _toggleEditing,
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _exportDocument,
          ),
          IconButton(
            icon: const Icon(Icons.upload),
            onPressed: _importDocument,
          ),
        ],
      ),
      body: _buildEditor(),
    );
  }

  Widget _buildEditor() {
    if (_controller.document.isEmpty()) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        if (_isEditing)
          // 11.0.0版本中工具栏构造方式不变，但添加了更多默认按钮
          QuillSimpleToolbar(
            controller: _controller,
            config: QuillSimpleToolbarConfig(customButtons: [
              QuillToolbarCustomButtonOptions(
                icon: const Icon(Icons.image),
                tooltip: '插入图片',
                onPressed: _insertImage,
              ),
              QuillToolbarCustomButtonOptions(
                icon: const Icon(Icons.video_library),
                tooltip: '插入video',
                onPressed: _insertVideo,
              ),
              QuillToolbarCustomButtonOptions(
                icon: const Icon(Icons.science),
                tooltip: '插入公式',
                onPressed: _insertFormula,
              ),
            ]),
          ),
        Expanded(
          child: QuillEditor(
            focusNode: _focusNode,
            scrollController: _editorScrollController,
            controller: _controller,
            config: QuillEditorConfig(
              placeholder: 'Start writing your notes...',
              padding: const EdgeInsets.all(16),
              // 关键：限制单次构建的最大行数（按需调整）
              maxContentWidth: MediaQuery.of(context).size.width,
              // 配合ListView的缓存机制
              scrollPhysics: const ClampingScrollPhysics(),
              embedBuilders: [
                ...FlutterQuillEmbeds.editorBuilders(
                  imageEmbedConfig: QuillEditorImageEmbedConfig(
                    imageProviderBuilder: (context, imageUrl) {
                      // https://pub.flutter-io.cn/packages/flutter_quill_extensions#-image-assets
                      if (imageUrl.startsWith('assets/')) {
                        return AssetImage(imageUrl);
                      }
                      return NetworkImage(imageUrl);
                    },
                  ),
                  videoEmbedConfig: QuillEditorVideoEmbedConfig(
                    customVideoBuilder: (videoUrl, readOnly) {
                      //TODO: - To load YouTube videos https://github.com/singerdmx/flutter-quill/releases/tag/v10.8.0
                      return Text(videoUrl);
                    },
                  ),
                ),
                TimeStampEmbedBuilder(),
                FormulaEmbedBuilder(),
                DividerEmbedBuilder(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TimeStampEmbed extends Embeddable {
  const TimeStampEmbed(
    String value,
  ) : super(timeStampType, value);

  static const String timeStampType = 'timeStamp';

  static TimeStampEmbed fromDocument(Document document) =>
      TimeStampEmbed(jsonEncode(document.toDelta().toJson()));

  Document get document => Document.fromJson(jsonDecode(data));
}

class TimeStampEmbedBuilder extends EmbedBuilder {
  @override
  String get key => 'timeStamp';

  @override
  String toPlainText(Embed node) {
    return node.value.data;
  }

  @override
  Widget build(
    BuildContext context,
    EmbedContext embedContext,
  ) {
    return Row(
      children: [
        const Icon(Icons.access_time_rounded),
        Text(embedContext.node.value.data as String),
      ],
    );
  }
}

class FormulaEmbedBuilder extends EmbedBuilder {
  @override
  String get key => 'formula';

  @override
  String toPlainText(Embed node) {
    return node.value.data;
  }

  @override
  Widget build(
    BuildContext context,
    EmbedContext embedContext,
  ) {
    return Row(
      children: [
        const Icon(Icons.science),
        Text(embedContext.node.value.data as String),
      ],
    );
  }
}

class DividerEmbedBuilder extends EmbedBuilder {
  @override
  String get key => 'divider';

  @override
  String toPlainText(Embed node) {
    return node.value.data;
  }

  @override
  Widget build(
    BuildContext context,
    EmbedContext embedContext,
  ) {
    bool isTure = embedContext.node.value.data as bool;

    print('isTure == $isTure');

    return Divider();
  }
}
