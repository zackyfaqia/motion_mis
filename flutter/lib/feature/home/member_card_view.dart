import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:motion_mis/model/member_data.dart';

class MemberCardView extends GetResponsiveView {
  final Member member;

  MemberCardView(this.member, {Key? key}) : super(key: key);

  @override
  Widget? builder() {
    return createCard(80);
  }

  @override
  Widget? desktop() {
    print(Get.width);
    final screenIsSmall = Get.width < 1200;
    final dynamicPadding = (Get.width - 1200) / 2;
    final paddingSide = screenIsSmall ? 21.0 : 21 + dynamicPadding;
    return createCard(62);
  }

  @override
  Widget? phone() {
    return createCard(42);
  }

  Widget createCard(double circleSize) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (member.profPic.isNotEmpty)
            CircleAvatar(
              radius: circleSize,
              backgroundImage: NetworkImage(member.profPic),
              backgroundColor: Colors.transparent,
            ).paddingOnly(right: 6),
          Expanded(
            child: Column(
              children: [
                Text(member.fullName),
                Text(member.datas['headline']),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
