// import 'package:get/get.dart';
// class AnimeController extends GetxController {
//   final isLoading = true.obs;
//   var animelist = <Datum>[].obs;
//   @override
//   void onInit() {
//     fetchanimelist();
//     super.onInit();
//   }
//   void fetchanimelist() async {
//     await Future.delayed(const Duration(seconds: 1));
//     isLoading(true);
//     try {
//       var anime = (await AnimeServices.fetchAnimeList());
//       if (anime != null) {
//         animelist.value = anime.data.cast<Datum>();
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
// }