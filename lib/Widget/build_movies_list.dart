import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../Controller/riverpod/movie_riverpod.dart';
import '../Model/movies/movies.dart';

class BuildMovieList extends ConsumerWidget {
  const BuildMovieList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieList = ref.watch(moviesController);
    return movieList.when(
      data: (movies) {
        List<Result> data = movies.map((e) => e).toList();
        return GridView.builder(
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.75,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 154,
                  height: (index % 3 == 0 || index == 0) ? 184 : 160,
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${data[index].posterPath}',
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                Text(
                  "${data[index].originalTitle} (${DateFormat('yyyy').format(data[index].releaseDate)})",
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        );
      },
      error: (err, s) => Column(
        children: [
          Text(
            err.toString(),
          ),
        ],
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
