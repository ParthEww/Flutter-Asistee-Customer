
class AddressType {
  final String title;
  final String image_path;
  bool is_selected;

  AddressType({
    required this.title,
    required this.image_path,
    this.is_selected = false,
  });
}
