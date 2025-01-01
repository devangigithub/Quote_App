import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quoteapp/helper/QuoteController.dart';
import 'package:quoteapp/screens/Favorites%20Page.dart';

import 'package:quoteapp/screens/DetailScreen.dart';

class HomeScreen extends StatelessWidget {
  final QuoteController controller = Get.put(QuoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Quotes',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Get.to(() => FavoritesPage());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: Colors.white,));
        }

        if (controller.quotes.isEmpty) {
          return Center(child: Text('No quotes available.'));
        }

        return ListView.separated(
          itemCount: controller.quotes.length,
          itemBuilder: (context, index) {
            final quote = controller.quotes[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListTile(
                tileColor: Colors.white10,
                title: Text(quote.text,style: TextStyle(
                  color: Colors.white
                ),),
                subtitle: Text(quote.author,style: TextStyle(
                    color: Colors.white54,fontStyle: FontStyle.italic
                ),),
                trailing: IconButton(
                  icon: Icon(
                    quote.isFavorite == 1
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: quote.isFavorite == 1 ? Colors.red : null,
                  ),
                  onPressed: () async {
                    if (quote.isFavorite == 0) {
                      // Add to favorites
                      await controller.addQuoteToFavorites(quote);
                    } else {
                      // Remove from favorites
                      await controller.removeQuoteFromFavorites(quote);
                    }
                    await controller
                        .fetchQuotesFromDatabase(); // Refresh the quotes list to reflect changes
                  },
                ),
                onTap: () {
                  Get.to(() => DetailScreen(
                        quote: controller.quotes[index],
                      ));
                },
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10,
            );
          },
        );
      }),
    );
  }
}
