import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_mis/feature/home/member_card_view.dart';
import 'package:motion_mis/feature/home/repository/member_repository.dart';
import 'package:motion_mis/model/member_data.dart';

class MyHomeController extends GetxController {
  final List<Member> members = List.empty(growable: true);

  late MemberRepository memberRepository;

  @override
  void onInit() {
    super.onInit();
    memberRepository = MemberRepository();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  void loadData() async {
    final generationPaths = await memberRepository.getFileList();

    for (var genPath in generationPaths) {
      final genData = await memberRepository.getGenerationData(genPath);
      members.addAll(genData.members);
      update();
    }
  }
}

class MyHomePage extends GetResponsiveView {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  Widget createScreen(double paddingSide, double childAspectRatio) {
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
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: ctlr.members.length,
          itemBuilder: (ctx, idx) => MemberCardView(ctlr.members[idx]),
        ),
      ),
    );
  }

  @override
  Widget? builder() {
    return createScreen(21, 3 / 2);
  }

  @override
  Widget? desktop() {
    final screenIsSmall = Get.width < 1200;
    final dynamicPadding = (Get.width - 1200) / 2;
    final paddingSide = screenIsSmall ? 21.0 : 21 + dynamicPadding;
    return createScreen(paddingSide, 3 / 2);
  }

  @override
  Widget? phone() {
    return createScreen(21, 4 / 2);
  }
}
