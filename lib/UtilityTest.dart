import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer';
import 'dart:core';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:url_launcher/url_launcher.dart';



class UtilityTest extends StatefulWidget {
  const UtilityTest({super.key});

  @override
  State<UtilityTest> createState() => _UtilityTestState();


}

class _UtilityTestState extends State<UtilityTest> {



  // [전역 변수 선언]
  XFile? xfile;
  // Image Picker 인스턴스 생성
  final ImagePicker picker = ImagePicker();
  Image? img;
  bool isvisible = false;

  @override
// [initState] : [위젯이 생성될때 처음으로 호출되는 메소드]
  void initState(){
    super.initState();
  }


  @override
  // [dispose] : [State객체가 영구히 제거 될 때 의 상태]
  void dispose(){
    super.dispose();
  }

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
            SizedBox(height: 20,),

            IconButton(
              icon: const Icon(Icons.camera),
              splashColor: Colors.red.withOpacity(0.5), // 눌렀을 때 퍼지는 물결 색상
              highlightColor: Colors.red, // 눌려있는 동안 배경에 유지되는 색상
              onPressed: () {
                getImage(ImageSource.camera);
              },
            ),
            SizedBox(height: 20,),
            const Padding(padding: EdgeInsets.all(10)),

            // 카메라 선택 버튼
            ElevatedButton(
              onPressed: () {
                getImage(ImageSource.camera);
              },
              child: const Text("카메라버튼"),
            ),


            SizedBox(height: 20,),
            _buildPhotoArea()



          ],
        ),
      ),
    );
  }

  Widget _buildPhotoArea() {
    // 불러온 이미지가 있는지 없는지 확인
    return xfile != null
    // 불러온 이미지가 있으면 출력
        ? Column(
          children: [
            Center(
                  child: Image.file(
            File(xfile!.path),
                  ),
                ),
            SizedBox(height: 20,),
            if (isvisible == true) ...[
              SizedBox(
                width: 300, height: 300,
                child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white, fixedSize: Size.fromHeight(10),backgroundColor: Colors.red
                  ),
                  onPressed: () async {
                    if (xfile != null) {
                      // GallerySaver는 파일 경로(String)를 받아 저장합니다.
                      // 결과값으로 성공 여부(bool)를 반환합니다.
                      bool? success = await GallerySaver.saveImage(xfile!.path);

                      if (success == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("저장에 실패했습니다.")),
                        );
                      } else  {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("저장했습니다.")),
                        );
                      }
                    }
                  },
                  child: const Text("저장"),
                ),
              ),


              TextButton(
                // 스타일
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white, fixedSize: Size.fromHeight(10),backgroundColor: Colors.red
                ),
                // 액션
                onPressed: () { getImage(ImageSource.gallery); },
                child: const Text("앨범"),
              ),
            ],

          ],
        )
    // 불러온 이미지가 없으면 텍스트 출력
        : Expanded(
          child: const Center(
                child: Text("불러온 이미지가 없습니다."),
              ),
        );
  }

  // 이미지를 가져오는 함수
  Future<void> getImage(ImageSource imageSource) async {
    try {
      // 카메라 또는 갤러리의 이미지
      final XFile? imageFile = await picker.pickImage(
          source: imageSource, maxHeight: 300, maxWidth: 300);

      if (imageFile != null) {
        // 이미지를 화면에 출력하기 위해 앱의 상태 변경
        setState(() {
          xfile = imageFile;
          isvisible = true;
        });
      }
    } catch (e) {
      print("디버깅용 이미지 호출 에러 : $e");
    }
  }


  // [카메라 사용 권한 체크, 없으면 팝업]
  Future<bool> cameraPermissionEnable(BuildContext context) async {
    var returnData = false;

    try {
      // 1. 현재 권한 상태를 확인합니다.
      var status = await Permission.camera.status;

      // 2. 만약 권한이 거부된 상태(처음 앱을 켠 상태 포함)라면,
      //    아이폰 순정 권한 요청 팝업('허용안함 / 허용')을 화면에 띄웁니다.
      if (status.isDenied) {
        status = await Permission.camera.request(); // 핵심: 여기서 팝업이 뜹니다!
      }

      // 3. 사용자가 허용했는지 확인합니다.
      if (status.isGranted || status.isLimited || status.isProvisional) {
        log("권한 허용됨");
        returnData = true;
      } else if (status.isPermanentlyDenied) {
        // [영구 거부 상태] : 팝업이 더 이상 뜨지 않으므로 설정 화면으로 이동
        log("권한 영구 거부됨 -> 설정으로 이동");
        await openAppSettings();
      } else {
        log("권한 거부됨");
      }

    } catch (e) {
      log("catch :: $e");
    }

    return returnData;
  }

// [팝업창 활성 메소드]
Future<dynamic> showAlertDialog(BuildContext context, Image image) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text("알림",
        style: TextStyle( // [텍스트 스타일 설정]
          fontFamily: "Open Sans", // [텍스트 스타일]
          fontWeight: FontWeight.bold, // [텍스트 굵기]
          fontSize: 22, // [텍스트 사이즈]
          color: Colors.white, // [텍스트 색상]
        ),
      ),
      content: image, // [이미지 파일 지정]
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("저장")),
        SizedBox(width: 20,),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("확인")),
      ],
      elevation: 10.0, // [음영 설정]
      backgroundColor: Colors.black, // [배경 색상 설정]
      shape: RoundedRectangleBorder( // [그림자 설정]
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
    ),
  );
}


}
