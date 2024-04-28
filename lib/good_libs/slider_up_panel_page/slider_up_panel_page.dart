import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SliderUpPanelPage extends StatefulWidget {
  const SliderUpPanelPage({super.key});

  @override
  State<SliderUpPanelPage> createState() => _SliderUpPanelPageState();
}

class _SliderUpPanelPageState extends State<SliderUpPanelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider Up Panel'),
      ),
      body: SlidingUpPanel(
        body: Container(
          color: Colors.redAccent[100],
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Text("This is the Widget behind the sliding panel"),
            ),
          ),
        ),
        panelBuilder: (sc) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0))),
            child: Center(
              child: Text("This is the sliding Widget"),
            ),
          );
        },
        borderRadius: BorderRadius.circular(24.0),
        backdropEnabled: true,
        // background will be dark
        collapsed: Container(
          color: Colors.blueGrey,
          child: Center(
            child: Text(
              "This is the collapsed Widget",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        header: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0))),
          child: Text('Header'),
        ),
        footer: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          color: Colors.purpleAccent,
          child: Text('Footer'),
        ),
      ),
    );
  }
}
