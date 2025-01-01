class Quote {
  final int? id;
  final String text;
  final String author;
  final int isFavorite;

  Quote({this.id, required this.text, required this.author, this.isFavorite = 0});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'author': author,
      'isFavorite': isFavorite,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'],
      text: map['text'],
      author: map['author'],
      isFavorite: map['isFavorite'],
    );
  }
}
