import 'package:flutter/material.dart';
import '../widgets/general/activity_feed.dart';
import '../widgets/all_Lets/lets_explore.dart';
import '../widgets/home/search_activity_box.dart'; // Import the SearchWithFilter widget

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4), // Set the background color to #9CC4C4
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to the start
        children: [
          // LetsExploreWidget at the top
          const Padding(
            padding: EdgeInsets.only(
              top: 16.0, // Standard top padding
              left: 16.0, // Standard left padding
              right: 16.0, // Standard right padding
              bottom: 4.0, // Very little bottom padding
            ),
            child: LetsExploreWidget(),
          ),
          // SearchWithFilter widget below LetsExploreWidget
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SearchWithFilter(
              searchController: _searchController,
              onSearchPressed: () {
                // Handle the search logic here
                print('Search pressed with query: ${_searchController.text}');
              },
              onFilterPressed: () {
                // Handle the filter logic here
                print('Filter button pressed');
              },
            ),
          ),
          const SizedBox(height: 8.0), // Add spacing between search box and feed
          // ActivityFeed below the search bar
          Expanded(
            child: ActivityFeed(
              // Optionally, you can pass filters here
              categoryFilter: null, // No filter by default
              maxParticipantsFilter: null, // No filter by default
              locationFilter: null, // No filter by default
            ),
          ),
        ],
      ),
    );
  }
}
