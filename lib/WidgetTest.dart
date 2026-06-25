import 'package:flutter/material.dart';

class WidgetTest extends StatelessWidget {
  const WidgetTest({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: true,
      // TRY THIS: Try changing the color here to a specific color (to
      // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      // change color while the other colors stay the same.
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: Text('두번째스크린'),
    ),
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
          Card(
            // 그림자 깊이 (0으로 설정 시 평면 카드가 됨)
            elevation: 0,
            // 모양 및 테두리 설정
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.shade200, width: 1), // elevation이 0일 때 구분선 역할
            ),
            // 외부 여백
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            // 카드 내부 요소
            child: Padding(
              padding: const EdgeInsets.all(16.0), // 카드 내부 여백 필수!
              child: Row(
                children: [
                  // 1. 프로필 이미지 영역
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(Icons.person, color: Colors.blue),
                  ),
                  const SizedBox(width: 16), // 이미지와 텍스트 사이 간격

                  // 2. 텍스트 영역 (Row 안에서 가득 차도록 Expanded 사용)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          '홍길동',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'flutter_developer@example.com',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  // 3. 우측 아이콘
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          ClipRRect(
            // 1. 모서리 반지름 설정 (보내주신 15 설정)
            borderRadius: BorderRadius.circular(15.0),

            // 2. 잘라낼 자식 위젯 (이미지)
            child: Image.network(
              'https://img.magnific.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148901163.jpg?t=st=1782102830~exp=1782106430~hmac=b90a818dce2ddb7f6f843e25881c787fec4f579ac3b56ec0f3658188360506f7&w=740', // 샘플 이미지 URL
              width: 300,
              height: 200,
              fit: BoxFit.cover, // 이미지가 잘리지 않고 프레임에 꽉 차도록 설정
            ),
          ),
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
