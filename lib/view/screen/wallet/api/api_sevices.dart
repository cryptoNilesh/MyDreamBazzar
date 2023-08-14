
// import 'package:http/http.dart' as http;
// class AnimeServices {
//   static Future<AnimeList?> fetchAnimeList() async {
//     final response =
//         await http.get(Uri.parse("https://api.jikan.moe/v4/anime"));
//     if (response.statusCode == 200) {
//       final data = response.body;
//       return animeListFromJson(data);
//     } else {
//       return null;
//     }
//   }
// }