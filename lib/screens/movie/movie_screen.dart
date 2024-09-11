import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/movie_repository.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/screens/movie/components/cate_box.dart';
import 'package:flutter_mvvm_riverpod/screens/movie/components/create_may_be_like_list.dart';
import 'package:flutter_mvvm_riverpod/screens/movie/components/custom_buttom.dart';
import 'package:flutter_mvvm_riverpod/screens/movie/movie_screen_state.dart';
import 'package:flutter_mvvm_riverpod/screens/movie/movie_view_model.dart';
import 'package:flutter_mvvm_riverpod/widget/item_overview.dart';
import 'package:flutter_mvvm_riverpod/widget/item_title.dart';
import 'package:flutter_mvvm_riverpod/widget/item_vote.dart';
import 'package:flutter_mvvm_riverpod/widget/start_vote.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _provider = StateNotifierProvider.autoDispose
    .family<MovieViewModel, MovieScreenState, int>(
  (ref, id) => MovieViewModel(
    ref: ref,
    movieRepository: ref.watch(movieRepositoryProvider),
    id: id,
  ),
);

class MovieScreen extends BaseView {
  final int id;
  const MovieScreen({super.key, required this.id});

  @override
  BaseViewState<MovieScreen, MovieViewModel> createState() =>
      _MovieScreenState();
}

class _MovieScreenState extends BaseViewState<MovieScreen, MovieViewModel> {
  @override
  Future<void> onInitState() async {
    super.onInitState();
    await Future.delayed(Duration.zero, () async {
      await viewModel.initData();
    });
  }

  @override
  MovieViewModel get viewModel => ref.read(_provider(widget.id).notifier);
  MovieScreenState get state => ref.watch(_provider(widget.id));

  @override
  Widget buildBody(BuildContext context) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(), // Hiển thị vòng tròn load
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMoviePoster(),
          Padding(
            padding: EdgeInsets.only(left: AppDimensions.sizedBox16),
            child: StartVote(vote: state.movieDetail.voteAverage),
          ),
          _buildMovieDescription(),
          SizedBox(height: AppDimensions.sizedBox45),
          _buildMayBeLikeText(),
          CreateMayBeLikeList(movies: state.mayBeLike),
        ],
      ),
    );
  }

  Widget _buildMoviePoster() {
    return Container(
      width: AppDimensions.screenWidth,
      height: AppDimensions.sizedBox233,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://image.tmdb.org/t/p/w500${state.movieDetail.backdropPath}'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(113, 104, 80, 0), // rgba(113, 104, 80, 0)
              Color(0xFF716850), // #716850
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: AppDimensions.sizedBox12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.fontSize10),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${state.movieDetail.posterPath}',
                  width: AppDimensions.gridItemWidth,
                  height: AppDimensions.gridItemHeight,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: AppDimensions.sizedBox4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieDescription() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildMovieDesLeft(), _buildMovieDesRight()],
    );
  }

  Widget _buildMovieDesLeft() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: AppDimensions.sizedBox18),
          child: ItemTitle(
            title: state.movieDetail.title,
            width: AppDimensions.sizedBox124,
          ),
        ),
        SizedBox(
          height: AppDimensions.sizedBox4,
        ),
        Padding(
          padding: EdgeInsets.only(left: AppDimensions.sizedBox19),
          child: Text(
            state.movieDetail.releaseDate,
            style: TextStyle(
                color: black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: AppDimensions.fontSize10,
                height: 1.172),
          ),
        ),
        SizedBox(
          height: AppDimensions.sizedBox9,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: AppDimensions.sizedBox16,
          ),
          child: ItemVote(voteCount: state.movieDetail.voteCount),
        ),
        Padding(
          padding: EdgeInsets.only(left: AppDimensions.sizedBox16),
          child: SizedBox(
              width: AppDimensions.sizedBox124,
              height: AppDimensions.sizedBox86,
              child: ItemOverview(
                text: state.movieDetail.overview,
                maxLines: 7,
                height: AppDimensions.sizedBox86,
              )),
        )
      ],
    );
  }

  Widget _buildMovieDesRight() {
    return Padding(
      padding: EdgeInsets.only(left: AppDimensions.sizedBox9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: AppDimensions.sizedBox3,
          ),
          _buildMovieCateList(),
          SizedBox(
            height: AppDimensions.sizedBox28,
          ),
          _buildWatchAndDownload(),
        ],
      ),
    );
  }

  Widget _buildMovieCateList() {
    AppDimensions.init(context);
    return SizedBox(
        width: AppDimensions.sizedBox188,
        child: Wrap(
            spacing: AppDimensions.sizedBox5, // khoảng cách chiều ngang
            runSpacing: AppDimensions
                .sizedBox11, // khoảng cách giữa các hàng theo chiều dọc
            children: state.movieDetail.genres
                .map((cate) => CateBox(cate: cate.name))
                .toList()));
  }

  Widget _buildWatchAndDownload() {
    AppDimensions.init(context);
    return SizedBox(
        width: AppDimensions.sizedBox188,
        child: Row(
          children: [
            CustomButtom(
              text: 'Watch',
              // ignore: avoid_print
              onPressed: () => print('Button pressed'),
              color: watchBt,
            ),
            const SizedBox(width: 5,),
            CustomButtom(
              text: 'Download',
              // ignore: avoid_print
              onPressed: () => print('Button pressed'),
              color: downloadBt,
            )
          ],
        ));
  }

  Widget _buildMayBeLikeText() {
    return Padding(
      padding: EdgeInsets.only(
          left: AppDimensions.dotSize, bottom: AppDimensions.sizedBox23),
      child: Text(
        'May be you like',
        style: TextStyle(
          color: black,
          fontSize: AppDimensions.fontSize20,
          fontWeight: FontWeight.w700,
          height: 1.172,
        ),
      ),
    );
  }
}
