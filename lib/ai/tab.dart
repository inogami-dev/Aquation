import 'package:aquation/ai/presentation/ai_screen.dart';
import 'package:aquation/pages/dashboard_page.dart';
import 'package:aquation/pages/history_page.dart';
import 'package:flutter/material.dart';

class MyTabs extends StatefulWidget {
  const MyTabs({super.key});

  @override
  State<MyTabs> createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: const TabBarView(
          children: [
            Center(child: DashboardPage()),
            Center(child: AiTestScreen()),
            Center(child: HistoryPage()),
            Center(child: Text('Profile Content')),
          ],
        ),
        // 1. Move the TabBar to the bottomNavigationBar
        bottomNavigationBar: SafeArea(
          // 2. Wrap in a SizedBox to force a smaller height
          child: SizedBox(
            height: 55,
            child: const TabBar(
              // Style the tabs so they look good at the bottom
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              // Move the indicator to the top of the tab for a classic bottom-nav look
              indicatorPadding: EdgeInsets.zero,
              tabs: [
                Tab(
                  icon: Icon(Icons.home, size: 22),
                  text: 'Home',
                  // 3. Reduce the gap between icon and text so it fits the smaller height
                  iconMargin: EdgeInsets.only(bottom: 2),
                ),
                Tab(
                  icon: Icon(Icons.star, size: 22),
                  text: 'Insights',
                  iconMargin: EdgeInsets.only(bottom: 2),
                ),
                Tab(
                  icon: Icon(Icons.history, size: 22),
                  text: 'History',
                  iconMargin: EdgeInsets.only(bottom: 2),
                ),
                Tab(
                  icon: Icon(Icons.person, size: 22),
                  text: 'Profile',
                  iconMargin: EdgeInsets.only(bottom: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
