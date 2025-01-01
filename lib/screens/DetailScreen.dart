import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quoteapp/helper/modal_class.dart';
import 'package:quoteapp/helper/QuoteController.dart';

class DetailScreen extends StatelessWidget {
  final Quote quote;
  final QuoteController controller = Get.find();

  DetailScreen({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(onPressed: (){ Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.black,
        title: Text('Quote Details',style: TextStyle(color: Colors.white),),
        actions: [
         
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                quote.text,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                '- ${quote.author}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic,color: Colors.white54),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        
            _showEditDialog(context);
                 
      },backgroundColor: Colors.white,child: Icon(Icons.edit),),
    );
  }

  void _showEditDialog(BuildContext context) {
    final TextEditingController textController = TextEditingController(text: quote.text);
    final TextEditingController authorController = TextEditingController(text: quote.author);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Quote'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(labelText: 'Quote Text'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final updatedText = textController.text.trim();
                final updatedAuthor = authorController.text.trim();

                if (updatedText.isNotEmpty && updatedAuthor.isNotEmpty) {
                  await controller.updateQuote(
                    quote.id!,
                    updatedText,
                    updatedAuthor,
                  );
                  Navigator.of(context).pop();
                } else {
                  Get.snackbar('Error', 'Both fields must be filled!',
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

}
