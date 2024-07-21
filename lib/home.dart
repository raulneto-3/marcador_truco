import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/ad_banner.dart';
import 'components/provider.dart';
import 'components/team_column.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool truco = false;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/table.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TeamColumnWidget(team: 'Nós'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VerticalDivider(color: Colors.white, thickness: 2),
                ),
                TeamColumnWidget(team: 'Eles'),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.7,
              bottom: MediaQuery.of(context).size.height * 0.13,
              left: MediaQuery.of(context).size.width * 0.35,
              right: MediaQuery.of(context).size.width * 0.35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  side: BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {
                  Provider.of<TrucoProvider>(context, listen: false).toggleTruco();                  // setState(() {
                    
                  //   truco = !truco;
                  // });
                },
                child: Text(
                  'Truco',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

                   AdBannerHome()

            // truco
            //     ? Positioned(
            //         top: MediaQuery.of(context).size.height * 0.75,
            //         right: MediaQuery.of(context).size.width * 0.1,
            //         child: Center(
            //           child: SizedBox(
            //             width: 250.0,
            //             child: DefaultTextStyle(
            //               style: const TextStyle(
            //                 fontSize: 70.0,
            //                 fontFamily: 'Canterbury',
            //               ),
            //               child: AnimatedTextKit(
            //                 pause: const Duration(milliseconds: 1),
            //                 repeatForever: true,
            //                 animatedTexts: [
            //                   ScaleAnimatedText('6'),
            //                 ],
            //                 onTap: () {
            //                   print("Tap Event");
            //                 },
            //               ),
            //             ),
            //           ),
            //         ),
            //       )
            //     : Container(),
          ],
        ),
      ),
    );
  }
}
