import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/screens/search/search_screen.dart';
import 'package:flutter_mvvm_riverpod/screens/trending_list/trending_list_screen.dart';
import 'package:flutter_mvvm_riverpod/widget/app_bar_title.dart';

class CreateHomeTop extends StatelessWidget {
  const CreateHomeTop({super.key});

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TrendingListScreen(time: 'week'),
                ),
              );
            },
            child: const AppBarTitle(),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              child: SizedBox(
                height: AppDimensions.searchIconSizeHeight,
                width: AppDimensions.searchIconSizeWidth,
                child: Image.asset(
                  'assets/image/search.png',
                  fit: BoxFit.cover,
                ),
              )),
        ],
      ),
    );
  }
}
