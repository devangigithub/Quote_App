import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quoteapp/helper/QuoteController.dart';

class FavoritesPage extends StatelessWidget {
  final QuoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(onPressed: (){ Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.black,
        title: Text(
          'Favorite Quotes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return Center(child: Text('No favorite quotes.',style: TextStyle(color: Colors.white54),));
        }

        return ListView.separated(
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final quote = controller.favorites[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListTile(
                tileColor: Colors.white10,
                title: Text(
                  quote.text,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  quote.author,
                  style: TextStyle(
                      color: Colors.white54, fontStyle: FontStyle.italic),
                ),
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
                    await controller.fetchQuotesFromDatabase();
                  },
                ),
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
