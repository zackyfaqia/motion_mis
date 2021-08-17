import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_mis/feature/home/repository/member_repository.dart';

class Member {
  final int index;

  Member(this.index);
}

class MyHomeController extends GetxController {
  final firstLoad = true;
  final generationLoading = [true];

  final httpClient = GetHttpClient();
  late MemberRepository memberRepository;

  @override
  void onInit() {
    super.onInit();
    memberRepository = MemberRepository(httpClient);
  }

  @override
  void onReady() {
    super.onReady();
    memberRepository.getFileList().then((value) {
      print(value);
    });
  }

  final members = List.generate(30, (index) => Member(index));
}

class MyHomePage extends GetResponsiveView {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  Widget createScreen(double paddingSide) {
    return GetBuilder<MyHomeController>(
      init: MyHomeController(),
      builder: (ctlr) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: GridView.builder(
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: paddingSide,
          ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: ctlr.members.length,
          itemBuilder: (ctx, idx) {
            return Container(
              alignment: Alignment.center,
              child: Text('Member ${ctlr.members[idx].index}'),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(15),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget? builder() {
    print('width: builder ${Get.width}');
    return createScreen(21);
  }

  @override
  Widget? desktop() {
    final screenIsSmall = Get.width < 1200;
    final dynamicPadding = (Get.width - 1200) / 2;
    final paddingSide = screenIsSmall ? 21.0 : 21 + dynamicPadding;
    return createScreen(paddingSide);
  }

  @override
  Widget? phone() {
    return createScreen(21);
  }
}
