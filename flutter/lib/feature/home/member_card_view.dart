import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:motion_mis/model/member_data.dart';
import 'package:motion_mis/motion_color.dart';

class MemberCardViewController extends GetxController {
  Color getGenerationColor(String genName) {
    switch (genName) {
      case 'Founders':
        return MotionColor.RED;
      case 'Generation A':
        return MotionColor.GREEN;
      case 'Buttermilk':
        return MotionColor.BLUE;
      case 'Cheesecake':
        return MotionColor.ORANGE;
      case 'Derby Pie':
        return MotionColor.PURPLE;
      case 'Espresso':
        return MotionColor.BLACK;
      default:
        return MotionColor.GREY;
    }
  }

  bool isProfilePictureExist(String address) {
    return address.isNotEmpty && !address.contains('data:image/gif');
  }
}

class MemberCardView extends GetResponsiveView {
  final Member member;

  MemberCardView(this.member, {Key? key}) : super(key: key);

  @override
  Widget? builder() {
    print('builder: ${Get.width}');
    return createCard(80, 12, 21, 18, 12);
  }

  @override
  Widget? desktop() {
    print('desktop: ${Get.width}');
    final screenIsSmall = Get.width < 1000;
    final circleSize = screenIsSmall ? 42.0 : 62.0;
    final circlePadding = screenIsSmall ? 12.0 : 24.0;
    final nameSize = screenIsSmall ? 18.0 : 21.0;
    final descSize = screenIsSmall ? 14.0 : 18.0;
    final paddingSide = screenIsSmall ? 10.0 : 12.0;
    return createCard(
      circleSize,
      circlePadding,
      nameSize,
      descSize,
      paddingSide,
    );
  }

  @override
  Widget? phone() {
    print('phone: ${Get.width}');
    return createCard(42, 12, 16, 12, 10);
  }

  Widget createCard(
    double circleSize,
    double circlePadding,
    double nameSize,
    double descSize,
    double chipSize,
  ) {
    return GetBuilder<MemberCardViewController>(
      init: MemberCardViewController(),
      builder: (ctlr) => Container(
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (ctlr.isProfilePictureExist(member.profPic))
                  CircleAvatar(
                    radius: circleSize,
                    backgroundImage: NetworkImage(member.profPic),
                    backgroundColor: Colors.transparent,
                  ).paddingOnly(left: circlePadding / 2, right: circlePadding),
                if (!ctlr.isProfilePictureExist(member.profPic))
                  CircleAvatar(
                    radius: circleSize,
                    child: Icon(
                      Icons.person_outlined,
                      size: circleSize,
                      color: MotionColor.RED,
                    ),
                    backgroundColor: MotionColor.YELLOW,
                  ).paddingOnly(left: circlePadding / 2, right: circlePadding),
                getPersonDesc(ctlr, nameSize, descSize, chipSize),
              ],
            ),
            Container(height: 16),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                createChip(
                  chipSize,
                  ctlr.getGenerationColor(member.generation),
                  member.generation,
                ),
                ...member.role.split('|').map(
                      (role) => createChip(
                        chipSize,
                        MotionColor.GREY,
                        role.trim(),
                      ),
                    ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: MotionColor.LIGHT_BROWN,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Expanded getPersonDesc(
    MemberCardViewController ctlr,
    double nameSize,
    double descSize,
    double chipSize,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            member.fullName,
            style: TextStyle(fontSize: nameSize, fontWeight: FontWeight.bold),
          ),
          Container(height: 8),
          Text(
            member.datas['headline'],
            style: TextStyle(
              fontSize: descSize,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Container createChip(double chipSize, Color chipColor, String content) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 6),
      child: Text(
        content,
        style: TextStyle(
          fontSize: chipSize,
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ),
      ),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
