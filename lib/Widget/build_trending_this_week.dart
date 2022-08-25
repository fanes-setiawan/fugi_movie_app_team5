import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Controller/riverpod/trending_movie_this_week.dart';
import '../Model/result/result.dart';
import '../View/detail_screen.dart';

class BuildTrendingThisWeek extends ConsumerWidget {
  const BuildTrendingThisWeek({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataThisWeek = ref.watch(trendingThisWeekController);
    return dataThisWeek.when(
      data: (dataThisWeek) {
        List<Result> data = dataThisWeek.map((e) => e).toList();
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Trending ',
                    style: Theme.of(context).textTheme.titleLarge,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'This week',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.37,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 5),
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    // Original Title
                    var title = data[index].originalTitle;
                    return Column(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      banner:
                                          data[index].backdropPath.toString(),
                                      originalTitle: data[index].originalTitle,
                                      nameMovie: data[index].name,
                                      releaseDate: data[index].releaseDate,
                                      firstRelease: data[index].firstAirDate,
                                      voteAverage: data[index].voteAverage!,
                                      overview: data[index].overview,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                height: 220,
                                width: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500${data[index].posterPath}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              right: 15,
                              child: Container(
                                height: 30,
                                width: 50,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(69, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/icon/icon_star_filled.png',
                                        color: const Color(0xfff3be00),
                                        width: 25,
                                      ),
                                      Text(
                                        data[index]
                                            .voteAverage!
                                            .toStringAsFixed(1),
                                        style: const TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: 150,
                          child: Text(
                            title = title == null
                                ? data[index].name.toString()
                                : title.toString(),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              // Text(
              //   DateFormat.yMMMd()
              //       .format(date = date ?? firstDate!),
              //   style: const TextStyle(color: Colors.red),
              // ),
            ],
          ),
        );
      },
      error: (err, s) => Scaffold(
        body: Text(
          err.toString(),
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
