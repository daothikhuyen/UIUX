import 'package:finaluxui/info_group_account.dart/group_detail_home.dart';
import 'package:finaluxui/info_group_account.dart/group_detail_media.dart';
import 'package:finaluxui/info_group_account.dart/group_events.dart';
import 'package:finaluxui/info_group_account.dart/widget/tab_item.dart';
import 'package:flutter/material.dart';

class TabRow extends StatelessWidget {
  final String currentTab; // 👈 Nhận tên tab hiện tại

  const TabRow({super.key, required this.currentTab});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 6, left: 12, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TabItem(
            'Home',
            selected: currentTab == 'Home',
            onTap: () {
              if (currentTab != 'Home') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => GroupDetailHome()),
                );
              }
            },
          ),
          TabItem(
            'Event',
            selected: currentTab == 'Event',
            onTap: () {
              if (currentTab != 'Event') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => GroupEventsPage()),
                );
              }
            },
          ),
          TabItem(
            'Media files',
            selected: currentTab == 'Media files',
            onTap: () {
              if (currentTab != 'Media files') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => GroupDetailMediaFiles()),
                );
              }
            },
          ),
          TabItem(
            'See more',
            selected: currentTab == 'See more',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
