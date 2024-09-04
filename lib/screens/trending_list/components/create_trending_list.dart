import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/widget/item_overview.dart';
import 'package:flutter_mvvm_riverpod/widget/item_title.dart';
import 'package:flutter_mvvm_riverpod/widget/item_vote.dart';
import 'package:flutter_mvvm_riverpod/widget/start_vote.dart';

class CreateTrendingList extends StatelessWidget {
  final List<Movie> movies;
  final ScrollController scrollController;
  final bool isLoadingMore;

  const CreateTrendingList(
      {super.key,
      required this.movies,
      required this.scrollController,
      required this.isLoadingMore});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount:
          movies.length + 2, // +2 để thêm khoảng trống và indicator loading
      itemBuilder: (context, index) {
        if (index == movies.length) {
          if (isLoadingMore) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const SizedBox.shrink();
          }
        } else if (index == movies.length + 1) {
          return SizedBox(
              height: AppDimensions.sizedBox35); 
        }
        return _buildTrendingItem(movie: movies[index]);
      },
    );
  }

  Widget _buildTrendingItem({required Movie movie}) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MovieScreen(movie: movie),
        //   ),
        // );
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildItemImage(item: movie.posterPath),
              _buildItemDescription(
                  title: movie.title,
                  vote: movie.voteAverage,
                  overview: movie.overview),
              ItemVote(voteCount: movie.voteCount)
            ],
          ),
          SizedBox(
            height: AppDimensions.sizedBox35,
          )
        ],
      ),
    );
  }

  Widget _buildItemImage({required String item}) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimensions.sizedBox18,
        right: AppDimensions.sizedBox17,
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.25),
              blurRadius: 4.0, // Adjust blur radius as needed
              spreadRadius: 0, // Adjust spread radius as needed
              offset: const Offset(3, 4), // Shadow offset
            ),
          ],
        ),
        child: SizedBox(
          width: AppDimensions.trendingItemImageWidth,
          height: AppDimensions.trendingItemImageHeight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500$item',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemDescription(
      {required String title, required double vote, required String overview}) {
    return SizedBox(
      width: AppDimensions.sizedBox155,
      height: AppDimensions.sizedBox116,
      child: Column(
        children: [
          ItemTitle(title: title),
          StartVote(vote: vote),
          SizedBox(height: AppDimensions.sizedBox17),
          ItemOverview(text: overview)
        ],
      ),
    );
  }
}
