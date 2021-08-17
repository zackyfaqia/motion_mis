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
    final screenIsSmall = Get.width < 1200;
    final dynamicPadding = (Get.width - 1200) / 2;
    final paddingSide = screenIsSmall ? 21.0 : 21 + dynamicPadding;
    return createCard(100);
  }

  @override
  Widget? phone() {
    return createCard(52);
  }

  Widget createCard(double circleSize) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          if (member.profPic.isNotEmpty)
            CircleAvatar(
              child: Image.network(member.profPic),
              radius: circleSize,
            ),
          Text('Member ${member.datas}')
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
