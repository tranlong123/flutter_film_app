// ignore: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/screens/movie/movie_screen.dart';
import 'package:flutter_mvvm_riverpod/widget/item_overview.dart';
import 'package:flutter_mvvm_riverpod/widget/item_title.dart';
import 'package:flutter_mvvm_riverpod/widget/item_vote.dart';
import 'package:flutter_mvvm_riverpod/widget/start_vote.dart';

class CreateMovieList extends StatelessWidget {
  final List<Movie> movies;
  final bool isLoadingMore;
  final ScrollController scrollController;
  final RefreshCallback refreshMovies;
  const CreateMovieList(
      {super.key,
      required this.movies,
      required this.scrollController,
      required this.isLoadingMore,
      required this.refreshMovies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppDimensions.sizedBox80),
        Expanded(
          child: RefreshIndicator(
              onRefresh: refreshMovies,
              backgroundColor: fullyTransparent,
              child: _buildMovieList()),
        ),
      ],
    );
  }

  Widget _buildMovieList() {
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
          return SizedBox(height: AppDimensions.sizedBox35);
        }
        return _buildItem(context, movie: movies[index]);
      },
    );
  }

  Widget _buildItem(context, {required Movie movie}) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieScreen(id: movie.id),
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(
            width: AppDimensions.screenWidth,
            height: AppDimensions.sizedBox116,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildItemImage(item: movie.posterPath ?? ""),
                _buildItemDescription(
                    title: movie.title,
                    vote: movie.voteAverage,
                    overview: movie.overview,
                    voteCount: movie.voteCount),
              ],
            ),
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
      {required String title,
      required double vote,
      required String overview,
      required int voteCount}) {
    return SizedBox(
      height: AppDimensions.sizedBox116,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ItemTitle(title: title), ItemVote(voteCount: voteCount)],
          ),
          StartVote(vote: vote),
          SizedBox(height: AppDimensions.sizedBox16),
          SizedBox(
              width: AppDimensions.sizedBox158,
              child: ItemOverview(text: overview))
        ],
      ),
    );
  }
}
