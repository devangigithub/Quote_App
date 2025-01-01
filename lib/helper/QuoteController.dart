import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quoteapp/helper/bdhelper.dart';
import 'package:quoteapp/helper/modal_class.dart';

class QuoteController extends GetxController {
  RxList<Quote> quotes = <Quote>[].obs;
  RxList<Quote> favorites = <Quote>[].obs;
  RxBool isLoading = false.obs;
  RxInt page = 1.obs;
  RxList<Map<String, String>> favoritess = <Map<String, String>>[].obs;
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    fetchQuotesFromDatabase();
    fetchFavorites();
    fetchQuotesFromApi();
  }

  Future<void> fetchQuotesFromDatabase() async {
    final data = await dbHelper.getQuotes();
    quotes.assignAll(data);
  }

  Future<void> fetchFavorites() async {
    final data = await dbHelper.getFavoriteQuotes();
    favorites.assignAll(data);
  }

  Future<void> fetchQuotesFromApi() async {
    isLoading.value = true;
    final url = Uri.parse('http://api.quotable.io/quotes?page=${page.value}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> apiQuotes = json.decode(response.body)['results'];

        final List<Quote> formattedQuotes = apiQuotes.map((quote) {
          return Quote(text: quote['content'], author: quote['author']);
        }).toList();

        for (var quote in formattedQuotes) {
          await dbHelper.insertQuote(quote);
        }

        await fetchQuotesFromDatabase();
      } else {
        print('API call failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching quotes from API: $e');
    } finally {
      isLoading.value = false;
      page.value++;
    }
  }


  Future<void> addQuoteToFavorites(Quote quote) async {
    if (quote.isFavorite == 0) {
      await dbHelper.updateFavoriteStatus(quote.id!, 1);
      await fetchFavorites();
    }
  }


  Future<void> removeQuoteFromFavorites(Quote quote) async {
    if (quote.isFavorite == 1) {
      await dbHelper.updateFavoriteStatus(quote.id!, 0);
      await fetchFavorites();
    }
  }


  Future<void> updateQuote(int id, String newText, String newAuthor) async {
    await dbHelper.updateQuote(id, newText, newAuthor);
    await fetchQuotesFromDatabase();
    await fetchFavorites();
  }

}