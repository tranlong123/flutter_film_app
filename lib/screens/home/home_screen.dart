import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_week_repository.dart';
import 'package:flutter_mvvm_riverpod/screens/home/components/trending/trending_week_view_model.dart';
import 'package:flutter_mvvm_riverpod/screens/home/home_state.dart';
import 'package:flutter_mvvm_riverpod/screens/home/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _provider = StateNotifierProvider.autoDispose<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(
    ref: ref,
    trendingWeekRepository: ref.read(trendingWeekRepositoryProvider),
  );
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch trending movies when the widget is first created
    ref.read(trendingWeekViewModelProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final trendingWeekState = ref.watch(trendingWeekViewModelProvider);

    return Scaffold(
      body: trendingWeekState.movies.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(child: Text('No movies available.'));
          }

          return Column(
            children: [
              SizedBox(
                height: 600,
                child: ListView.builder(
                  itemCount: data.length > 10 ? 10 : data.length,
                  itemBuilder: (context, index) {
                    final movie = data[index];
                    return ListTile(
                      leading: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      title: Text(movie.title),
                      subtitle: Text(movie.releaseDate),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(trendingWeekViewModelProvider.notifier).refresh();
                },
                child: const Text('Retry'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('An error occurred: ${error.toString()}'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Stack trace: ${stack.toString()}'),
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint(error.toString());
                  ref.read(trendingWeekViewModelProvider.notifier).refresh();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
