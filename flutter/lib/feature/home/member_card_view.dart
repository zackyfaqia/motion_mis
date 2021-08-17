import 'package:flutter/material.dart';
import 'package:motion_mis/model/member_data.dart';

class MemberCardView extends StatelessWidget {
  final Member member;

  const MemberCardView(this.member, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          if (member.profPic.isNotEmpty)
            CircleAvatar(
              child: Image.network(member.profPic),
              radius: 100,
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
