import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/screens/home/components/trending/trending_week_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TrendingWeek extends ConsumerWidget {
  const TrendingWeek({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingWeekAsyncValue = ref.watch(trendingWeekListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
      ),
      body: trendingWeekAsyncValue.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(child: Text('No movies available.'));
          }

          return ListView.builder(
            itemCount: data.length > 10 ? 10 : data.length,
            itemBuilder: (context, index) {
              final movie = data[index];
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                title: Text(movie.title),
                subtitle: Text(movie.releaseDate),
              );
            },
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
                  // Refresh the provider to try to fetch data again
                  debugPrint(error.toString());
                  // ignore: unused_result
                  ref.refresh(trendingWeekListProvider);
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
