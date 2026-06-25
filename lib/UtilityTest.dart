import 'package:flutter/material.dart';

class Utilitytest extends StatelessWidget {
  const Utilitytest({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            IconButton(
              icon: const Icon(Icons.camera),
              splashColor: Colors.red.withOpacity(0.5), // 눌렀을 때 퍼지는 물결 색상
              highlightColor: Colors.red, // 눌려있는 동안 배경에 유지되는 색상
              onPressed: () => (),
            ),
            SizedBox(height: 20,),

            SizedBox(height: 20,),
            Text(
                '두번째 페이지'
            ),


          ],
        ),
      ),
    );
  }
}
