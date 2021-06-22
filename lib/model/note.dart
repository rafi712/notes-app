/// Class ini merupakan model dari semua catatan
/// Contoh constructor: 
/// ```
/// Note(
///   id: 1, 
///   title: (title == '') ? null: 'judul catatan', 
///   description: 'deskripsi catatan', 
///   createdAt: DateTime.now(),
/// )
/// ```
class Note {
  /// Id akan di generate otomatis (increment) melalui note provider class
  int id;
  /// Jika title tidak ada, maka tidak akan ditampilkan, atau dianggap null
  String? title;
  String description;
  String createdAt;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt
  });
}
