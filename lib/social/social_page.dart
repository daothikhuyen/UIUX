import 'package:finaluxui/info_group_account.dart/group_detail_home.dart';
import 'package:finaluxui/mood/widgets/bottom_nav.dart';
import 'package:finaluxui/social/community_tile.dart';
import 'package:finaluxui/social/friend_request_tile.dart';
import 'package:flutter/material.dart';

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Social",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  "Be brave! 🦸‍♂️",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: double.infinity,
                height: 1.2,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(
                    0.25,
                  ), // Set the color inside BoxDecoration
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              SizedBox(height: 20),

              // Friend Request Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Friend request",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0865FE),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  FriendRequestTile(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => GroupDetailHome()),
                        ),
                    name: 'Group Happy EveryDay',
                    followers: 367,
                    imageUrl:
                        'https://maunaildep.com/wp-content/uploads/2025/09/hinh-nen-shin-hd-full.jpg', // Example URL, replace with your image URL
                  ),
                  FriendRequestTile(
                    name: 'Cat Chop',
                    followers: 367,
                    imageUrl:
                        'https://banobagi.vn/wp-content/uploads/2025/04/hinh-anh-cute-2.jpg', // Example URL, replace with your image URL
                  ),
                  FriendRequestTile(
                    name: 'Happy EveryDay',
                    followers: 367,
                    imageUrl:
                        'https://i.pinimg.com/736x/61/62/2e/61622ec8899cffaa687a8342a84ea525.jpg', // Example URL, replace with your image URL
                  ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Communities you can join",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0865FE),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  CommunityTile(
                    name: 'Hope Space',
                    followers: 11112,
                    imageUrl:
                        'https://i.pinimg.com/736x/61/62/2e/61622ec8899cffaa687a8342a84ea525.jpg', // Example URL, replace with your image URL
                  ),
                  CommunityTile(
                    name: 'Mind Ease',
                    followers: 31428,
                    imageUrl:
                        'https://vn1.vdrive.vn/alohamedia.vn/2025/02/dc0ef9f664914981865e0d114a39632f.jpg', // Example URL, replace with your image URL
                  ),
                  CommunityTile(
                    name: 'Mind Ease',
                    followers: 31428,
                    imageUrl:
                        'https://jbagy.me/wp-content/uploads/2025/03/Hinh-anh-avatar-nam-cute-2.jpg', // Example URL, replace with your image URL
                  ),
                  CommunityTile(
                    name: 'Mind Ease',
                    followers: 31428,
                    imageUrl:
                        'https://cdn.vntrip.vn/cam-nang/wp-content/uploads/2020/03/thien-nhien-2020-rung-dua-nuoc.jpg', // Example URL, replace with your image URL
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Depression Community Section
              Text(
                "Depression Community",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  CommunityTile(
                    name: 'Hope Space',
                    followers: 11112,
                    imageUrl:
                        'https://i.pinimg.com/736x/61/62/2e/61622ec8899cffaa687a8342a84ea525.jpg', // Example URL, replace with your image URL
                  ),
                  CommunityTile(
                    name: 'Mind Ease',
                    followers: 31428,
                    imageUrl:
                        'https://vn1.vdrive.vn/alohamedia.vn/2025/02/dc0ef9f664914981865e0d114a39632f.jpg', // Example URL, replace with your image URL
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
