import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/general/activity_feed.dart';
import '../widgets/all_Lets/lets_explore.dart';
import '../widgets/home/search_activity_box.dart';
import '../widgets/home/filter_button.dart';
import '../widgets/home/filter_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> selectedTags = [];
  List<String> allTags = [];
  bool isLoadingTags = true;

  String? currentUserId;

  late Future<void> _refreshFuture = Future.value(); // Default initialization

  @override
  void initState() {
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser?.uid; // Get current user's UID
    _refreshFuture = _refreshData();
  }

  Future<void> _refreshData() async {
    await _fetchTags();
    setState(() {
      // Trigger rebuild after data fetch
    });
  }

  Future<void> _fetchTags() async {
    try {
      setState(() {
        isLoadingTags = true;
      });

      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('tags').get();

      final tags = snapshot.docs.map((doc) => doc['tag'] as String).toList();

      setState(() {
        allTags = tags;
        isLoadingTags = false;
      });
    } catch (e) {
      print('Error fetching tags: $e');
      setState(() {
        isLoadingTags = false;
      });
    }
  }

  void _showFilterDialog() async {
    await _fetchTags();

    if (allTags.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FilterDialog(
            allTags: allTags,
            initialSelectedTags: selectedTags,
            onApply: (List<String> tags) {
              setState(() {
                selectedTags = tags;
              });
            },
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No tags available')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserId == null) {
      return const Center(
        child: Text('Error: User not logged in'),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<void>(
          future: _refreshFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                    bottom: 4.0,
                  ),
                  child: LetsExploreWidget(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SearchActivityBox(
                          searchController: _searchController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      isLoadingTags
                          ? Container(
                        width: 45,
                        height: 45,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      )
                          : FilterButton(
                        onFilterPressed: _showFilterDialog,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ActivityFeed(
                    currentUserId: currentUserId!,
                    showFriendsOnly: false, // Show all activities except user's
                    categoryFilter:
                    selectedTags.isEmpty ? null : selectedTags.join(', '),
                    maxParticipantsFilter: null,
                    locationFilter: null,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
