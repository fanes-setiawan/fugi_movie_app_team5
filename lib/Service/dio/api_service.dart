import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fugi_movie_app_team5/Model/detail_tv/detail_tv.dart';
import 'package:fugi_movie_app_team5/Model/latest_movie/latest_movie.dart';
import 'package:fugi_movie_app_team5/Model/result/result.dart';

import '../../Model/detail_movie/detail_movie.dart';

class ApiService {
  // Url from the movie trending all day
  final baseUrl = 'https://api.themoviedb.org/3';
  // Apikey
  final apiKey = '5901633f2d04a1752502efc738f5616e';

  Future<List<Result>> getTrendingDay() async {
    final dio = Dio();
    final response =
        await dio.get('$baseUrl/trending/movie/day?api_key=$apiKey');
    if (response.statusCode != 200) {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
      // return;
      throw ("Status Error");
    } // Response decode as List<Map<String, dynamic>>
    final List result = jsonDecode(response.toString())['results'];
    return result.map(((e) => Result.fromJson(e))).toList();
  }

  Future<List<Result>> getTrendingWeek() async {
    final dio = Dio();
    final response =
        await dio.get('$baseUrl/trending/movie/week?api_key=$apiKey');
    if (response.statusCode != 200) {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
      // return;
      throw ("Status Error");
    } // Response decode as List<Map<String, dynamic>>
    final List result = jsonDecode(response.toString())['results'];
    return result.map(((e) => Result.fromJson(e))).toList();
  }

  Future<DetailMovie> getDetailMovie(int id) async {
    final response = await Dio().get('$baseUrl/movie/$id?api_key=$apiKey');

    var data = jsonDecode(response.toString()) as Map<String, dynamic>;

    return DetailMovie.fromJson(data);
  }

  Future<DetailTv> getDetailTv(int id) async {
    final response = await Dio().get('$baseUrl/tv/$id?api_key=$apiKey');

    var data = jsonDecode(response.toString()) as Map<String, dynamic>;

    return DetailTv.fromJson(data);
  }

  Future<List<Result>> getUpComing() async {
    final dio = Dio();
    final response = await dio.get('$baseUrl/movie/upcoming?api_key=$apiKey');
    if (response.statusCode != 200) {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
      // return;
      throw ("Status Error");
    } // Response decode as List<Map<String, dynamic>>
    final List result = jsonDecode(response.toString())['results'];
    return result.map(((e) => Result.fromJson(e))).toList();
  }

  Future<LatestMovie> getLatest() async {
    final dio = Dio();
    final response = await dio.get('$baseUrl/movie/latest?api_key=$apiKey');

    var data = jsonDecode(response.toString()) as Map<String, dynamic>;
    return LatestMovie.fromJson(data);
  }
}
